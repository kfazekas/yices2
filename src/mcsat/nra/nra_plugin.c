/*
 * The Yices SMT Solver. Copyright 2015 SRI International.
 *
 * This program may only be used subject to the noncommercial end user
 * license agreement which is downloadable along with this program.
 */
 
#include <poly/polynomial.h>
#include <poly/polynomial_context.h>
#include <poly/variable_db.h>
#include <poly/feasibility_set.h>
#include <poly/variable_order.h>
#include <poly/variable_list.h>
#include <poly/upolynomial.h>

#include "mcsat/nra/nra_plugin.h"
#include "mcsat/nra/nra_plugin_internal.h"
#include "mcsat/nra/libpoly_utils.h"
#include "mcsat/tracing.h"
#include "mcsat/utils/scope_holder.h"
#include "mcsat/utils/int_mset.h"
#include "mcsat/watch_list_manager.h"
#include "mcsat/nra/poly_constraint.h"
#include "mcsat/nra/nra_plugin_explain.h"

#include "terms/terms.h"
#include "utils/int_array_sort2.h"
#include "terms/term_explorer.h"

static
void nra_plugin_stats_init(nra_plugin_t* nra) {
  // Add statistics
  nra->stats.propagations = statistics_new_uint32(nra->ctx->stats, "mcsat::nra::propagations");
  nra->stats.conflicts = statistics_new_uint32(nra->ctx->stats, "mcsat::nra::conflicts");
  nra->stats.conflicts_int = statistics_new_uint32(nra->ctx->stats, "mcsat::nra::conflicts_int");
  nra->stats.constraints_attached = statistics_new_uint32(nra->ctx->stats, "mcsat::nra::constraints_attached");
}

static
void nra_plugin_heuristics_init(nra_plugin_t* nra) {
  // Initialize heuristic
}

static
void nra_plugin_construct(plugin_t* plugin, plugin_context_t* ctx) {
  nra_plugin_t* nra = (nra_plugin_t*) plugin;

  nra->ctx = ctx;
  nra->last_decided_and_unprocessed = variable_null;
  nra->trail_i = 0;
  nra->conflict_variable = variable_null;

  watch_list_manager_construct(&nra->wlm, ctx->var_db);
  init_int_hmap(&nra->constraint_unit_info, 0);
  init_int_hmap(&nra->constraint_unit_var, 0);

  init_ivector(&nra->processed_variables, 0);
  nra->processed_variables_size = 0;

  scope_holder_construct(&nra->scope);

  init_int_hmap(&nra->lp_data.mcsat_to_lp_var_map, 0);
  init_int_hmap(&nra->lp_data.lp_to_mcsat_var_map, 0);

  // Constraint db
  nra->constraint_db = poly_constraint_db_new(nra);

  // Feasible sets
  nra->feasible_set_db = feasible_set_db_new(ctx);

  // lipoly init
  nra->lp_data.lp_var_db = lp_variable_db_new();
  nra->lp_data.lp_var_order = lp_variable_order_new();
  nra->lp_data.lp_var_order_size = 0;
  nra->lp_data.lp_ctx = lp_polynomial_context_new(lp_Z, nra->lp_data.lp_var_db, nra->lp_data.lp_var_order);
  nra->lp_data.lp_assignment = lp_assignment_new(nra->lp_data.lp_var_db);

  // Tracing in libpoly
  if (false) {
    lp_trace_enable("coefficient");
    lp_trace_enable("coefficient::roots");
    lp_trace_enable("polynomial");
    lp_trace_enable("polynomial::check_input");
  }

  // Trace pscs
  if (false) {
    lp_trace_enable("polynomial::expensive");
  }

  // Atoms
  ctx->request_term_notification_by_kind(ctx, ARITH_EQ_ATOM);
  ctx->request_term_notification_by_kind(ctx, ARITH_GE_ATOM);
  ctx->request_term_notification_by_kind(ctx, ARITH_BINEQ_ATOM);
  ctx->request_term_notification_by_kind(ctx, ARITH_ROOT_ATOM);

  // Terms
  ctx->request_term_notification_by_kind(ctx, ARITH_CONSTANT);
  ctx->request_term_notification_by_kind(ctx, ARITH_POLY);
  ctx->request_term_notification_by_kind(ctx, POWER_PRODUCT);

  // Types (we add INT because it's there for ITEs over int constants)
  ctx->request_term_notification_by_type(ctx, REAL_TYPE);
  ctx->request_term_notification_by_type(ctx, INT_TYPE);
  ctx->request_decision_calls(ctx, REAL_TYPE);
  ctx->request_decision_calls(ctx, INT_TYPE);

  init_rba_buffer(&nra->buffer, ctx->terms->pprods);
  init_term_manager(&nra->tm, nra->ctx->terms);
  nra->tm.simplify_ite = false;

  nra->conflict_variable = variable_null;
  nra->conflict_variable_int = variable_null;

  nra_plugin_stats_init(nra);
  nra_plugin_heuristics_init(nra);
}

static
void nra_plugin_destruct(plugin_t* plugin) {
  nra_plugin_t* nra = (nra_plugin_t*) plugin;

  watch_list_manager_destruct(&nra->wlm);
  delete_int_hmap(&nra->constraint_unit_info);
  delete_int_hmap(&nra->constraint_unit_var);
  delete_ivector(&nra->processed_variables);
  scope_holder_destruct(&nra->scope);

  delete_int_hmap(&nra->lp_data.mcsat_to_lp_var_map);
  delete_int_hmap(&nra->lp_data.lp_to_mcsat_var_map);

  poly_constraint_db_delete(nra->constraint_db);

  feasible_set_db_delete(nra->feasible_set_db);

  lp_polynomial_context_detach(nra->lp_data.lp_ctx);
  lp_variable_order_detach(nra->lp_data.lp_var_order);
  lp_variable_db_detach(nra->lp_data.lp_var_db);
  lp_assignment_delete(nra->lp_data.lp_assignment);

  delete_rba_buffer(&nra->buffer);
  delete_term_manager(&nra->tm);
}

static
bool nra_plugin_trail_variable_compare(void *data, variable_t t1, variable_t t2) {
  const mcsat_trail_t* trail;
  bool t1_has_value, t2_has_value;
  uint32_t t1_level, t2_level;

  trail = data;

  // We compare variables based on the trail level, unassigned to the front,
  // then assigned ones by decreasing level

  // Literals with no value
  t1_has_value = trail_has_value(trail, t1);
  t2_has_value = trail_has_value(trail, t2);
  if (!t1_has_value && !t2_has_value) {
    // Both have no value, just order by variable
    return t1 < t2;
  }

  // At least one has a value
  if (!t1_has_value) {
    // t1 < t2, goes to front
    return true;
  }
  if (!t2_has_value) {
    // t2 < t1, goes to front
    return false;
  }

  // Both literals have a value, sort by decreasing level
  t1_level = trail_get_level(trail, t1);
  t2_level = trail_get_level(trail, t2);
  if (t1_level != t2_level) {
    // t1 > t2 goes to front
    return t1_level > t2_level;
  } else {
    return t1 < t2;
  }
}

