#include "s21_cat.h"

int main(int argc, char *argv[]) {  // argc - количество аргументов в строке;
                                    // *argv[] -указатель на массив указателей;
  fl opt = {0};
  FILE *filename = NULL;
  parser(argc, argv, &opt);
  openfile(argc, argv, filename, &opt);
  return 0;
}

void parser(int argc, char *argv[], fl *opt) {
  int flag_cat = 0;
  static struct option longoptions[] = {{"number-nonblank", 0, NULL, 'b'},
                                        {"number", 0, NULL, 'n'},
                                        {"squeeze-blank", 0, NULL, 's'},
                                        {NULL, 0, NULL, 0}};
  int longindex = 0;
  while ((flag_cat = getopt_long(argc, argv, "+beEnsvtT", longoptions,
                                 &longindex)) != -1) {
    switch (flag_cat) {
      case 'b':
        opt->b = 1;
        break;
      case 'e':
        opt->e = 1;
        opt->v = 1;
        break;
      case 'E':
        opt->E = 1;
        break;
      case 'n':
        opt->n = 1;
        break;
      case 's':
        opt->s = 1;
        break;
      case 'v':
        opt->v = 1;
        break;
      case 't':
        opt->t = 1;
        opt->v = 1;
        break;
      case 'T':
        opt->T = 1;
        break;
      default:
        fprintf(stderr, "usage: s21_cat [-benstuv] [file ...]");
        exit(EXIT_FAILURE);
        break;
    }
  }
  if (opt->b && opt->n) {
    opt->n = 0;
  }
}

void openfile(int argc, char *argv[], FILE *filename, fl *opt) {
  for (int i = 1; i < argc; i++) {
    if (argv[i][0] != '-') {
      filename = fopen(argv[i], "r");
      if (filename != NULL) {
        proc(filename, opt);
      } else {
        fprintf(stderr, "s21_cat: %s: No such file or directory\n", argv[i]);
      }
    }
    if (filename != NULL) fclose(filename);
  }
}

void proc(FILE *filename, fl *opt) {
  char simvol = -1;
  char simvol_n = -1;
  char simvol_old = -1;
  int time = 0;
  while ((simvol = fgetc(filename)) != EOF) {
    if ((opt->e || opt->E) && simvol == '\n') {
      printf("$");
    }
    if (opt->n && (simvol_n == -1 || simvol_n == '\n')) {
      time++;
      printf("%6d\t", time);
    }
    if ((opt->t || opt->T) && simvol == '\t') {
      simvol = 'I';
      printf("^");
    }
    if (opt->s && simvol == '\n' && simvol_n == '\n' &&
        (simvol_old == -1 || simvol_old == '\n')) {
      simvol_old = simvol_n;
      simvol_n = simvol;
      continue;
    }
    if (opt->v) {
      if (simvol >= 0 && simvol < 32 && simvol != 9 && simvol != 10) {
        simvol += 64;
        printf("^");
      } else if (simvol == 127) {
        simvol = 63;
        printf("^");
      }
    }
    if (opt->b && ((simvol_n == '\n' || simvol_n == -1) && simvol != '\n')) {
      time++;
      printf("%6d\t", time);
    }
    simvol_old = simvol_n;
    simvol_n = simvol;
    printf("%c", simvol);
  }
}
