#!/bin/bash
echo -n "please input two numbers:";read num1 num2
num=`echo "$num1 > $num2"|bc`

if [ $num1 == $num2 ]
then
	echo "$num1=$num2"
elif (($num==1))
then
	echo "$num1>$num2"
else 
	echo "$num1<$num2"
fi 

