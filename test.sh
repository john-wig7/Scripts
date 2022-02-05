#!/bin/bash

# This is a sandpit for trying new ideas and learning how BASH works

# variables
animal='crocodile'
echo $animal
echo "${animal}"


#assigning function to variable with backtick
todaysdate=`date "+%d/%m/%Y %H:%M:%S"`
echo $todaysdate
echo "${todaysdate}"

myArray=("one" "two" "three")
echo "${myArray[0]}"
echo "${myArray[1]}"
echo "${myArray[2]}"

a=1234
b=12.34
c="some text"

echo "${a}"
echo "${b}"
echo "${c}"

#functions

function myfunc () {
    echo "this is the result" 
    echo "for all to see"
    echo "again and again"
    b=12.35
    echo $b
}

result=`myfunc`
echo $result
echo $b