static
void nra_plugin_process_fully_assigned_constraint(nra_plugin_t* nra, trail_token_t* prop, variable_t cstr_var) {

  uint32_t cstr_level;
  const poly_constraint_t* cstr;
  const mcsat_value_t* cstr_value;

  assert(!trail_has_value(nra->ctx->trail, cstr_var));

  if (ctx_trace_enabled(nra->ctx, "nra::evaluate")) {
    trail_print(nra->ctx->trail, ctx_trace_out(nra->ctx));
  }

  // Get the constraint
  cstr = poly_constraint_db_get(nra->constraint_db, cstr_var);

  // Evaluate
  cstr_value = poly_constraint_evaluate(cstr, 0, nra, &cstr_level);

  // Propagate
  if (cstr_value) {
    bool ok = prop->add_at_level(prop, cstr_var, cstr_value, cstr_level);
    (void)ok;
    assert(ok);
  }

  if (ctx_trace_enabled(nra->ctx, "nra::evaluate")) {
    trail_print(nra->ctx->trail, ctx_trace_out(nra->ctx));
  }
}

static
void nra_plugin_new_term_notify(plugin_t* plugin, term_t t, trail_token_t* prop) {

  uint32_t i;
  nra_plugin_t* nra = (nra_plugin_t*) plugin;

  if (ctx_trace_enabled(nra->ctx, "mcsat::new_term")) {
    ctx_trace_printf(nra->ctx, "nra_plugin_new_term_notify: ");
    ctx_trace_term(nra->ctx, t);
  }

  assert(!is_neg_term(t));

  // The variable
  variable_t t_atom_var = variable_db_get_variable(nra->ctx->var_db, t);

  // The vector to collect variables
  int_mset_t t_variables;
  int_mset_construct(&t_variables, variable_null);
  bool is_constraint = nra_plugin_get_literal_variables(nra, t, &t_variables);

  // Setup the constraint
  if (is_constraint) {

    // Get the list of variables
    ivector_t* t_variables_list = int_mset_get_list(&t_variables);

    assert(t_variables_list->size > 0);

    // Register all the variables to libpoly (these are mcsat_variables)
    for (i = 0; i < t_variables_list->size; ++ i) {
      if (!nra_plugin_variable_has_lp_variable(nra, t_variables_list->data[i])) {
        nra_plugin_add_lp_variable(nra, t_variables_list->data[i]);
      }
    }

    // Sort variables by trail index
    int_array_sort2(t_variables_list->data, t_variables_list->size, (void*) nra->ctx->trail, nra_plugin_trail_variable_compare);

    if (TRACK_CONSTRAINT(t_atom_var) || ctx_trace_enabled(nra->ctx, "mcsat::new_term")) {
      ctx_trace_printf(nra->ctx, "nra_plugin_new_term_notify: vars: \n");
      for (i = 0; i < t_variables_list->size; ++ i) {
        ctx_trace_term(nra->ctx, variable_db_get_term(nra->ctx->var_db, t_variables_list->data[i]));
      }
    }

    // Make the variable list
    variable_list_ref_t var_list = watch_list_manager_new_list(&nra->wlm, t_variables_list->data, t_variables_list->size, t_atom_var);

    // Add first variable to watch list
    watch_list_manager_add_to_watch(&nra->wlm, var_list, t_variables_list->data[0]);

    // Add second variable to watch list
    if (t_variables_list->size > 1) {
      watch_list_manager_add_to_watch(&nra->wlm, var_list, t_variables_list->data[1]);
    }

    // Check the current status of the constraint
    variable_t top_var = t_variables_list->data[0];
    const mcsat_trail_t* trail = nra->ctx->trail;
    constraint_unit_info_t unit_status = CONSTRAINT_UNKNOWN;
    if (trail_has_value(trail, top_var)) {
      // All variables assigned
      if (top_var != nra->last_decided_and_unprocessed) {
        unit_status = CONSTRAINT_FULLY_ASSIGNED;
      } else {
        // We didn't process the decision yet, so keep it unit
        unit_status = CONSTRAINT_UNIT;
      }
    } else {
      if (t_variables_list->size == 1) {
        // Single variable, unassigned => unit
        unit_status = CONSTRAINT_UNIT;
      } else if (trail_has_value(nra->ctx->trail, t_variables_list->data[1])) {
        // Second one is assigned, so we're unit (unless, we didn't process it yet)
        if (top_var != nra->last_decided_and_unprocessed) {
          unit_status = CONSTRAINT_UNIT;
        } else {
          unit_status = CONSTRAINT_UNKNOWN;
        }
      }
    }

    // Set the status of the constraint
    nra_plugin_set_unit_info(nra, t_atom_var, unit_status == CONSTRAINT_UNIT ? top_var : variable_null, unit_status);

    // Add the constraint to the database
    poly_constraint_db_add(nra->constraint_db, t_atom_var);

    // Propagate if fully assigned
    if (unit_status == CONSTRAINT_FULLY_ASSIGNED) {
      nra_plugin_process_fully_assigned_constraint(nra, prop, t_atom_var);
    }

    // Stats
    (*nra->stats.constraints_attached) ++;
  } else {
    // Add the variable to libpoly
    if (!nra_plugin_term_has_lp_variable(nra, t)) {
      nra_plugin_add_lp_variable_from_term(nra, t);
    }
  }

  // Remove the variables vector
  int_mset_destruct(&t_variables);
}

