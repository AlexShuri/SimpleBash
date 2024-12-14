#ifndef S21_CAT_C
#define S21_CAT_C

#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>

typedef struct flags {
  int b;
  int e;
  int E;
  int n;
  int s;
  int v;
  int t;
  int T;
} fl;

void parser(int argc, char *argv[], fl *opt);
void openfile(int argc, char *argv[], FILE *filename, fl *opt);
void proc(FILE *filename, fl *opt);

#endif  // S21_CAT_C
