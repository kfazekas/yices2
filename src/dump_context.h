/*
 * Print a context (for debugging mostly)
 * Moved the code here to clean-up yices_reval.c
 */

#ifndef __DUMP_CONTEXT_H
#define __DUMP_CONTEXT_H

#include <stdio.h>
#include "context.h"

/*
 * Print ctx into file f
 * - the amount of details depend on the compilation mode
 * - in MODE=debug, print a lot of stuff
 */
extern void dump_context(FILE *f, context_t *ctx);

#endif /* __DUMP_CONTEXT_H */