static
void nra_plugin_process_unit_constraint(nra_plugin_t* nra, trail_token_t* prop, variable_t constraint_var) {

  bool feasible;

  if (TRACK_CONSTRAINT(constraint_var) || ctx_trace_enabled(nra->ctx, "nra::propagate")) {
    ctx_trace_printf(nra->ctx, "nra: processing unit constraint :\n");
    ctx_trace_term(nra->ctx, variable_db_get_term(nra->ctx->var_db, constraint_var));
  }

  // Process if constraint is assigned
  if (trail_has_value(nra->ctx->trail, constraint_var)) {
    // Get the constraint value
    bool constraint_value = trail_get_value(nra->ctx->trail, constraint_var)->b;

    // Get the constraint
    const poly_constraint_t* constraint = poly_constraint_db_get(nra->constraint_db, constraint_var);

    // Variable of the constraint
    lp_variable_t lp_x = poly_constraint_get_top_variable(constraint);
    variable_t x = nra_plugin_get_variable_from_lp_variable(nra, lp_x);

    // Unit variable should not be assigned
    assert(!trail_has_value(nra->ctx->trail, x));

    if (TRACK_VAR(x)) {
      fprintf(stderr, "Processing constraint unit in tracked var.\n");
      ctx_trace_term(nra->ctx, variable_db_get_term(nra->ctx->var_db, constraint_var));
    }

    // Compute the feasible set
    lp_feasibility_set_t* constraint_feasible = poly_constraint_get_feasible_set(constraint, nra->lp_data.lp_assignment, !constraint_value);

    if (TRACK_VAR(x) || ctx_trace_enabled(nra->ctx, "nra::propagate")) {
      ctx_trace_printf(nra->ctx, "nra: constraint_feasible = ");
      lp_feasibility_set_print(constraint_feasible, ctx_trace_out(nra->ctx));
      ctx_trace_printf(nra->ctx, "\n");
    }

    // Update the infeasible intervals
    feasible = feasible_set_db_update(nra->feasible_set_db, x, constraint_feasible, &constraint_var, 1);

    if (TRACK_VAR(x) || ctx_trace_enabled(nra->ctx, "nra::propagate")) {
      ctx_trace_printf(nra->ctx, "nra: new feasible = ");
      lp_feasibility_set_print(feasible_set_db_get(nra->feasible_set_db, x), ctx_trace_out(nra->ctx));
      ctx_trace_printf(nra->ctx, "\n");
    }

    // If the intervals are empty, we have a conflict
    if (!feasible) {
      nra_plugin_report_conflict(nra, prop, x);
    } else {
      // If the variable is integer, check that is has an integer solution
      if (nra->conflict_variable_int == variable_null && variable_db_is_int(nra->ctx->var_db, x)) {
        // Check if there is an integer value
        lp_value_t v;
        lp_value_construct_none(&v);
        lp_feasibility_set_pick_value(feasible_set_db_get(nra->feasible_set_db, x), &v);
        if (!lp_value_is_integer(&v)) {
          nra->conflict_variable_int = x;
        }
        lp_value_destruct(&v);
      }
    }
  }
}

/**
 * The variable has been assigned, look for constraints that become unit.
 */
static
void nra_plugin_process_variable_assignment(nra_plugin_t* nra, trail_token_t* prop, variable_t var) {

  remove_iterator_t it;
  variable_list_ref_t var_list_ref;
  variable_t* var_list;
  variable_t* var_list_it;

  // The trail
  const mcsat_trail_t* trail = nra->ctx->trail;

  assert(trail_is_consistent(trail));

  // Mark the variable as processed
  ivector_push(&nra->processed_variables, var);
  nra->processed_variables_size ++;

  // Check if we have processed our last decision
  if (var == nra->last_decided_and_unprocessed) {
    nra->last_decided_and_unprocessed = variable_null;
  }

  if (TRACK_VAR(var) || ctx_trace_enabled(nra->ctx, "nra::propagate")) {
    ctx_trace_printf(nra->ctx, "nra: processing var assignment of :\n");
    ctx_trace_term(nra->ctx, variable_db_get_term(nra->ctx->var_db, var));
  }

  // Add to the lp model and context
  lp_variable_t lp_var = nra_plugin_get_lp_variable(nra, var);
  lp_assignment_set_value(nra->lp_data.lp_assignment, lp_var, &trail_get_value(trail, var)->lp_value);
  lp_variable_order_push(nra->lp_data.lp_var_order, lp_var);
  nra->lp_data.lp_var_order_size ++;

  if (TRACK_VAR(var) || ctx_trace_enabled(nra->ctx, "nra::propagate")) {
    ctx_trace_printf(nra->ctx, "nra: var order :");
    lp_variable_order_print(nra->lp_data.lp_var_order, nra->lp_data.lp_var_db, ctx_trace_out(nra->ctx));
    ctx_trace_printf(nra->ctx, "\n");
  }

  if (ctx_trace_enabled(nra->ctx, "nra::wlm")) {
    watch_list_manager_print(&nra->wlm, ctx_trace_out(nra->ctx));
  }

  // Get the watch-list
  remove_iterator_construct(&it, &nra->wlm, var);

  // Go through all constraints where this variable appears
  while (!remove_iterator_done(&it)) {

    // Get the variables of the constraint
    var_list_ref = remove_iterator_get_list_ref(&it);
    var_list = watch_list_manager_get_list(&nra->wlm, var_list_ref);

    // Constraint variable
    variable_t constraint_var = watch_list_manager_get_constraint(&nra->wlm, var_list_ref);

    if (TRACK_CONSTRAINT(constraint_var) || TRACK_VAR(var) || ctx_trace_enabled(nra->ctx, "nra::propagate")) {
      ctx_trace_printf(nra->ctx, "nra: processing constraint :");
      ctx_trace_term(nra->ctx, variable_db_get_term(nra->ctx->var_db, constraint_var));

      ctx_trace_printf(nra->ctx, "nra: var_list :");
      var_list_it = var_list;
      while (*var_list_it != variable_null) {
        ctx_trace_term(nra->ctx, variable_db_get_term(nra->ctx->var_db, *var_list_it));
        var_list_it ++;
      }
    }

    // Put the variable to [1] so that [0] is the unit one
    if (var_list[0] == var && var_list[1] != variable_null) {
      var_list[0] = var_list[1];
      var_list[1] = var;
    }

    // Find a new watch (start from [2])
    var_list_it = var_list + 1;
    if (*var_list_it != variable_null) {
      for (++ var_list_it; *var_list_it != variable_null; ++ var_list_it) {
        if (!trail_has_value(trail, *var_list_it)) {
          // Swap with var_list[1]
          var_list[1] = *var_list_it;
          *var_list_it = var;
          // Add to new watch
          watch_list_manager_add_to_watch(&nra->wlm, var_list_ref, var_list[1]);
          // Don't watch this one
          remove_iterator_next_and_remove(&it);
          break;
        }
      }
    }

    if (*var_list_it == variable_null) {
      if (ctx_trace_enabled(nra->ctx, "nra::propagate")) {
        ctx_trace_printf(nra->ctx, "no watch found\n");
      }
      if (!trail_has_value(trail, *var_list)) {
        // We're unit
        nra_plugin_set_unit_info(nra, constraint_var, *var_list, CONSTRAINT_UNIT);
        // Process the constraint
        if (trail_is_consistent(trail)) {
          nra_plugin_process_unit_constraint(nra, prop, constraint_var);
        }
      } else {
        // Fully assigned
        nra_plugin_set_unit_info(nra, constraint_var, variable_null, CONSTRAINT_FULLY_ASSIGNED);
        // Evaluate the constraint and propagate (if not assigned already)
        if (trail_is_consistent(trail) && !trail_has_value(trail, constraint_var)) {
          uint32_t constraint_level = 0;
          const poly_constraint_t* constraint = poly_constraint_db_get(nra->constraint_db, constraint_var);
          const mcsat_value_t* constraint_value = poly_constraint_evaluate(constraint, var_list, nra, &constraint_level);
          // Propagate
          if (constraint_value) {
            prop->add_at_level(prop, constraint_var, constraint_value, constraint_level);
          }
        } else {
          // TODO: assert check that the values are the same
        }
      }
      // Keep the watch
      remove_iterator_next_and_keep(&it);
    }
  }

  // Done, destruct the iterator
  remove_iterator_destruct(&it);
}


