#!/bin/bash
#5、编写脚本实现如下新建用户的功能：
#A、接受用户输入的用户名，例如liu，将liu作为用户名的前缀
#B、接受用户输入的需要创建的用户数量，例如：16 ，意思就是要新建16个用户
#C、接受用户输入的想要给所有用户设置的密码，例如：123456a
#D、最后显示所有新建的用户的名字和uid、gid、家目录、shell
echo -n "please input username profix:";read pro_name
echo -n "please input add count of username:";read num
echo -n "please input username passwd:";read passwd
for i in  ` seq $num `
do
	useradd $pro_name$i &>/dev/null
	echo "$passwd"|passwd $pro_name$i --stdin &>/dev/null
done
cat /etc/passwd |egrep "^$pro_name"|awk -F: '{print $1,$3,$4,$6,$7}'

