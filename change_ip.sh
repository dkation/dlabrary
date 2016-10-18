#!/usr/bin/python
# coding=utf-8
import psutil
import os
import commands
import re
print "\n    提示：请在确定配置无误后，执行'service network restart + 网口名'手动刷新后生效\n\n"
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
                        print "\t",a,"网口名：%s\tIP地址：%s\t掩码：%s    (ssh使用中...)"%(i,ip_add,ip_mask)
            print "\t",a,"网口名：%s\tIP地址：%s\t掩码：%s"%(i,ip_add,ip_mask)
        print "\t",a,"网口名：%s\tIP地址：未设置\t掩码：未设置"%i
    a += 1
else:
    print "\t",a,"退出\n\n"
option = input('please input your option:')
if option == a:
    exit()
option = option - 1
eth = eth_all[option]
while True:
    ch_ip = raw_input('please input ip address:')
    if os.system('ping -c 1 %s &>/dev/null'%ch_ip) == 0:
        print "此IP正在被使用，请重新输入其它IP地址。"
    else:
        ch_mask = raw_input('please input netmask:')
        os.system('mv /etc/sysconfig/network-scripts/ifcfg-%s /etc/sysconfig/network-scripts/bak/ &>/dev/null'%eth)
        f=open('/etc/sysconfig/network-scripts/ifcfg-%s'%eth,'w+')
        f.write('DEVICE=%s\nTYPE=Ethernet\nBOOTPROTO="none"\nONBOOT="yes"\nIPADDR=%s\nNETMASK=%s\n'%(eth,ch_ip,ch_mask))
        f.close()
        break
