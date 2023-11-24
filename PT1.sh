#!/bin/bash
# Miguel Angel Briseño Flores
# -------------------------------PRACTICAL TASK 1------------------------------ #
# The Fibonacci numbers are the numbers in the following integer sequence.      #
# 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, ……..                            #
# In mathematical terms, the sequence Fn of Fibonacci numbers is defined by the #
# recurrence relation:                                                          #
# Fn = Fn-1 + Fn-2 with seed values F0 = 0 and F1 = 1.                          #
#                                                                               #
# Write a function fib that returns Fn. For example, if n = 0, then fib should  #
# return 0. If n = 1, then it should return 1. For n > 1, it should             #
# return Fn-1 + Fn-2                                                            #
# ----------------------------------------------------------------------------- #

# Trap for CTRL+C, Signal 15, CTRL+Z
# trap 'echo " - Please Press Q to Exit..."' SIGINT SIGTERM SIGTSTP

# Global Variables / Default Values
# *--------------------------------------------------------------------------*
f_0=0
f_1=1
f_actual=1
# declare -i f_number
# *--------------------------------------------------------------------------*

# Functions*INIT*------------------------------------------------------------*

# Function Menu
funcMENU() {
    clear
    echo " .   FIBONACCI CALCULATOR"
    echo "*----------------------------*"
    echo " Write your Fibonacci Number:"
    echo "*----------------------------*"
    read -r f_number
    funcNumber
}

# Number Verification Function
funcNumber() {
    if ! [[ $f_number =~ ^[0-9]+$ ]]; then
        echo "Type a number from 0 to 9..."
        sleep 3
        f_number=0
        funcMENU
    else
        funcFN
    fi
}

# Fibonacci Function
funcFN() {
    for ((f = 0; f < f_number; f++)); do
        echo "Fibonacci Number $f_actual: $f_0"
        f_2=$(($f_0 + $f_1))
        f_0=$f_1
        f_1=$f_2
        f_actual=$(($f_actual + 1))
    done
    echo "*----------------------------*"
}

# Functions*END*------------------------------------------------------------*

# Script*INIT*--------------------------------------------------------------*
funcMENU
# Script*END*---------------------------------------------------------------*