/*
 * This file is part of the Yices SMT Solver.
 * Copyright (C) 2017 SRI International.
 *
 * Yices is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Yices is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Yices.  If not, see <http://www.gnu.org/licenses/>.
 */

/*
 * CONTEXT UTILITIES FOR QUANTIFIERS
 */

#ifndef __QUANT_CONTEXT_UTILS_H
#define __QUANT_CONTEXT_UTILS_H

#include "context/context.h"


/*
 * Assert toplevel instance formula t:
 * - t is a boolean term (or the negation of a boolean term)
 */
extern void quant_assert_toplevel_formula(context_t *ctx, term_t t);




#endif /* __QUANT_CONTEXT_UTILS_H */
