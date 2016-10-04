#!/bin/bash
#3、编写一个脚本实现如下功能的菜单：
#1.备份/var/log 目录
#2.指定备份文件路径备份
#3.根据条件查找文件备份
#4.退出
#说明：
#???? 备份/var/log 目录下的所有文件到/bak/log 目录下，要求文件名是包含当天日期，时间精确到秒，文件名例如：
#2013-6-6-2_30-log.tar.gz，同时要求删除七天前的备份文件，只保留最近 7 天的。
#???? 指定备份文件路径，然后也是备份到/bak 目录下，需要新建一个目录，目录名为当天的日期，然后将备份文件
#存放到当天日期的目录下，文件名里要求包含小时、分钟、秒信息，例如:/bak/2016-6-23/passwd_10-12-20.tar.gz
#???? 根据条件查找,需要让用户输入文件名或者大小或者类型或者几天前的或者属主、 属组等条件， 然后组合去查找，
#查找出来后显示给用户，如果没有符合条件的给予提醒：没有查找到符合条件的文件，如果有符合条件的，备
#份到/bak/find 目录下，备份文件名参考指定备份文件路径的条件，文件名里要求包含年、月、日、小时、分钟、
#秒信息，例如:/bak/find/passwd_2016-6-23-10-12-20.tar.gz
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

