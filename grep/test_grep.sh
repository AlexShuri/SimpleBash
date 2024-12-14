#!/bin/bash

SUCCESS=0 #Успех
FAIL=0 #Ошибка
SCH=1  #Счетчик
RES="" #Резульат

GREEN=' \033[32m'
RED=' \033[31m'
DROP=' \033[0m'

S21="./s21_grep"
TEST="test_s21_grep.log"
ORIG="test_grep.log"

# TEST e
echo "TEST $SCH\nRunning: $S21 -e lol2 -e lol3 testfiles/1.txt"
grep -e lol2 -e lol3 testfiles/1.txt > $ORIG
$S21 -e lol2 -e lol3 testfiles/1.txt > $TEST
RES=$(diff -s ${ORIG} ${TEST})

if [[ $? -eq 0 ]]; then
    echo "${GREEN}SUCCESS${DROP}\n"
    (( SUCCESS++ ))
else
    echo "${RED}FAIL${DROP}\n"
    ech0 "$RES"
    (( FAIL++ ))
fi

((SCH++))

# TEST i
echo "TEST $SCH\nRunning: $S21 -i LOLkil testfiles/1.txt"
grep -i LOLkil testfiles/1.txt > $ORIG
$S21 -i LOLkil testfiles/1.txt > $TEST
RES=$(diff -s ${ORIG} ${TEST})

if [[ $? -eq 0 ]]; then
    echo "${GREEN}SUCCESS${DROP}\n"
    (( SUCCESS++ ))
else
    echo "${RED}FAIL${DROP}\n"
    ech0 "$RES"
    (( FAIL++ ))
fi

((SCH++))

# TEST v
echo "TEST $SCH\nRunning: $S21 -v lol2 testfiles/1.txt"
grep -v lol2 testfiles/1.txt > $ORIG
$S21 -v lol2 testfiles/1.txt > $TEST
RES=$(diff -s ${ORIG} ${TEST})

if [[ $? -eq 0 ]]; then
    echo "${GREEN}SUCCESS${DROP}\n"
    (( SUCCESS++ ))
else
    echo "${RED}FAIL${DROP}\n"
    ech0 "$RES"
    (( FAIL++ ))
fi

((SCH++))

# TEST c
echo "TEST $SCH\nRunning: $S21 -c lol2 testfiles/1.txt"
grep -c lol2 testfiles/1.txt > $ORIG
$S21 -c lol2 testfiles/1.txt > $TEST
RES=$(diff -s ${ORIG} ${TEST})

if [[ $? -eq 0 ]]; then
    echo "${GREEN}SUCCESS${DROP}\n"
    (( SUCCESS++ ))
else
    echo "${RED}FAIL${DROP}\n"
    echo "$RES"
    (( FAIL++ ))
fi

((SCH++))

# TEST c2
echo "TEST $SCH\nRunning: $S21 -c lol2 testfiles/1.txt testfiles/2.txt testfiles/4.txt"
grep -c lol2 testfiles/1.txt testfiles/2.txt testfiles/4.txt > $ORIG
$S21 -c lol2 testfiles/1.txt testfiles/2.txt testfiles/4.txt > $TEST
RES=$(diff -s ${ORIG} ${TEST})

if [[ $? -eq 0 ]]; then
    echo "${GREEN}SUCCESS${DROP}\n"
    (( SUCCESS++ ))
else
    echo "${RED}FAIL${DROP}\n"
    ech0 "$RES"
    (( FAIL++ ))
fi

((SCH++))

 # TEST l
echo "TEST $SCH\nRunning: $S21 -l lol2 testfiles/1.txt testfiles/2.txt testfiles/4.txt"
grep -l lol2 testfiles/1.txt testfiles/2.txt testfiles/4.txt > $ORIG
$S21 -l lol2 testfiles/1.txt testfiles/2.txt testfiles/4.txt > $TEST
RES=$(diff -s ${ORIG} ${TEST})

if [[ $? -eq 0 ]]; then
    echo "${GREEN}SUCCESS${DROP}\n"
    (( SUCCESS++ ))
else
    echo "${RED}FAIL${DROP}\n"
    echo "$RES"
    (( FAIL++ ))
fi

((SCH++))

 # TEST n
