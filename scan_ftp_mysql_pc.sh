#!/bin/bash
for i in {1..200}
do
        (nc -z 172.16.77.$i 21 &>/dev/null  
        if (( $? == 0 ))
        then
                echo "172.16.77.$i up"  >>open_ftp_pc_up.txt
        else
                echo "172.16.77.$i down" >>open_ftp_pc_down.txt
        fi)&
        (nc -z 172.16.77.$i 3306 &>/dev/null  
        if (( $? == 0 ))
        then
                echo "172.16.77.$i up"  >>open_mysql_pc_up.txt
        else
                echo "172.16.77.$i down" >>open_mysql_pc_down.txt
        fi)&
done
sleep 2
ftp_live_pc_num=`cat open_ftp_pc_up.txt |wc -l`
ftp_down_pc_num=`cat open_ftp_pc_down.txt |wc -l`
mysql_live_pc_num=`cat open_mysql_pc_up.txt |wc -l`
mysql_down_pc_num=`cat open_mysql_pc_down.txt |wc -l`
echo "####################  ftp  scan stastics##########################"
echo "there are ftp $ftp_down_pc_num is down"
echo "there are ftp $ftp_live_pc_num is up"
echo "ftp live pc list:"
cat open_ftp_pc_up.txt
rm -rf open_ftp_pc_*.txt
echo "####################  mysql  scan stastics##########################"
echo "there are mysql $mysql_down_pc_num is down"
echo "there are mysql $mysql_live_pc_num is up"
echo "mysql live pc list:"
cat open_mysql_pc_up.txt
rm -rf open_mysql_pc_*.txt

