#!/bin/bash
# -------------------------------PRACTICAL TASK 3------------------------------ #
# You need to write a script that prints the numbers from 1 to 100 such that:   #
# - If the number is a multiple of 3, you need to print "Fizz" instead of that  #
# number.                                                                       #
# - If the number is a multiple of 5, you need to print "Buzz" instead of that  #
# number.                                                                       #
# - If the number is a multiple of both 3 and 5, you need to print "FizzBuzz"   #
# instead of that number.                                                       #
# ----------------------------------------------------------------------------- #

# Global Variables / Default Values
# --------------------------------------------------------------------------

# --------------------------------------------------------------------------

# Functions*INIT*------------------------------------------------------------*
funcCalc() {
    numActual=$i
    numM3=$(expr $numActual % 3)
    numM5=$(expr $numActual % 5)
    if [ "$numM3" = 0 ] && [ "$numM5" = 0 ]; then
        echo "FizzBuzz"
    elif [ "$numM3" = 0 ]; then
        echo "Fizz"
    elif [ "$numM5" = 0 ]; then
        echo "Buzz"
    else
        echo "$numActual"
    fi
}
# Functions*END*------------------------------------------------------------*

# Script*INIT*--------------------------------------------------------------*
clear
for ((i=1; i<=100; i++)) do
    funcCalc $i
done
# Script*END*---------------------------------------------------------------*