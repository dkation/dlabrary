#!/bin/bash
#12����дһ���ű���ִ��ʱ�Զ�չʾ CPU ʹ����ǰ 10 �Ľ��̵� pid �����ּ�ʹ���ʡ��ڴ�ʹ����ǰ 10 �Ľ��̵� pid �����ּ�ʹ���ʡ�
echo "cpu:"
 ps aux|tail -n +2|sort -k3 -n -r|head|awk '{print "PID:"$2,"username:"$1,$3}'
echo "memory:"
ps aux|tail -n +2|sort -k4 -n -r|head|awk '{print "PID:"$2,"username:"$1,$4}'

