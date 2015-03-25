##
#  \file       _jenkins_dmb_2810_test.sh
#  \brief      测试调度脚本,存于SD卡目录下(jenkins专用)
#
#   Copyright (C) 2004-2011 福建星网视易信息系统有限公司
#   All rights reserved by 福建星网视易信息系统有限公司
#
#  \changelog  ：
#   2013年12月18日  创建
##
#!/bin/sh
while [ ! -d  /mnt/DMB2810 ] ;
do
	mount -o nolock  -t nfs 192.168.65.114:/work /mnt
done

while [ ! -f /mnt/DMB2810/update_finish ]
do
	sleep 60
	echo "wait for test build" 
done

cd /mnt/DMB2810/dmb_test_sh_2810

./do_all_test.sh 

echo "test finish , wait 300s to reboot"
sysreboot



