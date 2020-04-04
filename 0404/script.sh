#!/bin/bash

start=`date +%s%N`

# Clears current screen
clear

# Coverts .pdf to .txt
pdftotext -layout result_s1.pdf result

# Separates out results of CS students
grep --no-group-separator -A3 "CHN18CS" result > result_cs

# Cleans up and arranges the data in organised manner
tr  '\n' ' ' < result_cs > result_temp
sed 's/\t//g' result_temp > result_temp1
awk '{$1=$1;print}' result_temp1 > result_temp
sed 's/CHN/\nCHN/g' result_temp > result_temp1
tr  ',' ' ' < result_temp1 > result_all


# Sorting out Results of C Batch only using Register No. of Students
awk -F "\"*,\"*" '{print $1}' class_list.txt > reg_no
grep -f reg_no result_all > result_c


# Applying Grade Points to Grades
sed -i 's/(O)/ 10/g' result_c
sed -i 's/(A+)/ 9/g' result_c
sed -i 's/(A)/ 8.5/g' result_c
sed -i 's/(B+)/ 8/g' result_c
sed -i 's/(B)/ 7/g' result_c
sed -i 's/(C)/ 6/g' result_c
sed -i 's/(P)/ 5/g' result_c
sed -i 's/(F)/ 0/g' result_c
sed -i 's/(FE)/ 0/g' result_c
sed -i 's/(I)/ 0/g' result_c
sed -i 's/(Absent)/ 0/g' result_c

# Seperating the Grade Points
awk  '{  
	print $1,$3,$5,$7,$9,$11,$13,$15,$17,$19
 }' result_c > gp 
 
# Computes SGPA and counts subjects failed in

awk '{
	sum = 0
	flag = 0
	fails = 0
	for(var =2; var<=NF; var++)
	{	
		if($var == 0) 
		{
			flag = 1
			fails = fails - 1
		}
		sum += $var
	}
	cgpa = sum/9
	if (flag == 0) {	
	 	printf("%s %0.2f\n",$1,cgpa)
	}
	if (flag == 1) {
		printf("%s %d\n",$1,fails)
	}
}' gp > s1gpa_raw


# Repeating Everything For S2
pdftotext -layout result_s2.pdf result
grep --no-group-separator -A3 "CHN18CS" result > result_cs

tr  '\n' ' ' < result_cs > result_temp
sed 's/\t//g' result_temp > result_temp1
awk '{$1=$1;print}' result_temp1 > result_temp
sed 's/CHN/\nCHN/g' result_temp > result_temp1
tr  ',' ' ' < result_temp1 > result_all

grep -f reg_no result_all > result_c

sed -i 's/(O)/ 10/g' result_c
sed -i 's/(A+)/ 9/g' result_c
sed -i 's/(A)/ 8.5/g' result_c
sed -i 's/(B+)/ 8/g' result_c
sed -i 's/(B)/ 7/g' result_c
sed -i 's/(C)/ 6/g' result_c
sed -i 's/(P)/ 5/g' result_c
sed -i 's/(F)/ 0/g' result_c
sed -i 's/(FE)/ 0/g' result_c
sed -i 's/(I)/ 0/g' result_c
sed -i 's/(Absent)/ 0/g' result_c

awk  '{  
	print $1,$3,$5,$7,$9,$11,$13,$15,$17,$19
 }' result_c > gp 
 
awk '{
	sum = 0
	flag = 0
	fails = 0
	for(var =2; var<=NF; var++)
	{	
		if($var == 0) 
		{
			flag = 1
			fails = fails - 1
		}
		sum += $var
	}
	cgpa = sum/9
	if (flag == 0) {	
	 	printf("%s %0.2f\n",$1,cgpa)
	}
	if (flag == 1) {
		printf("%s %d\n",$1,fails)
	}
}' gp > s2gpa_raw


# Joining S1 and S2 SGPAs
join s1gpa_raw s2gpa_raw > sgpa


# Calculating CGPA & Whether the Student have Completed First Year
awk '{
    sum = 0
    flag = 0
    for(var =2; var<=NF; var++)
	{	
		if($var <= 0) 
		{
			flag = 1
			$var = "Failed(" $var*-1 ")"
		}
		sum += $var
	}
	cgpa = sum/2
	if (flag == 0) {	
	 	printf("%s,%s,%s,%0.2f\n",$1,$2,$3,cgpa)
	}
	if (flag == 1) {
		printf("%s,%s,%s,Not Completed\n",$1,$2,$3)
		}
	}' sgpa > cgpa
	

# Joining CGPA & Class List
join -1 1 -t, cgpa class_list.txt > result


# Rearranging the Columns
awk -F, '{
    printf("%s,%s,%s,%s,%s,%s\n",$6,$1,$5,$2,$3,$4)
}' result > output.txt


# Adding Column Names
sed -i '1iRoll No.,Register No.,Name,S1 SGPA,S2 SGPA,CGPA' output.txt


# Displaying the Result using Column Command
column -t -s',' output.txt


# Removing the Process & Temp files
rm result_temp1
rm result_temp
rm result_cs
rm result_c
rm result
rm result_all
rm reg_no
rm gp
rm sgpa
rm s1gpa_raw
rm s2gpa_raw
rm cgpa

end=`date +%s%N`
echo Execution time was `expr $end - $start` nanoseconds.
