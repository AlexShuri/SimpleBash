#!/bin/bash

SUCCESS=0 #Успех
FAIL=0 #Ошибка
SCH=1  #Счетчик
RES="" #Резульат


GREEN=' \033[32m'
RED=' \033[31m'
DROP=' \033[0m'

S21="./s21_cat"
TEST="test_s21_cat.log"
ORIG="test_cat.log"

# TEST 1

cat testfiles/12.txt > $ORIG
$S21 testfiles/12.txt > $TEST
RES=$(diff -s ${ORIG} ${TEST})

if [[ $? -eq 0 ]]; then
    echo " $SCH ${GREEN}SUCCESS${DROP}\n"
    (( SUCCESS++ ))
else
    echo " $SCH ${RED}FAIL${DROP}\n"
    ech0 "$RES"
    (( FAIL++ ))
fi

((SCH++))

# TEST 2

cat -b testfiles/12.txt > $ORIG
$S21 -b testfiles/12.txt > $TEST
RES=$(diff -s ${ORIG} ${TEST})

if [[ $? -eq 0 ]]; then
    echo " $SCH ${GREEN}SUCCESS${DROP}\n"
    (( SUCCESS++ ))
else
    echo " $SCH ${RED}FAIL${DROP}\n"
    ech0 "$RES"
    (( FAIL++ ))
fi

((SCH++))

# TEST 3

cat -e testfiles/test_case_cat.txt > $ORIG
$S21 -e testfiles/test_case_cat.txt > $TEST
RES=$(diff -s ${ORIG} ${TEST})

if [[ $? -eq 0 ]]; then
    echo " $SCH ${GREEN}SUCCESS${DROP}\n"
    (( SUCCESS++ ))
else
    echo " $SCH ${RED}FAIL${DROP}\n"
    ech0 "$RES"
    (( FAIL++ ))
fi

((SCH++))

# TEST 4

cat -n testfiles/12.txt > $ORIG
$S21 -n testfiles/12.txt > $TEST
RES=$(diff -s ${ORIG} ${TEST})

if [[ $? -eq 0 ]]; then
    echo " $SCH ${GREEN}SUCCESS${DROP}\n"
    (( SUCCESS++ ))
else
    echo " $SCH ${RED}FAIL${DROP}\n"
    ech0 "$RES"
    (( FAIL++ ))
fi

((SCH++))

# TEST 5

cat -s testfiles/12.txt > $ORIG
$S21 -s testfiles/12.txt > $TEST
RES=$(diff -s ${ORIG} ${TEST})

if [[ $? -eq 0 ]]; then
    echo " $SCH ${GREEN}SUCCESS${DROP}\n"
    (( SUCCESS++ ))
else
    echo " $SCH ${RED}FAIL${DROP}\n"
    ech0 "$RES"
    (( FAIL++ ))
fi

((SCH++))

# TEST 6

cat -v testfiles/test_case_cat.txt > $ORIG
$S21 -v testfiles/test_case_cat.txt > $TEST
RES=$(diff -s ${ORIG} ${TEST})

if [[ $? -eq 0 ]]; then
    echo " $SCH ${GREEN}SUCCESS${DROP}\n"
    (( SUCCESS++ ))
else
    echo " $SCH ${RED}FAIL${DROP}\n"
    ech0 "$RES"
    (( FAIL++ ))
fi

((SCH++))

# TEST 7

cat -t testfiles/test_case_cat.txt > $ORIG
$S21 -t testfiles/test_case_cat.txt > $TEST
RES=$(diff -s ${ORIG} ${TEST})

if [[ $? -eq 0 ]]; then
    echo " $SCH ${GREEN}SUCCESS${DROP}\n"
    (( SUCCESS++ ))
else
    echo " $SCH ${RED}FAIL${DROP}\n"
    ech0 "$RES"
    (( FAIL++ ))
fi

((SCH++))

# TEST 8

cat -bn testfiles/12.txt > $ORIG
$S21 -bn testfiles/12.txt > $TEST
RES=$(diff -s ${ORIG} ${TEST})

if [[ $? -eq 0 ]]; then
    echo " $SCH ${GREEN}SUCCESS${DROP}\n"
    (( SUCCESS++ ))
else
    echo " $SCH ${RED}FAIL${DROP}\n"
    ech0 "$RES"
    (( FAIL++ ))
fi

((SCH++))

# TEST 9

cat -n testfiles/12.txt > $ORIG
$S21 --number testfiles/12.txt > $TEST
RES=$(diff -s ${ORIG} ${TEST})

if [[ $? -eq 0 ]]; then
    echo " $SCH ${GREEN}SUCCESS${DROP}\n"
    (( SUCCESS++ ))
else
    echo " $SCH ${RED}FAIL${DROP}\n"
    ech0 "$RES"
    (( FAIL++ ))
fi

((SCH++))

# TEST 10

cat -b testfiles/12.txt > $ORIG
$S21 --number-nonblank testfiles/12.txt > $TEST
RES=$(diff -s ${ORIG} ${TEST})

if [[ $? -eq 0 ]]; then
    echo " $SCH ${GREEN}SUCCESS${DROP}\n"
    (( SUCCESS++ ))
else
    echo " $SCH ${RED}FAIL${DROP}\n"
    ech0 "$RES"
    (( FAIL++ ))
fi

((SCH++))

# TEST 11

cat -s testfiles/12.txt > $ORIG
$S21 --squeeze-blank testfiles/12.txt > $TEST
RES=$(diff -s ${ORIG} ${TEST})

if [[ $? -eq 0 ]]; then
    echo " $SCH ${GREEN}SUCCESS${DROP}\n"
    (( SUCCESS++ ))
else
    echo " $SCH ${RED}FAIL${DROP}\n"
    ech0 "$RES"
    (( FAIL++ ))
fi

rm $TEST $ORIG

echo "All tests: $SCH"
echo "${GREEN}Success: $SUCCESS${DROP}"
echo "${RED}Fail: $FAIL${DROP}"