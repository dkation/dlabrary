#!/bin/bash
#8����дһ���ű������ݿ���в�����Ҫ�����£�
#a)  ����һ�����ݿ� chinaitsoft
#b)  �½�һ���� student������ֶ��� id��name��sex��address��phone��grade ��id �����������������Լ�����
#c)  ��������� 3 �����ݣ������Լ�����
#d)  ��ѯ�����еĲ�������ݣ���ʾ����
mysql -uroot -p123456 <<EOF
create database chinaitsoft;
use chinaitsoft
create table student(id int PRIMARY KEY,name varchar(10),sex varchar(5),address varchar(20),phone decimal(20),grade varchar(20));
EOF
for i in `seq 3`
do
read -p "please input id,name,sex,address,phone,grade by order:" id name sex address phone grade
mysql -uroot -p123456 <<EOF
use chinaitsoft
insert into student values($id,'$name','$sex','$address','$phone','$grade');
EOF
done
mysql -uroot -p123456 <<EOF
use chinaitsoft
select * from student;
EOF

