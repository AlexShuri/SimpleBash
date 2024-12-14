#include "s21_grep.h"

int main(int argc, char *argv[]) {
  char pattern[1024] = "\0";
  fl opt = {0};
  FILE *file = NULL;
  parser(argc, argv, &opt, pattern);
  openfile(argc, argv, file, &opt, pattern);
  return 0;
}

void parser(int argc, char *argv[], fl *opt, char *pattern) {
  int flag_grep = 0;
  while ((flag_grep = getopt(argc, argv, "e:ivclnhsf:o")) !=
         -1) {  // Так как нет длинных флагов
    switch (flag_grep) {
      case 'e':
        opt->e = 1;
        flag_e(pattern, optarg); //optarg - аргумент конкретной опции
        break;
      case 'i':
        opt->i = 1;
        break;
      case 'o':
        opt->o = 1;
        break;
      case 'v':
        opt->v = 1;
        break;
      case 'c':
        opt->c = 1;
        break;
      case 'l':
        opt->l = 1;
        break;
      case 'n':
        opt->n = 1;
        break;
      case 'h':
        opt->h = 1;
        break;
      case 's':
        opt->s = 1;
        break;
      case 'f':
        opt->f = 1;
        flag_f(pattern, optarg);
        break;
      default:
        fprintf(stderr, "invalid option");
        exit(EXIT_FAILURE);
        break;
    }
    bonus(opt);
  }
}

void openfile(int argc, char *argv[], FILE *file, fl *opt, char *pattern) {
  regex_t compiled;
  char string[4096] = {0};
  if ((!(opt->e || opt->f) && argv[optind])) {//opting - указывает на следующий элемент массива, который не был обработан
    strcpy(pattern, argv[optind]);
    optind++;
  }
  int cflags = REG_EXTENDED;  // Используется расширение регулярные выражения
  if (opt->i) {
    cflags = REG_ICASE;  // Используется для игнорирование регистр в совпадение
  }
  int col_file = 1;
  if ((argc - optind) > 1) {
    col_file++;  // Количество файлов
  }
  for (int i = optind; i < argc; i++) {
    if (argv[i][0] != '-') {
      file = fopen(argv[i], "r");
      if (file != NULL) {
        regcomp(&compiled, pattern, cflags);
        work_flags(col_file, argv[i], file, opt, string, compiled);
      } else {
        if (opt->s == 0) {
          fprintf(stderr, "s21_grep: %s: No such file or directory", argv[i]);
        }
      }
    }
    if (file != NULL) {
      fclose(file);
      regfree(&compiled);
    }
  }
}

void work_flags(int col_file, char *name, FILE *file, fl *opt, char string[],
                regex_t compiled) {
  regmatch_t pmatch[1];
  int count = 0;
  int line = 0;
  while ((fgets(string, 4095, file)) != NULL) {
    int sovp = 0;  // Совпадение
    count++;
    int nashel = 0;
    char *new_string = string;
    while ((nashel = regexec(&compiled, new_string, 1, pmatch, 0)) == 0) {
      if (opt->n && opt->o) {
        printf("%d:", count);
      }
      if (opt->o) {
        for (int i = pmatch[0].rm_so; i < pmatch[0].rm_eo; i++) {
          printf("%c", new_string[i]);
        }
        printf("\n");
      }
      sovp++;
      new_string += pmatch[0].rm_eo;
    }
    if (opt->v) sovp = !sovp;
    if (sovp && opt->n && !opt->o) printf("%d:", count);
    if (sovp && !(opt->c || opt->l || opt->o)) {  //Результат
      if (strchr(string, '\n') == NULL) {
        strcat(string, "\n");
      }
      if (col_file > 1 && !opt->h) printf("%s:", name);
      printf("%s", string);
    }
    line += sovp;
  }
  if (opt->l && line > 0) {
    if (opt->c) {
      printf("%d\n", col_file);
    }
    printf("%s\n", name);
  }
  if (opt->c && !opt->l) {
    if (col_file > 1 && !opt->h) {
      printf("%s:%d\n", name, line);
    } else {
      printf("%d\n", line);
    }
  }
}

void flag_e(char *pattern, char *string) {
  if (*pattern != '\0') {
    strcat(pattern, "|");
  }
  strcat(pattern, string);
}

void flag_f(char *pattern, char *filename) {
  FILE *file = NULL;
  char string_f[4096] = {0};
  file = fopen(filename, "r");
  if (file != NULL) {
    while ((fgets(string_f, 4095, file)) != NULL) {
      int raz_string = strlen(string_f);
      if (string_f[raz_string - 1] == '\n') string_f[raz_string - 1] = '\0';
      if (string_f[0] == '\0') string_f[raz_string - 1] = '.';
      flag_e(pattern, string_f);
    }
  } else {
    fprintf(stderr, "s21_grep: %s: No such file or directory\n", filename);
  }
  if (file != NULL) fclose(file);
}

void bonus(fl *opt) {
  if (opt->v) opt->o = 0;
  if (opt->c) {
    opt->n = 0;
    opt->o = 0;
  }
  if (opt->l) {
    opt->n = 0;
    opt->o = 0;
  }
}
