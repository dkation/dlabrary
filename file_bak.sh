#!/bin/bash
#3����дһ���ű�ʵ�����¹��ܵĲ˵���
#1.����/var/log Ŀ¼
#2.ָ�������ļ�·������
#3.�������������ļ�����
#4.�˳�
#˵����
#???? ����/var/log Ŀ¼�µ������ļ���/bak/log Ŀ¼�£�Ҫ���ļ����ǰ����������ڣ�ʱ�侫ȷ���룬�ļ������磺
#2013-6-6-2_30-log.tar.gz��ͬʱҪ��ɾ������ǰ�ı����ļ���ֻ������� 7 ��ġ�
#???? ָ�������ļ�·����Ȼ��Ҳ�Ǳ��ݵ�/bak Ŀ¼�£���Ҫ�½�һ��Ŀ¼��Ŀ¼��Ϊ��������ڣ�Ȼ�󽫱����ļ�
#��ŵ��������ڵ�Ŀ¼�£��ļ�����Ҫ�����Сʱ�����ӡ�����Ϣ������:/bak/2016-6-23/passwd_10-12-20.tar.gz
#???? ������������,��Ҫ���û������ļ������ߴ�С�������ͻ��߼���ǰ�Ļ��������� ����������� Ȼ�����ȥ���ң�
#���ҳ�������ʾ���û������û�з��������ĸ������ѣ�û�в��ҵ������������ļ�������з��������ģ���
#�ݵ�/bak/find Ŀ¼�£������ļ����ο�ָ�������ļ�·�����������ļ�����Ҫ������ꡢ�¡��ա�Сʱ�����ӡ�
#����Ϣ������:/bak/find/passwd_2016-6-23-10-12-20.tar.gz
echo  -e "\t\t\tmenu"
echo  -e "\t1.backups directory of /var/log"
echo  -e "\t2.backups a directory to /bak"
echo  -e "\t3.find bak of directory"
echo  -e "\t4.exit"
while true
do
echo
echo -n "please input yout option:";read -n1 option_num

case $option_num in

1)
mkdir -p /bak/log &>/dev/null
time=`date +%F-%H_%M`
tar -czf /bak/log/${time}-log.tar.gz /var/log  &>/dev/null
find /bak/log/ -mtime +7 -exec rm -rf {} \;&>/dev/null
;;
2)
echo
echo -n "please input absolutely route to bak:";read route
#echo -n "please input a name for bak:";read name
name=`basename $route`
if [ -e $route ]
then
	time_d=`date +%F`
	time_h=`date +%T`
	mkdir -p /bak/$time_d &>/dev/null
	tar -czf /bak/$time_d/${name}_${time_h}.tar.gz  $route &>/dev/null
else
	echo "$route is not exist~"
fi
;;
3)
echo
echo -n "please input condition of directory:";read condition
count_num=`find / $condition |wc -l`
if (( count_num == 0 ))
then
	echo "sorry,no find any file"
else
	time=`date +%F-%T`
	mkdir -p /bak/find &>/dev/null
	echo -n "please input a name for bak:";read name
	find / $condition -exec tar -czf  /bak/find/$name_$time.tar.gz {} \; &>/dev/null 
fi
;;
4)
echo
exit
;;
*)
echo "please input correct option!"
;;
esac
done

