#!/bin/bash
#11、编写一个脚本，实现自动配置本地 yum 源，再自动安装 mysql 软件，并且启动 mysql 服务的功能，同时要求开机能自动启动 mysql 服务。
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

