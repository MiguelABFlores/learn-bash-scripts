#!/bin/bash
# -------------------------------PRACTICAL TASK 4------------------------------ #
# Write caesar cipher script accepting three parameters:                        #
# -s <shift> -i <input file> -o <output file>                                   #
# ----------------------------------------------------------------------------- #

# tr is a linux command that translates or deletes characters from standard
# input (stdin) and writes the result to standard output (stdout)
# Since tr can't read a file directly and outputs the results in 
# standard output, it is often used with pipes (|) and redirects (>>) to allow 
# more complex file content processing.

# Basic tr command syntax
# tr [options] set1 [set2]
# example:
# echo "Miguel" | tr i s | tr u f
# Msgfel
# echo "Miguel" | tr i s | tr u f | tr f x
# Msgxel

# Global Variables / Default Values
# --------------------------------------------------------------------------
PLAINTEXT='ABCDEFGHIJKLMNOPQRSTUVWXYZ'
# --------------------------------------------------------------------------

# Functions*INIT*------------------------------------------------------------*

# Function to flag parameters
funcParameters() {
    while getopts 's:i:o:' flag; do 
        IFS=' ' # Internal Field Separator
        case "$flag" in
            s)  shift=${OPTARG}
                    funcCaesarCypher "$shift";; 
            i)  filename=${OPTARG}
                    funcInputFile "$filename";;
            o)  outputfile=${OPTARG}
                    funcOutputFile "$outputfile";;
            *)  echo "$flag is not a valid flag. Try with:"
                echo "-s <shift>, -i <input file>, -o <output file>";;
        esac
    done
}

# Enconding function to Caesar Cypher
funcCaesarCypher () {
    if [[ -e $filename ]]; then
        while read -r line; do
                for ((i=0;i<${#line};i++)); do
                    char=${line:i:1}
                    findIndex=${PLAINTEXT%%$char*}
                    cipher=$((${#findIndex}-shift))
                    if [[ ${#findIndex} -eq 26 ]]; then
                        cipherText+=$char
                    elif [[ $cipher -gt 25 ]]; then
                         (( cipher-=1 ))
                        cipherText+=${PLAINTEXT:$((${cipher}%25)):1}
                    else   
                        cipherText+=${PLAINTEXT:cipher:1}
                    fi                  
                done
            echo "$cipherText"             
        done < $filename
    fi    
}

funcInputFile() {

    filecontent=$(<$filename)
    funcCaesarCypher "$filecontent"
}

funcOutputFile() {
    echo "$filecontent" > $outputfile
}
# Functions*END*------------------------------------------------------------*

# Script*INIT*--------------------------------------------------------------*
clear
funcParameters "$@"
# Script*END*---------------------------------------------------------------*