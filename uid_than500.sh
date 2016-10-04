#!/bin/bash
awk -F: '$3>500&&$3<2000 {print "username:"$1" uid is "$3" gid is "$4}' /etc/passwd

