#!/bin/bash
#12、编写一个脚本，执行时自动展示 CPU 使用率前 10 的进程的 pid 和名字及使用率、内存使用率前 10 的进程的 pid 和名字及使用率。
echo "cpu:"
 ps aux|tail -n +2|sort -k3 -n -r|head|awk '{print "PID:"$2,"username:"$1,$3}'
echo "memory:"
ps aux|tail -n +2|sort -k4 -n -r|head|awk '{print "PID:"$2,"username:"$1,$4}'

