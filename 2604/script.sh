#!/bin/bash

clear
ctr=work

while [ $ctr == work ];
do
    echo
    echo Menu Driven Calculator
    echo
    echo 1.Addition
    echo 2.Subtraction
    echo 3.Multiplication
    echo 4.Division
    echo 5.Exit
    echo
    read -p "Enter a option :" opt
    
    case $opt in
        1)
        read -p "Enter first number : " num1
        read -p "Enter second number : " num2
        echo
        echo The answer is $(($num1+$num2))
        
        ;;
        
        2)
        read -p "Enter first number : " num1
        read -p "Enter second number : " num2
        echo
        echo The answer is $(($num1-$num2))
        ;;
        
        3)
        read -p "Enter first number : " num1
        read -p "Enter second number : " num2
        echo
        echo The answer is $(($num1*$num2))
        ;;

        4)
        read -p "Enter first number : " num1
        read -p "Enter second number : " num2
        echo
        if [[ $num2 == 0 ]]
        then
            echo Division not Possible!
        else
        echo The answer is $(($num1/$num2))
        fi
        ;;
        
        5)
        clear
        exit
        ;;
        
        *)
        echo
        echo Not a Valid Option
        ;;
        esac

done

