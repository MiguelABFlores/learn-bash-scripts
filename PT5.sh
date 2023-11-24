#!/bin/bash
# ----------------------------------PRACTICAL TASK 5----------------------------------- #
# Write script with following functionality:                                            #
#                                                                                       #
# If -v tag is passed, replaces lowercase characters with uppercase and vise versa      #
# If -s is passed, script substitutes <A_WORD> with <B_WORD> in text (case sensitive)   #
# If -r is passed, script reverses text lines                                           #
# If -l is passed, script converts all the text to lower case                           #
# If -u is passed, script converts all the text to upper case                           #
# Script should work with -i <input file> -o <output file> tags                         #
# ------------------------------------------------------------------------------------- #

# Functions*INIT*------------------------------------------------------------*

# Function to flag parameters
funcParameters() {
    while getopts ':i:o:s:vrlu' flag; do
        IFS=' ' # Internal Field Separator
        case "$flag" in
        i)
            inputfile=${OPTARG}
            cp "$inputfile" tmp.txt
            filetmp=tmp.txt
            ;;
        o)
            outputfile=${OPTARG}
            if [ ! -f "$outputfile" ]; then
                touch "$outputfile"
            fi
            ;;
        s)
            subst=1
            substitutes=( $OPTARG )
            AWORD="${substitutes[0]}"
            BWORD="${substitutes[1]}"
            ;;
        v)
            lower_upper=1
            ;;
        r)
            reverse=1
            ;;
        l)
            lowercase=1
            ;;
        u)
            uppercase=1
            ;;
        *)
            echo "$flag is not a valid flag. Try with:"
            echo "-i <input file> -o <output file> -s <Substitutes AWORD with BWORD>"
            echo "Other options:"
            echo "-v (Lowercase to Uppercase and Viceversa)"
            echo "-r (Reverses text lines)"
            echo "-l (Converts text to Lowercase)"
            echo "-u (Converts text to uppercase)"
            ;;
        esac
    done
}

# Syntax Check Function
funcSyntaxCheck() {
    clear
    if [ "$lowercase" = "1" ] && [ "$uppercase" = "1" ] && [ "$lower_upper" = "1" ]; then
        echo "You can only choose one parameter: -l -u and -v"
    elif [ "$lowercase" = "1" ] && [ "$uppercase" = "1" ]; then
        echo "You can only choose one parameter: -l and -u"
    elif [ "$lowercase" = "1" ] && [ "$lower_upper" = "1" ]; then
        echo "You can only choose one parameter: -l and -v"
    elif [ "$uppercase" = "1" ] && [ "$lower_upper" = "1" ]; then
        echo "You can only choose one parameter: -u and -v"
    else
        funcGeneral
    fi
}

# General Function
funcGeneral() {
    # Calling substitute function if flag enabled
    if [ "$subst" = "1" ]; then
        funcSubstitute
    fi

    # Conditionals if any of the flags (-u, -l, -v) is enabled
    if [ "$uppercase" = 1 ]; then
        while read -r upper; do
            echo "${upper}" | tr '[:lower:]' '[:upper:]' >>"$outputfile"
        done <"$filetmp"
    elif [ "$lowercase" = 1 ]; then
        while read -r lower; do
            echo "${lower}" | tr '[:upper:]' '[:lower:]' >>"$outputfile"
        done <"$filetmp"
    elif [ "$lower_upper" = 1 ]; then
        while read -r lowerupper; do
            echo "${lowerupper}" | tr 'A-Za-z' 'a-zA-Z' >>"$outputfile"
        done <"$filetmp"
    elif [ "$uppercase" != 1 ] && [ "$lowercase" != 1 ] && [ "$lower_upper" != 1 ]; then
        cp $filetmp $outputfile
    fi
    funcReverse
    funcPrint
}

# Function to substitute AWORD for BWORD
funcSubstitute() {
    sed -i -e "s/$AWORD/$BWORD/g" "$filetmp"
}

# Function to reverse text lines in a file
funcReverse() {
    if [ "$reverse" = 1 ]; then
        toreverse=$(<"$outputfile")
        echo "$toreverse" | rev >"$outputfile"
    fi
}

# Function to print input and output content
funcPrint() {
    clear
    lines="------------------------------------------------------------------"
    linesb="=================================================================="
    echo "$lines"
    echo "File $inputfile content:"
    echo "$linesb"
    cat "$inputfile"
    echo "$lines"
    echo "File $outputfile content:"
    echo "$linesb"
    cat "$outputfile"
    echo "$lines"
}

# Functions*END*------------------------------------------------------------*

# Script*INIT*--------------------------------------------------------------*
clear
funcParameters "$@"
# Cleaning file before working on it
cat /dev/null >"$outputfile"
funcSyntaxCheck
# Script*END*---------------------------------------------------------------*