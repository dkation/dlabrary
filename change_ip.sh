#!/usr/bin/python
# coding=utf-8
import psutil
import os
import commands
import re
print "\n    ��ʾ������ȷ�����������ִ��'service network restart + ������'�ֶ�ˢ�º���Ч\n\n"
eth_all = commands.getoutput("ip add|egrep -o 'eno[0-9]+:'|tr -d :").splitlines()
a = 1
now_connect_all = psutil.net_connections()
for i in eth_all:
    ip_add = psutil.net_if_addrs()['%s'%i][0][1]
    ip_mask = psutil.net_if_addrs()['%s'%i][0][2]
    if os.system('ping -c 1 %s &>/dev/null'%ip_add) == 0:
        for x in now_connect_all:
            if x[3][1] == 22:
                now_connect_eth = x[3][0]
                if re.match('[1-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}',now_connect_eth,flags=0):
                    if ip_add == now_connect_eth:
                        print "\t",a,"��������%s\tIP��ַ��%s\t���룺%s    (sshʹ����...)"%(i,ip_add,ip_mask)
            print "\t",a,"��������%s\tIP��ַ��%s\t���룺%s"%(i,ip_add,ip_mask)
        print "\t",a,"��������%s\tIP��ַ��δ����\t���룺δ����"%i
    a += 1
else:
    print "\t",a,"�˳�\n\n"
option = input('please input your option:')
if option == a:
    exit()
option = option - 1
eth = eth_all[option]
while True:
    ch_ip = raw_input('please input ip address:')
    if os.system('ping -c 1 %s &>/dev/null'%ch_ip) == 0:
        print "��IP���ڱ�ʹ�ã���������������IP��ַ��"
    else:
        ch_mask = raw_input('please input netmask:')
        os.system('mv /etc/sysconfig/network-scripts/ifcfg-%s /etc/sysconfig/network-scripts/bak/ &>/dev/null'%eth)
        f=open('/etc/sysconfig/network-scripts/ifcfg-%s'%eth,'w+')
        f.write('DEVICE=%s\nTYPE=Ethernet\nBOOTPROTO="none"\nONBOOT="yes"\nIPADDR=%s\nNETMASK=%s\n'%(eth,ch_ip,ch_mask))
        f.close()
        break
