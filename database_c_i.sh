#!/bin/bash
#8、编写一个脚本对数据库进行操作，要求如下：
#a)  创建一个数据库 chinaitsoft
#b)  新建一个表 student，表的字段有 id、name、sex、address、phone、grade 。id 是主键，具体类型自己定义
#c)  往表里插入 3 条数据，具体自己定义
#d)  查询出所有的插入的数据，显示出来
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

