#!/bin/bash
# Script name: Read_Input.sh
for i in `seq 1 100`
do
    for var in $* 
    do
        echo "command line contains: $var"
    done
done

#Run command to testbash/zsh:
#time bash ./Read_Input.sh “some_long_sentance”
#time zsh ./Read_Input.sh “some_long_sentance”