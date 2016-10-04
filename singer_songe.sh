#!/bin/bash
##########菜单
while :
do
echo -e "\t\t\t\e[1;31m*****\e[0m\e[1;5;32m选歌系统\e[0m\e[1;31m*****\e[0m"
echo -e "\t\t\e[1;31m1.随机选择歌手唱歌\e[0m"
echo -e "\t\t\e[1;31m2.查看剩余歌手\e[0m"
echo -e "\t\t\e[1;31m3.查看剩余歌曲\e[0m"
#########################提示输入

echo -n -e "\e[1;32m请输入选项:\e[0m";read cho


#########################定义数组
singers=($(cat singers.txt))
sings=($(cat sings.txt))

#########################

case "$cho" in

        1)
#########################倒计时        for i
        for i  in 3 2 1
        do
                echo
                echo -e -n "\b$i"
                sleep 1
        done
#########################定义随机下标

        n=$((RANDOM % ${#singers[@]}))
        n1=$((RANDOM % ${#sings[@]}))

########################将输出的歌名和歌手名追加到两个文件里

        echo ${singers[$n]} >>singer_out.txt
        echo ${sings[$n1]} >>sing_out.txt

########################取消已选出来的参数
        unset singers[$n]
        unset sings[$n1]

########################将剩下的参数重新覆盖到文件里

        echo ${singers[@]} >singers.txt
        echo ${sings[@]}  >sings.txt

#######################判断歌手和歌名的文件里是否还有内容，没有的话将重新更新
        if      ((${#singers[@]}==0))
        then
                cat singer_out.txt >singers.txt
                >singer_out.txt
                echo -e "\e[1;5;31m歌手库已重新更新\e[0m"
        fi

        if      ((${#sings[@]}==0))
        then
                cat sing_out.txt >sings.txt
                >sing_out.txt
                echo -e "\e[1;5;33m歌曲库已重新更新\e[0m"
        fi
        ;;

######################查询剩余歌手

        2)
        echo -e "还有\e[1;5;31m${#singers[@]}\e[0m位歌手:\n\t\t\e[1;32m${singers[@]}\e[0m"
        ;;

#####################查询剩余歌名

        3)
        echo -e "还有\e[1;5;31m${#sings[@]}\e[0m首歌曲:\n\t\t\e[1;32m${sings[@]}\e[0m"
        ;;

        0)
                exit
        ;;

        *)
        echo -e "\e[1;36m请输入正确的选项\e[0m"
        ;;


esac
        echo 
done

