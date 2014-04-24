#ifndef __THREADSAFE_H
#define __THREADSAFE_H

#include <stdio.h>

#include "types.h"

/*
 * Print the type table
 */
extern void show_types_mt(FILE* output);   

/*
 * Print the term table
 */
extern void show_terms_mt(FILE* output);


/* used in the _mt tests */
extern bool has_type_mt(type_t tau, term_t t);

/* used in the _mt tests */
extern void print_term_mt(FILE* output, term_t t);

/* used in the _mt tests */
extern void print_type_mt(FILE* output, type_t t);

#endif /* __THREADAFES_H */

