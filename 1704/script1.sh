#!/bin/bash


echo Currently Logged User : > output.txt
echo $USER >> output.txt
echo >>output.txt

echo Current Shell : >> output.txt
echo $SHELL >> output.txt
echo >>output.txt

echo Home Directory : >> output.txt
echo $HOME >> output.txt
echo >>output.txt


echo Operating System Type : >> output.txt
lsb_release -a >> output.txt
echo >>output.txt


echo Current Path Settings : >> output.txt
echo $PATH >> output.txt
echo >>output.txt


echo Current Working Directory : >> output.txt
pwd >> output.txt
echo >>output.txt


echo No. of Currently Logged in Users: >> output.txt
who -q >> output.txt

cat output.txt
