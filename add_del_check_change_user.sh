#!/bin/bash
#10����дһ���ű�ʵ�����湦�ܣ�
#A����дһ���˵���
#1.add user
#2.delete user
#3.query user information
#4.reset user��s password
#5.modify user��s information
#6.exit

#B��ʵ������˵���Ĺ��ܣ�
#1.����û�����û��Ѿ����ڸ�������
#2.ɾ���û������û�ȷ���Ƿ�ɾ��
#3.��ѯ�û�������ʾ��Щ��������Ϣ
#4.�������룬�����û������û���������
#5.�����޸��û��� uid��gid��shell����Ŀ¼
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
4.reset user��s password 
5.modify user��s information 
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