static
void nra_plugin_check_assignment(nra_plugin_t* nra) {

  const mcsat_trail_t* trail = nra->ctx->trail;

  // Go through the trail and check if all assigned are in lp_assignment
  uint32_t i;
  for (i = 0; i < trail->elements.size; ++ i) {
    variable_t x = trail->elements.data[i];
    if (x == nra->last_decided_and_unprocessed) {
      continue;
    }
    const mcsat_value_t* value = trail_get_value(trail, x);
    if (value->type == VALUE_LIBPOLY) {
      lp_variable_t x_lp = nra_plugin_get_lp_variable(nra, x);
      const lp_value_t* value_lp = lp_assignment_get_value(nra->lp_data.lp_assignment, x_lp);
      int cmp = lp_value_cmp(&value->lp_value, value_lp);
      (void)cmp;
      assert(cmp == 0);
    }
  }

  // Go through lp_assignment and check if they are assigned in trail
  const lp_variable_list_t* order = lp_variable_order_get_list(nra->lp_data.lp_var_order);
  for (i = 0; i < order->list_size; ++ i) {
    lp_variable_t x_lp = order->list[i];
    variable_t x = nra_plugin_get_variable_from_lp_variable(nra, x_lp);
    const mcsat_value_t* value = trail_get_value(trail, x);
    const lp_value_t* value_lp = lp_assignment_get_value(nra->lp_data.lp_assignment, x_lp);
    int cmp = lp_value_cmp(&value->lp_value, value_lp);
    (void)cmp;
    assert(cmp == 0);
  }
}


/**
 * Propagates the trail with BCP. When done, either the trail is fully
 * propagated, or the trail is in an inconsistent state.
 */
static
void nra_plugin_propagate(plugin_t* plugin, trail_token_t* prop) {
  nra_plugin_t* nra = (nra_plugin_t*) plugin;

  variable_t var;

  if (ctx_trace_enabled(nra->ctx, "nra::check_assignment")) {
    nra_plugin_check_assignment(nra);
  }

  // Context
  const mcsat_trail_t* trail = nra->ctx->trail;
  variable_db_t* var_db = nra->ctx->var_db;

  if (ctx_trace_enabled(nra->ctx, "nra::propagate")) {
    ctx_trace_printf(nra->ctx, "trail:\n");
    trail_print(trail, nra->ctx->tracer->file);
  }

  // Propagate
  for(; trail_is_consistent(trail) && nra->trail_i < trail_size(trail); ++ nra->trail_i) {
    // Current trail element
    var = trail_at(trail, nra->trail_i);
    if (TRACK_VAR(var) || TRACK_CONSTRAINT(var)) {
      fprintf(stderr, "Processing assignment of %d in the trail.\n", var);
    }
    if (variable_db_is_real(var_db, var) || variable_db_is_int(var_db, var)) {
      // Real variables, detect if the constraint is unit
      nra_plugin_process_variable_assignment(nra, prop, var);
    } else if (nra_plugin_get_unit_info(nra, var) == CONSTRAINT_UNIT) {
      // Process any unit constraints
      nra_plugin_process_unit_constraint(nra, prop, var);
    }
  }

  if (trail_is_consistent(trail) && nra->conflict_variable_int != variable_null) {
    nra_plugin_report_int_conflict(nra, prop, nra->conflict_variable_int);
  }

  if (ctx_trace_enabled(nra->ctx, "nra::check_assignment")) {
    nra_plugin_check_assignment(nra);
  }
}

static
void nra_plugin_decide(plugin_t* plugin, variable_t x, trail_token_t* decide_token, bool must) {
  nra_plugin_t* nra = (nra_plugin_t*) plugin;

  assert(variable_db_is_real(nra->ctx->var_db, x) || variable_db_is_int(nra->ctx->var_db, x));

  // Get the feasibility set
  lp_feasibility_set_t* feasible = feasible_set_db_get(nra->feasible_set_db, x);

  if (TRACK_VAR(x) || ctx_trace_enabled(nra->ctx, "nra::decide")) {
    ctx_trace_printf(nra->ctx, "decide on ");
    variable_db_print_variable(nra->ctx->var_db, x, ctx_trace_out(nra->ctx));
    ctx_trace_printf(nra->ctx, "[%d] at level %d\n", x, nra->ctx->trail->decision_level);
    if (feasible) {
      ctx_trace_printf(nra->ctx, "feasible :");
      feasible_set_db_print_var(nra->feasible_set_db, x, ctx_trace_out(nra->ctx));
      ctx_trace_printf(nra->ctx, "\n");
    } else {
      ctx_trace_printf(nra->ctx, "feasible : ALL\n");
    }
  }

  // Pick a value from the set
  lp_value_t x_value;
  lp_rational_t x_value_default;
  lp_rational_construct_from_int(&x_value_default, 0, 1);
  lp_value_construct(&x_value, LP_VALUE_RATIONAL, &x_value_default);
  // lp_value_construct_zero(&x_value);
  lp_rational_destruct(&x_value_default);

  // See if the cached value fits
  bool using_cached = false;
  if (trail_has_cached_value(nra->ctx->trail, x)) {
    const mcsat_value_t* x_cached_value = trail_get_cached_value(nra->ctx->trail, x);
    if (feasible == NULL || lp_feasibility_set_contains(feasible, &x_cached_value->lp_value)) {
      using_cached = true;
      lp_value_assign(&x_value, &x_cached_value->lp_value);
    }
  }

  // If the set is 0, we can pick any value, including 0
  if (!using_cached && feasible != NULL) {
    // Otherwise pick from the set
    lp_feasibility_set_pick_value(feasible, &x_value);
  }

  // Decide if not too complex of a rational number
  bool decide = true;
  if (!must) {
    if (!lp_value_is_rational(&x_value)) {
      if (lp_upolynomial_degree(x_value.value.a.f) > 2) {
        decide = false;
      }
    }
  }

  if (decide) {

    if (ctx_trace_enabled(nra->ctx, "nra::decide")) {
      ctx_trace_printf(nra->ctx, "decided on ");
      variable_db_print_variable(nra->ctx->var_db, x, ctx_trace_out(nra->ctx));
      ctx_trace_printf(nra->ctx, "[%d]: ", x);
      lp_value_print(&x_value, ctx_trace_out(nra->ctx));
      ctx_trace_printf(nra->ctx, "\n");
    }

    // Make an mcsat value
    mcsat_value_t value;
    mcsat_value_construct_lp_value(&value, &x_value);

    if (variable_db_is_int(nra->ctx->var_db, x)) {
      assert(lp_value_is_integer(&x_value));
    }

    // Decide the value
    decide_token->add(decide_token, x, &value);

    // Remember that we've decided this guy
    nra->last_decided_and_unprocessed = x;

    mcsat_value_destruct(&value);
  }

  lp_value_destruct(&x_value);
}

/**
 * Check conflicts in core (set of variables).
 */
