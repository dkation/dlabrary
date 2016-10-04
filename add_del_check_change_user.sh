#!/bin/bash
#10、编写一个脚本实现下面功能：
#A、编写一个菜单：
#1.add user
#2.delete user
#3.query user information
#4.reset user’s password
#5.modify user’s information
#6.exit

#B、实现上面菜单里的功能：
#1.添加用户如果用户已经存在给予提醒
#2.删除用户，让用户确认是否删除
#3.查询用户可以显示有些的所有信息
#4.设置密码，提醒用户输入用户名和密码
#5.可以修改用户的 uid、gid、shell、家目录
user_add(){
read -p "please input username to add:" u_name
if id $u_name &>/dev/null
then
	ehco "user $u_name is exist"
else 
	useradd $u_name
fi
}
user_del(){
read -p "please input username to del:" u_name
  if id $u_name &>/dev/null
  then
             read -p "are your sure del $u_name(y/n):" y_n
	if [[  $y_n == y ]]     
	then  userdel -r $u_name
	fi
  else
		echo "user $u_name is not exist"
  fi
}
ch_user(){
read -p "please input username:" u_name
if id $u_name &>/dev/null
then
	echo "
	1.uid
	2.gid
	3.shell
	4.home
"
	read -p "please input your option to change user:" op_num
case $op_num in
1)
read -p "please input uid of $u_name:" u_id
usermod -u$u_id $u_name
;;    
2)
read -p "please input gid of $u_name:" g_id
usermod -g$g_id $u_name
;;
3)
read -p "please input shell of $u_name:" sh_user
usermod -s$sh_user $u_name
;;
4)
read -p "please input home dir of $u_name:" ho_user
usermod -d$ho_user $u_name
;;
*)
echo "option is incorrect"
exit
;;
esac
else
        echo "user $u_name is no exist"
fi
}
echo "1.add user 
2.delete user 
3.query user information 
4.reset user’s password 
5.modify user’s information 
6.exit"
read -p "please input your option:" option
case $option in
1)
user_add
;;
2)
user_del
;;
3)
read -p "please input username to select:" us_name
cat /etc/passwd |egrep "\<^$us_name\>"
;;
4)
read -p "please input username:" u_name
read -p "please input passwd of $u_name:" pass_wd
echo $pass_wd |passwd $u_name --stdin  &>/dev/null
;;
5)
ch_user
;;
6)
exit
;;
*)
echo "option is incorrect"
;;
esac

