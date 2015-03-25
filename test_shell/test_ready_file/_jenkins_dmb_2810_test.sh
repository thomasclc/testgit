##
#  \file       _jenkins_dmb_2810_test.sh
#  \brief      ���Ե��Ƚű�,����SD��Ŀ¼��(jenkinsר��)
#
#   Copyright (C) 2004-2011 ��������������Ϣϵͳ���޹�˾
#   All rights reserved by ��������������Ϣϵͳ���޹�˾
#
#  \changelog  ��
#   2013��12��18��  ����
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