static
void nra_plugin_check_conflict(nra_plugin_t* nra, ivector_t* core) {
  uint32_t i;

  static uint32_t count = 0;
  count ++;

  fprintf(stderr, "CONFLICT %u\n", count);

  char filename[100];
  sprintf(filename, "conflict_%u.m", count);

  FILE* out = fopen(filename, "w");

  // Variables in the conflict
  int_mset_t core_vars;
  int_mset_construct(&core_vars, variable_null);

  // The trail
  const mcsat_trail_t* trail = nra->ctx->trail;

  // Variable database
  const variable_db_t* var_db = nra->ctx->var_db;

  // Get the constraint variables
  for (i = 0; i < core->size; ++ i) {
    variable_t constraint_var = core->data[i];
    term_t constraint_term = variable_db_get_term(var_db, constraint_var);
    nra_plugin_get_literal_variables(nra, constraint_term, &core_vars);
  }

  // Variables in the assignment
  ivector_t* core_vars_list = int_mset_get_list(&core_vars);

  lp_variable_t free_var = lp_variable_null;

  // Variable assignment
  for (i = 0; i < core_vars_list->size; ++ i) {
    variable_t x = core_vars_list->data[i];
    // Don't consider ones we didn't process yet
    if (x == nra->last_decided_and_unprocessed) {
      continue;
    }
    lp_variable_t x_lp = nra_plugin_get_lp_variable(nra, x);
    // Ignore unassigned too
    if (!trail_has_value(trail, x)) {
      assert(free_var == lp_variable_null);
      free_var = x_lp;
      continue;
    }
    const mcsat_value_t* x_value = trail_get_value(trail, x);
    switch (x_value->type) {
    case VALUE_NONE:
      assert(free_var == lp_variable_null);
      free_var = x_lp;
      continue;
      break;
    case VALUE_LIBPOLY: {
      fprintf(out, "x%zu = ", x_lp);
      const lp_value_t* x_value_lp = &x_value->lp_value;
#ifndef NDEBUG
      const lp_value_t* x_value_lp_in_assignment = lp_assignment_get_value(nra->lp_data.lp_assignment, x_lp);
      assert(lp_value_cmp(x_value_lp, x_value_lp_in_assignment) == 0);
#endif
      if (lp_value_is_rational(x_value_lp)) {
        lp_rational_t q;
        lp_rational_construct(&q);
        lp_value_get_rational(x_value_lp, &q);
        lp_rational_print(&q, out);
        lp_rational_destruct(&q);
      } else {
        lp_value_print(x_value_lp, out);
      }
      fprintf(out, "\n");
      break;
    }
    default:
      assert(false);
    }
  }

  fprintf(out, "check = ");
  if (free_var != lp_variable_null) {
    fprintf(out, "Resolve[Exists[{x%zu},", free_var);
  }

  // Constraints
  for (i = 0; i < core->size; ++ i) {
    fprintf(out, "\\\n\t");
    if (i) {
      fprintf(out, "&& ");
    }
    variable_t constraint_var = core->data[i];
    const poly_constraint_t* constraint = poly_constraint_db_get(nra->constraint_db, constraint_var);
    bool constraint_value = trail_get_boolean_value(trail, constraint_var);
    poly_constraint_print_mathematica(constraint, !constraint_value, out);
  }

  if (free_var != lp_variable_null) {
    fprintf(out, "]]\n");
  } else {
    fprintf(out, "\n");
  }

  fclose(out);
  int_mset_destruct(&core_vars);
}

static
void nra_plugin_get_real_conflict(nra_plugin_t* nra, const int_mset_t* pos, const int_mset_t* neg,
    variable_t x, ivector_t* conflict) {
  size_t i;

  if (TRACK_VAR(x) || ctx_trace_enabled(nra->ctx, "nra::conflict")) {
    ctx_trace_printf(nra->ctx, "nra_plugin_get_conflict(): ");
    ctx_trace_term(nra->ctx, variable_db_get_term(nra->ctx->var_db, x));
  }

  // The assertions on x that are in conflict (as constraint variables)
  ivector_t core, lemma_reasons;
  init_ivector(&core, 0);
  init_ivector(&lemma_reasons, 0);
  feasible_set_db_get_conflict_reasons(nra->feasible_set_db, x, &core, &lemma_reasons);

  if (TRACK_VAR(x) || ctx_trace_enabled(nra->ctx, "nra::conflict")) {
    ctx_trace_printf(nra->ctx, "nra_plugin_get_conflict(): core:\n");
    for (i = 0; i < core.size; ++ i) {
      ctx_trace_printf(nra->ctx, "[%zu] (", i);
      if (trail_has_value(nra->ctx->trail, core.data[i])) {
        mcsat_value_print(trail_get_value(nra->ctx->trail, core.data[i]), ctx_trace_out(nra->ctx));
      }
      ctx_trace_printf(nra->ctx, "): ");
      ctx_trace_term(nra->ctx, variable_db_get_term(nra->ctx->var_db, core.data[i]));
    }
  }

  if (ctx_trace_enabled(nra->ctx, "nra::check_conflict")) {
    nra_plugin_check_conflict(nra, &core);
  }

  // Project
  nra_plugin_explain_conflict(nra, pos, neg, &core, &lemma_reasons, conflict);

  if (TRACK_VAR(x) || ctx_trace_enabled(nra->ctx, "nra::conflict")) {
    ctx_trace_printf(nra->ctx, "nra_plugin_get_conflict(): conflict:\n");
    for (i = 0; i < conflict->size; ++ i) {
      ctx_trace_printf(nra->ctx, "[%zu]: ", i);
      ctx_trace_term(nra->ctx, conflict->data[i]);
    }
  }

  // Remove temps
  delete_ivector(&core);

}

/**
 * Check consistency of given constraint. If inconsistent it returns the conflict.
 */
static
bool nra_plugin_speculate_constraint(nra_plugin_t* nra, int_mset_t* pos, int_mset_t* neg,
    variable_t x, term_t constraint, ivector_t* conflict) {

  term_t constraint_atom = unsigned_term(constraint);
  bool negated = constraint != constraint_atom;
  variable_t constraint_var = variable_db_get_variable(nra->ctx->var_db, constraint_atom);
  poly_constraint_db_add(nra->constraint_db, constraint_var);
  const poly_constraint_t* poly_cstr = poly_constraint_db_get(nra->constraint_db, constraint_var);

  // Check if the constraint is in Boolean conflict
  if (trail_has_value(nra->ctx->trail, constraint_var)) {
    if (trail_get_boolean_value(nra->ctx->trail, constraint_var) == negated) {
      // Constraint value is false, so we just add the Boolean conflict
      ivector_push(conflict, constraint);
      ivector_push(conflict, opposite_term(constraint));
      return false;
    }
  }

  // Compute the feasible set
  lp_feasibility_set_t* constraint_feasible = poly_constraint_get_feasible_set(poly_cstr, nra->lp_data.lp_assignment, negated);

  // Update the infeasible intervals
  bool feasible = feasible_set_db_update(nra->feasible_set_db, x, constraint_feasible, &constraint_var, 1);

  // Add to assumptions
  if (negated) {
    int_mset_add(neg, constraint_var);
  } else {
    int_mset_add(pos, constraint_var);
  }

  // If not feasible, get the conflict
  if (!feasible) {
    // Get the real conflict
    ivector_t constraint_conflict;
    init_ivector(&constraint_conflict, 0);
    nra_plugin_get_real_conflict(nra, pos, neg, x, &constraint_conflict);

    // Copy the conflict (except the assumption into the conflict)
    uint32_t i;
    for (i = 0; i < constraint_conflict.size; ++ i) {
      ivector_push(conflict, constraint_conflict.data[i]);
    }
    delete_ivector(&constraint_conflict);
  }

  // Remove from assumptions not feasible
  if (!feasible) {
    if (negated) {
      int_mset_remove_one(neg, constraint_var);
    } else {
      int_mset_remove_one(pos, constraint_var);
    }
  }

  return feasible;
}

