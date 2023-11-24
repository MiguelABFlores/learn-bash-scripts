#!/bin/bash
# -------------------------------PRACTICAL TASK 2------------------------------ #
# Write bash script accepting operation parameter (“-”, “+”, “*”, “%”),         #
# sequence of numbers and debug flag.                                           #
# For example:                                                                  #
# ./your_script.sh -o % -n 5 3 -d                                               #
# Result: 2                                                                     #
# ./your_script.sh -o + -n 3 5 7 -d                                             #
# Result: 15                                                                    #
#                                                                               #
# If -d flag is passed, script must print additional information:               #
# User: <username of the user running the script>                               #
# Script: <script name>                                                         #
# Operation: <operation>                                                        #
# Numbers: <all space-separated numbers>                                        #
# ----------------------------------------------------------------------------- #

# Global Variables / Default Values
# --------------------------------------------------------------------------

# --------------------------------------------------------------------------

# Functions*INIT*------------------------------------------------------------*

# Function to decompose parameters
funcREAD() {
    array=( "$@" )
    if [ "${@: -1}" == "-d" ]; then
        funcNUMARRAY $array 4
        echo $numElements
        clear
        funcINFO1 ${array[1]}
        funcINFO2 ${array[@]}
        funcOPERATION $array
    else
        funcNUMARRAY $array 3
        echo $numElements
        clear
        funcOPERATION $array
    fi
}

#Function to do math operations
funcOPERATION() {
    total=0
    if [ "${array[1]}" == "+" ]; then 
        total=${array[3]}
        for i in "${array[@]:4:$numElements}"; do
            ((total += "$i"))
        done
    elif [ "${array[1]}" == "-" ]; then
        total=${array[3]}
        for i in "${array[@]:4:$numElements}"; do
            ((total -= "$i"))
        done
    elif [ "${array[1]}" == "%" ]; then
        total=${array[3]}
        for i in "${array[@]:4:$numElements - 1}"; do
            total=$(( "$total" % "$i"))
        done
    else
        total=${array[3]}
        for i in "${array[@]:4:$numElements - 1}"; do
            total=$(( $total * $i ))
        done
    fi
    echo "Total: $total"
}

# Max length of elements in array function
funcNUMARRAY() {
    maxlength=${#array[@]}
    numElements=$(expr $maxlength - $2)
    echo $numElements
}

# Additional Information Flag 1
funcINFO1() {
    echo "User: $USER"
    echo "Script: $(basename "$0")"
    if [ "$1" = "+" ] || [ "$1" = "-" ] || [ "$1" = "%" ]; then
        echo "Operation: $1"
    else
        echo 'Operation: *'
    fi
}

# Additional Information Flag 2
funcINFO2() {

    # echo "Numbers: ${4: - 1: - 1}"
     echo "Numbers: ${array[@]:3:$numElements}"
}
# Functions*END*------------------------------------------------------------*

# Script*INIT*--------------------------------------------------------------*
clear
funcREAD "$@"
# Script*END*---------------------------------------------------------------*