echo "TEST $SCH\nRunning: $S21 -n lol2 testfiles/1.txt"
grep -n lol2 testfiles/1.txt > $ORIG
$S21 -n lol2 testfiles/1.txt > $TEST
RES=$(diff -s ${ORIG} ${TEST})

if [[ $? -eq 0 ]]; then
    echo "${GREEN}SUCCESS${DROP}\n"
    (( SUCCESS++ ))
else
    echo "${RED}FAIL${DROP}\n"
    echo "$RES"
    (( FAIL++ ))
fi

((SCH++))

 # TEST h
echo "TEST $SCH\nRunning: $S21 -h lol2 testfiles/1.txt testfiles/2.txt"
grep -h lol2 testfiles/1.txt testfiles/2.txt  > $ORIG
$S21 -h lol2 testfiles/1.txt testfiles/2.txt  > $TEST
RES=$(diff -s ${ORIG} ${TEST})

if [[ $? -eq 0 ]]; then
    echo "${GREEN}SUCCESS${DROP}\n"
    (( SUCCESS++ ))
else
    echo "${RED}FAIL${DROP}\n"
    echo "$RES"
    (( FAIL++ ))
fi

((SCH++))

 # TEST s
echo "TEST $SCH\nRunning: $S21 -s lol2 testfiles/3.txt"
grep -s lol2 testfiles/3.txt > $ORIG
$S21 -s lol2 testfiles/3.txt > $TEST
RES=$(diff -s ${ORIG} ${TEST})

if [[ $? -eq 0 ]]; then
    echo "${GREEN}SUCCESS${DROP}\n"
    (( SUCCESS++ ))
else
    echo "${RED}FAIL${DROP}\n"
    echo "$RES"
    (( FAIL++ ))
fi

((SCH++))

# TEST f
echo "TEST $SCH\nRunning: $S21 -f testfiles/1.txt testfiles/4.txt"
grep -f testfiles/1.txt testfiles/4.txt > $ORIG
$S21 -f testfiles/1.txt testfiles/4.txt> $TEST
RES=$(diff -s ${ORIG} ${TEST})

if [[ $? -eq 0 ]]; then
    echo "${GREEN}SUCCESS${DROP}\n"
    (( SUCCESS++ ))
else
    echo "${RED}FAIL${DROP}\n"
    echo "$RES"
    (( FAIL++ ))
fi

((SCH++))

# TEST o
echo "TEST $SCH\nRunning: $S21 -o lol2 testfiles/1.txt"
grep -o lol2 testfiles/1.txt > $ORIG
$S21 -o lol2 testfiles/1.txt > $TEST
RES=$(diff -s ${ORIG} ${TEST})

if [[ $? -eq 0 ]]; then
    echo "${GREEN}SUCCESS${DROP}\n"
    (( SUCCESS++ ))
else
    echo "${RED}FAIL${DROP}\n"
    echo "$RES"
    (( FAIL++ ))
fi

((SCH++))

# TEST two flags
for flag1 in i v c l n h o; do 
    for flag2 in i v c l n h o; do 
        if [ $flag1 != $flag2 ]; then
            flag="-${flag1}${flag2}"
            echo "TEST $SCH\nRunning: $S21 $flag lol2 testfiles/1.txt"
            grep $flag lol2 testfiles/1.txt > $ORIG
            $S21 $flag lol2 testfiles/1.txt > $TEST
            RES=$(diff -s ${ORIG} ${TEST})

            if [[ $? -eq 0 ]]; then
                echo "${GREEN}SUCCESS${DROP}\n"
                ((SUCCESS++))
            else
                echo "${RED}FAIL${DROP}\n"
                echo "$RES"
                ((FAIL++))
            fi

            ((SCH++))
        fi
    done
done

#TEST FOR h and flags
for flag1 in i v c l n o; do
    flag="-${flag1}h"
    echo "TEST $SCH\nRunning: $S21 $flag lol2 testfiles/1.txt testfiles/2.txt"
    grep $flag lol2 testfiles/1.txt testfiles/2.txt > $ORIG
    $S21 $flag lol2 testfiles/1.txt testfiles/2.txt > $TEST
    RES=$(diff -s ${ORIG} ${TEST})

    if [[ $? -eq 0 ]]; then
        echo "${GREEN}SUCCESS${DROP}\n"
        ((SUCCESS++))
    else
        echo "${RED}FAIL${DROP}\n"
        echo "$RES"
        ((FAIL++))
    fi

    ((SCH++))
