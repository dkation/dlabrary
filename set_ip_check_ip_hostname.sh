#!/bin/bash
#9����дһ������ ip ��ַ���޸��������Ľű�������ɲ˵���Ĺ��ܣ��˵����£�
#1.����������
#2.����ip
#3.�鿴ip��������
#4.�˳�
#???? ����ip��ַ������ɹ���Ҫ��ع���ԭ����ip��ַ�����óɹ�����ʾip��ַ���û�����Ҫ�󾡿��ܵĶ�Щ����
#???? ip��ַ�������Ҫʹ������ȥ�ж��Ƿ�Ϸ������Ϸ���ip��ַ��Ҫ���������롣
#???? ����������Ҫ���޸������ļ���������Ч������ҲҪ����ʱ��Ч��
menu(){
echo -e "\t1.set hostname"
echo -e "\t2.set ip"
echo -e "\t3.look ip and hostname"
echo -e "\t4.exit"
}
set_hostname(){
read -p "please input hostname:" host_name
cd /etc/sysconfig
sed -i "/HOSTNAME=/c HOSTNAME=$host_name " network
hostname $host_name
su
}
rec_ip(){
read -p "please input ip address:"  u_ip 
read -p "please input netmask:"  u_mask 
read -p "please input gateway:"  u_gate 
}
check_ip(){
if 
	echo $u_ip  |  egrep "\b([1-9]|[1-9][0-9]|1[0-1][0-9]|12[0-6])(\.([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])){3}\b"
then
	echo "it is A  ipaddress "
elif
	echo $u_ip  | egrep "\b(12[890]|1[3-8][0-9]|19[01])(\.([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])){3}\b"
then
	echo "it is B ipaddress"
elif
	 echo $u_ip  |  egrep "\b(19[2-9]|2[0-1][0-9]|22[0-3])(\.([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])){3}\b"
then     echo "it is C ipaddress"
else
	echo "ipaddress is inlegal"
	read -p "press any key to continue" key
        . t9.sh
fi
ping -i 1  -c 1  -W 1  $u_ip       &>/dev/null
if
        (($?==0))
then
        echo "the ip is exist,can't use"
        read -n 1 -p  "press any key to continue" key
        . t9.sh
else
        echo "you can use the ip"
fi
}
set_ip(){
cd /etc/sysconfig/network-scripts
mkdir bak &>/dev/null
cp ifcfg-eth0  ifcfg-eth0_bak
sed -i "
/IPADDR=/c IPADDR=$u_ip
/NETMASK=/c NETMASK=$u_mask
/GATEWAY=/c GATEWAY=$u_gate
"   ifcfg-eth0
}
main_ip(){
 
rec_ip
check_ip
set_ip
service network restart eth0 &>/dev/null
if
	ping -i 1  -c 1  -W 1  $u_ip       &>/dev/null
then
	echo "ip set ok"
else
	echo "ip set failed,will bak to the before ip"
	cat /etc/sysconfig/network-scripts/bak/ifcfg-eth0_bak  >/etc/sysconfig/network-scripts/ifcfg-eth0
	service network restart eth0
fi
}
look_ip_hostname(){
ip_add=`ip add|egrep "scope global eth0$"|awk '{print $2}'`
echo "ipaddress is $ip_add"
local_name=`cat /etc/sysconfig/network|tail -n -1`
echo "hostname is $local_name"
}
main(){
menu
echo -n "please input your option:" ;read -n1 option
echo
case $option in
1)
set_hostname
;;
2)
main_ip
??
;;
3)
look_ip_hostname
;;
4)
exit
;;
*)
echo "please input correct option"
;;
esac
}
main