static
void nra_plugin_get_int_conflict(nra_plugin_t* nra, int_mset_t* pos, int_mset_t* neg,
    variable_t x, ivector_t* conflict) {

  // We have an int conflict on x

  // That means that the feasible set is of the form
  //   I1    I2   I3 I4  I5
  //   ( )   ()   ( )()  ()
  //
  // Where each Ik doesn't allow an integer value.
  //
  // We do the splits manually and collect the explanation

  lp_value_t v;
  lp_value_construct_none(&v);

  term_t x_term = variable_db_get_term(nra->ctx->var_db, x);

  // We'll be making changes, remember state
  feasible_set_db_push(nra->feasible_set_db);

  // Set of constraints that we resolve using Boolean resolution
  int_mset_t to_resolve;
  int_mset_construct(&to_resolve, NULL_TERM);

  for (;;) {

    // Get the first value from the left
    const lp_feasibility_set_t* x_feasible = feasible_set_db_get(nra->feasible_set_db, x);
    if (ctx_trace_enabled(nra->ctx, "nia")) {
      ctx_trace_printf(nra->ctx, "x = ");
      variable_db_print_variable(nra->ctx->var_db, x, ctx_trace_out(nra->ctx));
      ctx_trace_printf(nra->ctx, "\nx_feasible = ");
      lp_feasibility_set_print(x_feasible, ctx_trace_out(nra->ctx));
      ctx_trace_printf(nra->ctx, "\n");
    }
    lp_feasibility_set_pick_first_value(x_feasible, &v);
    if (ctx_trace_enabled(nra->ctx, "nia")) {
      ctx_trace_printf(nra->ctx, "v = ");
      lp_value_print(&v, ctx_trace_out(nra->ctx));
      ctx_trace_printf(nra->ctx, "\n");
    }
    assert(!lp_value_is_integer(&v));

    // Get the floor
    lp_integer_t v_floor;
    lp_integer_construct(&v_floor);
    lp_value_floor(&v, &v_floor);

    // Yices versions of the floor
    rational_t v_floor_rat;
    rational_construct_from_lp_integer(&v_floor_rat, &v_floor);
    term_t v_floor_term = mk_arith_constant(&nra->tm, &v_floor_rat);

    // Remove temp
    lp_integer_destruct(&v_floor);
    q_clear(&v_floor_rat);

    // The constraint
    term_t x_leq_floor = mk_arith_leq(&nra->tm, x_term, v_floor_term);
    int_mset_add(&to_resolve, x_leq_floor);

    // Get the conflict
    feasible_set_db_push(nra->feasible_set_db);
    bool feasible = nra_plugin_speculate_constraint(nra, pos, neg, x, x_leq_floor, conflict);
    assert(!feasible);
    feasible_set_db_pop(nra->feasible_set_db);

    // Get the ceiling
    lp_integer_t v_ceil;
    lp_integer_construct(&v_ceil);
    lp_value_ceiling(&v, &v_ceil);

    // Yices versions of the ceiling
    rational_t v_ceil_rat;
    rational_construct_from_lp_integer(&v_ceil_rat, &v_ceil);
    term_t v_ceil_term = mk_arith_constant(&nra->tm, &v_ceil_rat);

    // Remove temp
    lp_integer_destruct(&v_ceil);
    q_clear(&v_ceil_rat);

    // The constraint
    term_t x_geq_ceil = mk_arith_geq(&nra->tm, x_term, v_ceil_term);
    int_mset_add(&to_resolve, x_geq_ceil);

    // Try it out
    feasible = nra_plugin_speculate_constraint(nra, pos, neg, x, x_geq_ceil, conflict);

    if (ctx_trace_enabled(nra->ctx, "nia")) {
      ctx_trace_printf(nra->ctx, "int_conflict: current conflict:\n");
      uint32_t i;
      for (i = 0; i < conflict->size; ++ i) {
        ctx_trace_printf(nra->ctx, "  ");
        ctx_trace_term(nra->ctx, conflict->data[i]);
      }
    }

    // If not feasible, we're done
    if (!feasible) {
      break;
    }
  }

  // Undo feasibility changes
  feasible_set_db_pop(nra->feasible_set_db);

  // Remove resolved literals
  uint32_t i = 0, to_keep;
  for (i = 0, to_keep = 0; i < conflict->size; ++ i) {
    if (!int_mset_contains(&to_resolve, conflict->data[i])) {
      conflict->data[to_keep ++] = conflict->data[i];
    }
  }
  ivector_shrink(conflict, to_keep);

  if (ctx_trace_enabled(nra->ctx, "nia")) {
    ctx_trace_printf(nra->ctx, "int_conflict: final conflict:\n");
    uint32_t i;
    for (i = 0; i < conflict->size; ++ i) {
      ctx_trace_printf(nra->ctx, "  ");
      ctx_trace_term(nra->ctx, conflict->data[i]);
    }
  }

  // Remove tempss
  int_mset_destruct(&to_resolve);
  lp_value_destruct(&v);
}

static
void nra_plugin_get_conflict(plugin_t* plugin, ivector_t* conflict) {
  nra_plugin_t* nra = (nra_plugin_t*) plugin;

  if (ctx_trace_enabled(nra->ctx, "nra::conflict")) {
    ctx_trace_printf(nra->ctx, "nra_plugin_get_conflict(): START\n");
  }

  int_mset_t pos, neg;
  int_mset_construct(&pos, variable_null);
  int_mset_construct(&neg, variable_null);

  if (nra->conflict_variable != variable_null) {
    nra_plugin_get_real_conflict(nra, &pos, &neg, nra->conflict_variable, conflict);
  } else if (nra->conflict_variable_int != variable_null) {
    nra_plugin_get_int_conflict(nra, &pos, &neg, nra->conflict_variable_int, conflict);
  } else {
    assert(false);
  }

  int_mset_destruct(&pos);
  int_mset_destruct(&neg);

  if (ctx_trace_enabled(nra->ctx, "nra::conflict")) {
    uint32_t i;
    ctx_trace_printf(nra->ctx, "nra_plugin_get_conflict(): END\n");
    for (i = 0; i < conflict->size; ++ i) {
      ctx_trace_term(nra->ctx, conflict->data[i]);
    }
  }
}

