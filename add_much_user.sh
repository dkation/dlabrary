#!/bin/bash
#5����д�ű�ʵ�������½��û��Ĺ��ܣ�
#A�������û�������û���������liu����liu��Ϊ�û�����ǰ׺
#B�������û��������Ҫ�������û����������磺16 ����˼����Ҫ�½�16���û�
#C�������û��������Ҫ�������û����õ����룬���磺123456a
#D�������ʾ�����½����û������ֺ�uid��gid����Ŀ¼��shell
echo -n "please input username profix:";read pro_name
echo -n "please input add count of username:";read num
echo -n "please input username passwd:";read passwd
for i in  ` seq $num `
do
	useradd $pro_name$i &>/dev/null
	echo "$passwd"|passwd $pro_name$i --stdin &>/dev/null
done
cat /etc/passwd |egrep "^$pro_name"|awk -F: '{print $1,$3,$4,$6,$7}'

