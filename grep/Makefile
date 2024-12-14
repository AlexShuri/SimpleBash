CC = gcc
FL = -Wall -Werror -Wextra -c
VD = s21_grep

all: $(VD)

$(VD): s21_grep.o
	$(CC) s21_grep.o -o $(VD)

s21_grep.o: s21_grep.c
	$(CC) $(FL) s21_grep.c

clean:
	rm *.o $(VD)

leaks: $(VD)
	leaks -atExit -- ./s21_grep

valgrind: $(VD)
	valgrind --tool=memcheck --leak-check=yes  ./s21_grep

rebuld: clean all