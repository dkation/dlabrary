#!/bin/bash
#11����дһ���ű���ʵ���Զ����ñ��� yum Դ�����Զ���װ mysql ������������� mysql ����Ĺ��ܣ�ͬʱҪ�󿪻����Զ����� mysql ����
mv /etc/yum.repos.d/*.repo  /bak
mkdir /yum &>/dev/null
mount /dev/cdrom /yum
cd /etc/yum.repos.d
cat >local_yum.repo <<EOF
[local_yum]
name=local yum
baseurl=file:///yum
gpgcheck=0
enabled=1
EOF
yum clean all
yum install mysql mysql-server -y
service mysqld start
echo "service mysqld start"  >>/etc/rc.local