done

#TEST FOR s and flags
for flag1 in i v c l n o; do
    flag="-${flag1}s"
    echo "TEST $SCH\nRunning: $S21 $flag lol2 testfiles/15.txt"
    grep $flag lol2 testfiles/15.txt > $ORIG
    $S21 $flag lol2 testfiles/15.txt > $TEST
    RES=$(diff -s ${ORIG} ${TEST})

    if [[ $? -eq 0 ]]; then
        echo "${GREEN}SUCCESS${DROP}\n"
        ((SUCCESS++))
    else
        echo "${RED}FAIL${DROP}\n"
        echo "$RES"
        ((FAIL++))
    fi

    ((SCH++))
done

#TEST FOR s and h
    flag="-hs"
    echo "TEST $SCH\nRunning: $S21 $flag lol2 testfiles/1.txt testfiles/2.txt"
    grep $flag lol2 testfiles/1.txt testfiles/2.txt > $ORIG
    $S21 $flag lol2 testfiles/1.txt testfiles/2.txt > $TEST
    RES=$(diff -s ${ORIG} ${TEST})

    if [[ $? -eq 0 ]]; then
        echo "${GREEN}SUCCESS${DROP}\n"
        ((SUCCESS++))
    else
        echo "${RED}FAIL${DROP}\n"
        echo "$RES"
        ((FAIL++))
    fi

    ((SCH++))

# TEST FOR f and flags
for flag1 in v l n; do
    flag="-${flag1}f"
    echo "TEST $SCH\nRunning: $S21 $flag testfiles/1.txt testfiles/2.txt"
    grep $flag testfiles/1.txt testfiles/2.txt > $ORIG
    $S21 $flag testfiles/1.txt testfiles/2.txt > $TEST
    RES=$(diff -s ${ORIG} ${TEST})

    if [[ $? -eq 0 ]]; then
        echo "${GREEN}SUCCESS${DROP}\n"
        ((SUCCESS++))
    else
        echo "${RED}FAIL${DROP}\n"
        echo "$RES"
        ((FAIL++))
    fi

    ((SCH++))
done

#TEST FOR s and f
flag="-sf"
echo "TEST $SCH\nRunning: $S21 $flag testfiles/15.txt testfiles/2.txt"
grep $flag testfiles/1.txt testfiles/2.txt > $ORIG
$S21 $flag testfiles/1.txt testfiles/2.txt > $TEST
RES=$(diff -s ${ORIG} ${TEST})

if [[ $? -eq 0 ]]; then
    echo "${GREEN}SUCCESS${DROP}\n"
    ((SUCCESS++))
else
    echo "${RED}FAIL${DROP}\n"
    echo "$RES"
    ((FAIL++))
fi

((SCH++))

# TEST FOR -e
for flag1 in i v c l n h o; do
    flag="-${flag1}e"
    echo "TEST $SCH\nRunning: $S21 $flag lol2 -e lol3 testfiles/1.txt"
    grep $flag lol2 testfiles/1.txt > $ORIG
    $S21 $flag lol2 testfiles/1.txt > $TEST
    RES=$(diff -s ${ORIG} ${TEST})

    if [[ $? -eq 0 ]]; then
        echo "${GREEN}SUCCESS${DROP}\n"
        ((SUCCESS++))
    else
        echo "${RED}FAIL${DROP}\n"
        echo "$RES"
        ((FAIL++))
    fi

    ((SCH++))
done

#TEST FOR s and e
flag="-se"
echo "TEST $SCH\nRunning: $S21 $flag lol2 testfiles/1.txt"
grep $flag lol2 testfiles/1.txt testfiles/2.txt > $ORIG
$S21 $flag lol2 testfiles/1.txt testfiles/2.txt > $TEST
RES=$(diff -s ${ORIG} ${TEST})

if [[ $? -eq 0 ]]; then
    echo "${GREEN}SUCCESS${DROP}\n"
    ((SUCCESS++))
else
    echo "${RED}FAIL${DROP}\n"
    echo "$RES"
    ((FAIL++))
fi



echo "\033[31mFAIL: $FAIL\033[0m"
echo "\033[32mSUCCESS: $SUCCESS\033[0m"
echo "ALL: $SCH"
rm $TEST $ORIG
