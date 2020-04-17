#!/bin/bash

echo Kernal Name : > output.txt
uname -s >> output.txt
echo >>output.txt


echo Kernal Release : >> output.txt
uname -r >> output.txt
echo >>output.txt

echo Kernal Version : >> output.txt
uname -v >> output.txt
echo >>output.txt

echo Network Node Hostname :>> output.txt
uname -n >> output.txt
echo >>output.txt

echo Machine Hardware Arch : >> output.txt
uname -m >> output.txt
echo >>output.txt

echo Processor Type : >> output.txt
uname -p >> output.txt
echo >>output.txt

echo List of available Shells : >> output.txt
chsh -l >> output.txt
echo >>output.txt

echo CPU Information : >> output.txt
lscpu >> output.txt
echo >>output.txt

echo Memory Information : >> output.txt
free -h >> output.txt
echo >>output.txt

echo Storage Devices : >> output.txt
lsblk >> output.txt
echo >>output.txt

echo File System Information : >> output.txt
df >> output.txt
echo >>output.txt

cat output.txt
