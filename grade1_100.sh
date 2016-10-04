#!/bin/bash
#4、编写一个脚本实现判断用户输入的分数属于哪个等级。
#A、要求用户输入分数
#B、分数的范围为0-100分，如果用户输入其他的字符和数字提醒用户输入0-100范围内的数字
#C、如果用户输入90-100的数字，输出“good job，may be you can try join alibaba”
#D、如果用户输入80-89的数字，输出“nice，may be you can try join tencent”
#E、如果用户输出60-79的数字，输出“come on，baby!may be you can try join facebook”
#F、如果用户输入0-59的数字，输出“keep on fighting，may be you can try join google”

echo -n "please input yout point:";read point
if echo $point |egrep [^0-9] &>/dev/null
then 
	echo "please input number of 0-100!"    
else
	if (( point >= 90 && point <=100 )) &>/dev/null
	then
		echo "good job，may be you can try join alibaba"
	elif (( point >= 80 && point <=89 ))  &>/dev/null
	then    
		echo "nice，may be you can try join tencent"
	elif (( point >= 60 && point <=79 )) &>/dev/null
	then    
		echo "come on，baby!may be you can try join facebook"
	else (( point >= 0 && point <=59 ))  &>/dev/null    
		echo "keep on fighting，may be you can try join google"
	fi
fi

