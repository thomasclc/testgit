#!/bin/sh

check_upgrade_result()
{
	if [ -f /mnt/upgrade/*$1* ] ; 
	then
		mtdblock=`cat /mnt/flash_info.ini | awk -F: -v val="$1" '$1~val {print $2}' `
		size=` ls -l /mnt/upgrade | awk  -v val="$1" '$9~val {print $5}' `
		debug " name = $1  , mtdblock = $mtdblock , size = $size"
		debug "`dd if=$mtdblock of=/root/test_flash_size bs=1 count=$size`"		
		file_md5_compare "/root/test_flash_size" "/mnt/upgrade/`ls /mnt/upgrade | grep $1`"
		rm  /root/test_flash_size
	else
		debug "no upgrade file: $1"	
	fi 
}

before_class()
{
 echo "before class"	
}

after_class()
{
	echo "after class"
}
before_case()
{
	echo -before_case
}

after_case()
{
	echo -after_case
}

##
#	\���ܱ�� 
# \����˵��	�ն������ȶ��Բ���
#	\��������	�ն�U������flash��������������֤�����Ƿ�ɹ�
#	\��֤��		�ȶ�������������ݸ��������Ƿ�һ��
##
_test_case_flash_update()
{

		#config file env
		export CONFIG_PATH=/tmp/config/system
		#minigui env
		export MG_CFG_PATH=/tmp/upgrade/res/minigui
		#3G/wifi env
		export DMB_WIRELESS_WIFI_PATH=/tmp/upgrade/wireless/wifi_network
		export DMB_WIRELESS_3G_PATH=/tmp/upgrade/wireless/3g_network
		#lib env
		export LD_LIBRARY_PATH=/tmp/upgrade/lib
		export DMB_DOWNLOAD_PATH=/root/dmb/download 
	
		killall -9 dmb_main
		killall -9 boa
		watchdog > /dev/null &
		watchdog > /dev/null &
		mount  test_flash/mnt  /mnt
		
		mkdir /tmp/upgrade
		cd /tmp/upgrade
		cp /tmp/flashutils/*  ./ -arf
		cd -
		
	  cd /tmp/upgrade/program
	  ./load_upgrade_drv
	  ./flash_utils -fusb_update
		cd -	
		
		check_upgrade_result "dmb"
		check_upgrade_result "root"
		check_upgrade_result "config"
		check_upgrade_result "flashutils"
	 	check_upgrade_result "kernel"
	#	check_upgrade_result "logo"

		mount /dev/mtdblock7   /tmp/dmb
		cp 	 test_flash/mnt/rundmb   /tmp/dmb/program/
		test_check_result
		while [ 1 ] ;
		do 
			echo "wait 10 s for reboot"
			sleep 10
			sysreboot
		done
}