static
term_t nra_plugin_explain_propagation(plugin_t* plugin, variable_t var, ivector_t* reasons) {
  nra_plugin_t* nra = (nra_plugin_t*) plugin;

  // We only propagate evaluations, and we explain them using the literal itself
  term_t atom = variable_db_get_term(nra->ctx->var_db, var);
  if (ctx_trace_enabled(nra->ctx, "nra::conflict")) {
    ctx_trace_printf(nra->ctx, "nra_plugin_explain_propagation():\n");
    ctx_trace_term(nra->ctx, atom);
  }
  bool value = trail_get_boolean_value(nra->ctx->trail, var);
  if (ctx_trace_enabled(nra->ctx, "nra::conflict")) {
    ctx_trace_printf(nra->ctx, "assigned to %s\n", value ? "true" : "false");
  }

  if (value) {
    // atom => atom = true
    ivector_push(reasons, atom);
    return bool2term(true);
  } else {
    // neg atom => atom = false
    ivector_push(reasons, opposite_term(atom));
    return bool2term(false);
  }
}

static
bool nra_plugin_explain_evaluation(plugin_t* plugin, term_t t, int_mset_t* vars, mcsat_value_t* value) {
  nra_plugin_t* nra = (nra_plugin_t*) plugin;

  if (value == NULL) {

    // Get all the variables and make sure they are all assigned.
    bool is_constraint = nra_plugin_get_literal_variables(nra, t, vars);
    (void)is_constraint;
    assert(is_constraint);

    // Check if the variables are assigned
    ivector_t* var_list = int_mset_get_list(vars);
    size_t i = 0;
    for (i = 0; i < var_list->size; ++ i) {
      if (!trail_has_value(nra->ctx->trail, var_list->data[i])) {
        int_mset_clear(vars);
        return false;
      }
    }

    // All variables assigned
    return true;

  } else {
    assert(false);
  }

  return true;
}

static
void nra_plugin_push(plugin_t* plugin) {
  nra_plugin_t* nra = (nra_plugin_t*) plugin;
  scope_holder_push(&nra->scope,
      &nra->trail_i,
      &nra->processed_variables_size,
      &nra->lp_data.lp_var_order_size,
      NULL);

  feasible_set_db_push(nra->feasible_set_db);
}

static
void nra_plugin_pop(plugin_t* plugin) {

  nra_plugin_t* nra = (nra_plugin_t*) plugin;
  const mcsat_trail_t* trail = nra->ctx->trail;

  if (ctx_trace_enabled(nra->ctx, "nra::conflict")) {
    trail_print(trail, ctx_trace_out(nra->ctx));
  }

  // Pop the scoped variables
  scope_holder_pop(&nra->scope,
      &nra->trail_i,
      &nra->processed_variables_size,
      &nra->lp_data.lp_var_order_size,
      NULL);

  // Undo the processed variables
  while (nra->processed_variables.size > nra->processed_variables_size) {
    // The variable to undo
    variable_t x = ivector_last(&nra->processed_variables);
    ivector_pop(&nra->processed_variables);
    assert(variable_db_is_real(nra->ctx->var_db, x) || variable_db_is_int(nra->ctx->var_db, x));
    if (TRACK_VAR(x)) {
      fprintf(stderr, "Undoing tracked variable unit status.\n");
    }
    // Go through the watch and mark the constraints
    remove_iterator_t it;
    remove_iterator_construct(&it, &nra->wlm, x);
    while (!remove_iterator_done(&it)) {
      variable_t constraint_var = remove_iterator_get_constraint(&it);
      constraint_unit_info_t unit_info = nra_plugin_get_unit_info(nra, constraint_var);
      switch (unit_info) {
      case CONSTRAINT_UNKNOWN:
        // Nothing to do
        break;
      case CONSTRAINT_UNIT:
        // If it was unit it becomes not unit
        nra_plugin_set_unit_info(nra, constraint_var, variable_null, CONSTRAINT_UNKNOWN);
        break;
      case CONSTRAINT_FULLY_ASSIGNED:
        // It is unit now
        nra_plugin_set_unit_info(nra, constraint_var, x, CONSTRAINT_UNIT);
        break;
      }
      remove_iterator_next_and_keep(&it);
    }
    remove_iterator_destruct(&it);
  }

  // Pop the variable order and the lp model
  lp_variable_order_t* order = nra->lp_data.lp_var_order;
  lp_assignment_t* assignment = nra->lp_data.lp_assignment;
  while (lp_variable_order_size(order) > nra->lp_data.lp_var_order_size) {
    lp_variable_t lp_var = lp_variable_order_top(order);
    lp_variable_order_pop(order);
    lp_assignment_set_value(assignment, lp_var, 0);
    variable_t var = nra_plugin_get_variable_from_lp_variable(nra, lp_var);
    (void)var;
    if (TRACK_VAR(var)) {
      fprintf(stderr, "Undoing tracked variable in lp_assignment.\n");
    }
    assert(!trail_has_value(nra->ctx->trail, var));
  }

  if (ctx_trace_enabled(nra->ctx, "nra::check_assignment")) {
    nra_plugin_check_assignment(nra);
  }

  // Pop the feasibility
  feasible_set_db_pop(nra->feasible_set_db);

  // Unset the conflict
  nra->conflict_variable = variable_null;
  nra->conflict_variable_int = variable_null;

  // We undid last decision, so we're back to normal
  nra->last_decided_and_unprocessed = variable_null;
}

static
void nra_plugin_gc_mark(plugin_t* plugin, gc_info_t* gc_vars) {
  nra_plugin_t* nra = (nra_plugin_t*) plugin;
  // The NRA plugin doesn't really need to keep much. The only things we'd
  // like to keep are the lemmas that restrict top level feasibility sets.
  feasible_set_db_gc_mark(nra->feasible_set_db, gc_vars);
  // We also need to mark all the real variables that are in use
  poly_constraint_db_gc_mark(nra->constraint_db, gc_vars);
}

static
void nra_plugin_gc_sweep(plugin_t* plugin, const gc_info_t* gc_vars) {
  nra_plugin_t* nra = (nra_plugin_t*) plugin;

  // The feasibility sets keep everything, we just gc the constraints,
  // the watchlists and the unit information. The lp_data mappings stays the
  // same as we never erase real variables)

  // The constraint database
  poly_constraint_db_gc_sweep(nra->constraint_db, gc_vars);

  // Unit information (constraint_unit_info, constraint_unit_var)
  gc_info_sweep_int_hmap_keys(gc_vars, &nra->constraint_unit_info);
  gc_info_sweep_int_hmap_keys(gc_vars, &nra->constraint_unit_var);

  // Watch list manager
  watch_list_manager_gc_sweep_lists(&nra->wlm, gc_vars);
}

