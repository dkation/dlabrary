#!/bin/bash
########################
#this script is writen by duks to accomplish "sudo" on 2016_8_27.
#this script can give lots of cmd to many user/group at the same time. 
###################################
clear
echo
#contents
echo "==================================================================="
echo -e "\t\033[31mWith great power comes great responsibility\033[0m"
echo
echo -e "\t\t\033[34m 1.  cmd to user \033[0m"
echo -e "\t\t\033[34m 2.  cmd to group \033[0m"
echo -e "\t\t\033[34m 3.  exit  \033[0m"
echo
echo "==================================================================="
echo
while true 
do
echo -n "please input a number of your option:";read -n1 num
echo


#option result
case "$num" in

 1)
#cmd to user
        echo -n "please input some names of user:";read user_name
        echo -n "please input a passwd to this/those user:";read -s passwd
        echo 
        echo -n "please input some cmd:";read cmd

#array and which 
        arr_which_cmd=($cmd)

        for i in ${arr_which_cmd[@]}
        do

                which_cmd[x++]=`which $i`

        done
                which_cmd2=`echo ${which_cmd[@]} |tr ' ' ','`
#array_user_name        
        array_user_name=($user_name)
for y in ${array_user_name[@]}
do
         if ( id $y &>/dev/null )
        then
                echo "$y ALL=$which_cmd2" >>/etc/sudoers
                echo $passwd|passwd $user_name --stdin &>/dev/null

        else
                useradd $y &>/dev/null
                echo -e "\033[36m$y is not exist and having create!\033[0m"
                echo "$y ALL=$which_cmd2" >>/etc/sudoers
                echo $passwd|passwd $user_name --stdin &>/dev/null
        fi
done
                sleep 1
                echo  -e "\033[5;36myour action is ok!\033[0m"

break
 ;;

 2)
#cmd to group
        echo -n "please input name of group:";read group_name
        echo -n "please input cmd:";read cmd
        arr_which_cmd=($cmd)

        for i in ${arr_which_cmd[@]}
        do

                which_cmd[x++]=`which $i`


        done
                which_cmd2=`echo ${which_cmd[@]} |tr ' ' ','`
                array_group_name=($group_name)
for y in ${array_group_name[@]}
do
        if ( groups $y &>/dev/null )
       then
                echo "%$y ALL=$which_cmd2" >>/etc/sudoers
         else
                 groupadd $y &>/dev/null
                echo -e "\033[36m$y is not exist and having create!\033[0m"
                echo "%$y ALL=$which_cmd2" >>/etc/sudoers
         fi
done
                sleep 1
                echo  -e "\033[5;36myour action is ok!\033[0m"
break
 ;;
 3)
#quit
        exit
break
;;
 *)
#option incorrect
        echo -e "\033[35mplease input correct option!\033[0m"
 ;;
esac
done

