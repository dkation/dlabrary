#!/bin/bash
#4����дһ���ű�ʵ���ж��û�����ķ��������ĸ��ȼ���
#A��Ҫ���û��������
#B�������ķ�ΧΪ0-100�֣�����û������������ַ������������û�����0-100��Χ�ڵ�����
#C������û�����90-100�����֣������good job��may be you can try join alibaba��
#D������û�����80-89�����֣������nice��may be you can try join tencent��
#E������û����60-79�����֣������come on��baby!may be you can try join facebook��
#F������û�����0-59�����֣������keep on fighting��may be you can try join google��

echo -n "please input yout point:";read point
if echo $point |egrep [^0-9] &>/dev/null
then 
	echo "please input number of 0-100!"    
else
	if (( point >= 90 && point <=100 )) &>/dev/null
	then
		echo "good job��may be you can try join alibaba"
	elif (( point >= 80 && point <=89 ))  &>/dev/null
	then    
		echo "nice��may be you can try join tencent"
	elif (( point >= 60 && point <=79 )) &>/dev/null
	then    
		echo "come on��baby!may be you can try join facebook"
	else (( point >= 0 && point <=59 ))  &>/dev/null    
		echo "keep on fighting��may be you can try join google"
	fi
fi