static
void nra_plugin_event_notify(plugin_t* plugin, plugin_notify_kind_t kind) {
  nra_plugin_t* nra = (nra_plugin_t*) plugin;
  (void)nra;

  switch (kind) {
  case MCSAT_SOLVER_START:
    // Re-initialize the heuristics
    break;
  case MCSAT_SOLVER_RESTART:
    // Check if clause compaction needed
    break;
  case MCSAT_SOLVER_CONFLICT:
    // Decay the scores each conflict
    break;
  default:
    assert(false);
  }
}

static
void nra_plugin_new_lemma_notify(plugin_t* plugin, ivector_t* lemma, trail_token_t* prop) {
  nra_plugin_t* nra = (nra_plugin_t*) plugin;

  uint32_t i;

  // Check if unit in single variable
  bool unit = true;
  variable_t unit_var = variable_null;
  for (i = 0; unit && i < lemma->size; ++ i) {

    if (ctx_trace_enabled(nra->ctx, "nra::lemma")) {
      ctx_trace_printf(nra->ctx, "lemma[%u] = ", i); ctx_trace_term(nra->ctx, lemma->data[i]); ctx_trace_printf(nra->ctx, "\n");
    }

    term_t literal = lemma->data[i];
    term_t atom = unsigned_term(literal);
    variable_t atom_var = variable_db_get_variable_if_exists(nra->ctx->var_db, atom);
    assert(atom_var != variable_null);
    if (nra_plugin_get_unit_info(nra, atom_var) != CONSTRAINT_UNIT) {
      // Not unit
      unit = false;
    } else {
      // Unit, check if same variable
      variable_t atom_unit_var = nra_plugin_get_unit_var(nra, atom_var);
      if (unit_var == variable_null) {
        unit_var = atom_unit_var;
      } else if (unit_var != atom_unit_var) {
        unit = false;
      }
    }
  }

  if (unit && nra->ctx->trail->decision_level == 0) {

    // Get the feaisble set
    lp_feasibility_set_t* lemma_feasible = lp_feasibility_set_new_empty();

    // Add all the literal sets
    for (i = 0; i < lemma->size; ++ i) {

      if (ctx_trace_enabled(nra->ctx, "nra::lemma")) {
        ctx_trace_printf(nra->ctx, "nra: lemma_feasible = ");
        lp_feasibility_set_print(lemma_feasible, ctx_trace_out(nra->ctx));
        ctx_trace_printf(nra->ctx, "\n");
      }

      term_t literal_term = lemma->data[i];
      term_t constraint_term = unsigned_term(literal_term);
      variable_t constraint_var = variable_db_get_variable_if_exists(nra->ctx->var_db, constraint_term);
      assert(constraint_var != variable_null);

      // Is it negated
      bool negated = constraint_term != literal_term;

      // Get the constraint
      const poly_constraint_t* constraint = poly_constraint_db_get(nra->constraint_db, constraint_var);

      // Compute and add the feasible set
      lp_feasibility_set_t* constraint_feasible = poly_constraint_get_feasible_set(constraint, nra->lp_data.lp_assignment, negated);

      if (ctx_trace_enabled(nra->ctx, "nra::lemma")) {
        ctx_trace_printf(nra->ctx, "nra: constraint_feasible = ");
        lp_feasibility_set_print(constraint_feasible, ctx_trace_out(nra->ctx));
        ctx_trace_printf(nra->ctx, "\n");
      }

      lp_feasibility_set_add(lemma_feasible, constraint_feasible);
      lp_feasibility_set_delete(constraint_feasible);
    }

    if (ctx_trace_enabled(nra->ctx, "nra::lemma")) {
      ctx_trace_printf(nra->ctx, "nra: lemma_feasible = ");
      lp_feasibility_set_print(lemma_feasible, ctx_trace_out(nra->ctx));
      ctx_trace_printf(nra->ctx, "\n");
    }

    // Since we need to communicate conflicts to bool theory, vacuous constraints
    // can happen, i.e. the following is not a valid assertion
    // assert(!lp_feasibility_set_is_full(lemma_feasible));
    // We can also learn infeasible lemmas, we just have to report a conflict
    if (!lp_feasibility_set_is_full(lemma_feasible)) {

      if (ctx_trace_enabled(nra->ctx, "nra::lemma")) {
        const lp_feasibility_set_t* current_feasible = feasible_set_db_get(nra->feasible_set_db, unit_var);
        if (current_feasible) {
          ctx_trace_printf(nra->ctx, "nra: current feasible = ");
          lp_feasibility_set_print(current_feasible, ctx_trace_out(nra->ctx));
          ctx_trace_printf(nra->ctx, "\n");
        }
      }

      // Collect the literals
      ivector_t lemma_reasons;
      init_ivector(&lemma_reasons, 0);
      for (i = 0; i < lemma->size; ++ i) {
        term_t literal_term = lemma->data[i];
        term_t constraint_term = unsigned_term(literal_term);
        variable_t constraint_var = variable_db_get_variable_if_exists(nra->ctx->var_db, constraint_term);
        assert(constraint_var != variable_null);
        ivector_push(&lemma_reasons, constraint_var);
      }

      // Update
      bool feasible = feasible_set_db_update(nra->feasible_set_db, unit_var, lemma_feasible, lemma_reasons.data, lemma_reasons.size);
      if (ctx_trace_enabled(nra->ctx, "nra::lemma")) {
        ctx_trace_printf(nra->ctx, "nra: new feasible = ");
        const lp_feasibility_set_t* current_feasible = feasible_set_db_get(nra->feasible_set_db, unit_var);
        lp_feasibility_set_print(current_feasible, ctx_trace_out(nra->ctx));
        ctx_trace_printf(nra->ctx, "\n");
      }

      // If infeasible report conflict
      if (!feasible) {
        nra_plugin_report_conflict(nra, prop, unit_var);
      }

      delete_ivector(&lemma_reasons);
    }
  }
}

plugin_t* nra_plugin_allocator() {
  nra_plugin_t* plugin = malloc(sizeof(nra_plugin_t));
  plugin_construct((plugin_t*) plugin);
  plugin->plugin_interface.construct           = nra_plugin_construct;
  plugin->plugin_interface.destruct            = nra_plugin_destruct;
  plugin->plugin_interface.new_term_notify     = nra_plugin_new_term_notify;
  plugin->plugin_interface.new_lemma_notify    = nra_plugin_new_lemma_notify;
  plugin->plugin_interface.event_notify        = nra_plugin_event_notify;
  plugin->plugin_interface.propagate           = nra_plugin_propagate;
  plugin->plugin_interface.decide              = nra_plugin_decide;
  plugin->plugin_interface.get_conflict        = nra_plugin_get_conflict;
  plugin->plugin_interface.explain_propagation = nra_plugin_explain_propagation;
  plugin->plugin_interface.explain_evaluation  = nra_plugin_explain_evaluation;
  plugin->plugin_interface.push                = nra_plugin_push;
  plugin->plugin_interface.pop                 = nra_plugin_pop;
  plugin->plugin_interface.gc_mark             = nra_plugin_gc_mark;
  plugin->plugin_interface.gc_sweep            = nra_plugin_gc_sweep;
  return (plugin_t*) plugin;
}
