#ifndef S21_GREP_C
#define S21_GREP_C

#include <getopt.h>
#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct flags {
  int e;
  int i;
  int v;
  int c;
  int l;
  int n;
  int h;
  int s;
  int f;
  int o;
} fl;

void parser(int argc, char *argv[], fl *opt, char *pattern);
void openfile(int argc, char *argv[], FILE *file, fl *opt, char *pattern);
void work_flags(int col_file, char *name, FILE *file, fl *opt, char string[],
                regex_t compiled);
void flag_e(char *pattern, char *string);
void flag_f(char *pattern, char *filename);
void bonus(fl *opt);

#endif  // S21_GREP_C