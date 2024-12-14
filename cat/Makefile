CC = gcc
FL = -Wall -Werror -Wextra -c
VD = s21_cat

all: $(VD)

$(VD): s21_cat.o
	$(CC) s21_cat.o -o $(VD)

s21_cat.o: s21_cat.c
	$(CC) $(FL) s21_cat.c

clean:
	rm *.o $(VD)

leaks: $(VD)
	leaks -atExit -- ./s21_cat

valgrind: $(VD)
	valgrind --tool=memcheck --leak-check=yes  ./s21_cat

test: $(VD)
	sh test_cat.sh

rebuld: clean all