#!/bin/sh

delete_config()
{
	test_config_name="$2"
	test_config_file_path="$1"
	debug "delete $1 :  $2 "
	cat $test_config_file_path  | grep -v $2 > $test_config_file_path.tmp
	rm  $test_config_file_path
	mv  $test_config_file_path.tmp $test_config_file_path
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
#	\功能编号 	DMB1820-TS-MT-001-F5
# \功能说明	终端保留配置升级config分区
#	\用例步骤	终端U盘升级config分区，保留配置
#	\验证点		缺失文件能够生成、缺失参数填充、原配置信息保留
##
_test_case_flash_update_config()
{
	if [ -z "`fdisk -l | grep  /dev/sda1`" ]; then 
		debug "ERROR: has no U disk"
		TEST_RESULT=0
		return	
	fi
#before---------------	
	killall -9 dmb_main
	killall -9 boa
	rm $DMB_LOG_PATH/*

	rm -rf  /tmp/system.bak
	cp -rf  /tmp/config/system  /tmp/system.bak

	mount  /dev/sda1  /mnt
	rm  -rf /mnt/*
	mkdir /mnt/upgrade
	touch /mnt/no_reboot
	cp test_flash/update_file_img/*  /mnt/upgrade
	
	#重置config
	cp defaule_config/* /tmp/config/system/
	chmod 777 /tmp/config/system/*
#test------------------	
	mount /dev/mtdblock6 /tmp/config
	set_config_ini_value /tmp/config/system/dmb_3g.ini  	 "start_3g" "1"
	set_config_ini_value /tmp/config/system/dmb_eth0.ini   "dhcp" "0"
	set_config_ini_value /tmp/config/system/dmb_eth0.ini   "static_ip" "192.168.2.2"
	set_config_ini_value /tmp/config/system/dmb_flowstat.ini   "fs_swtich" "1"
	set_config_ini_value /tmp/config/system/dmb_output.ini   "mode" "hdmi"
	set_config_ini_value /tmp/config/system/dmb_output.ini   "width" "1920"
	set_config_ini_value /tmp/config/system/dmb_output.ini   "height" "1080"
	set_config_ini_value /tmp/config/system/dmb_proxy.ini   "proxy_switch" "0"
	set_config_ini_value /tmp/config/system/dmb_proxy.ini   "proxy_server_port" "8081"
	set_config_ini_value /tmp/config/system/dmb_proxy.ini   "proxy_server_ip" "192.168.9.25"
	set_config_ini_value /tmp/config/system/dmb_server.ini   "ip" "192.168.3.1"
	set_config_ini_value /tmp/config/system/dmb_system.ini   "language" "en"
	set_config_ini_value /tmp/config/system/dmb_wifi.ini   "start_wifi" "1"
	
	echo "UTC-09:00"  >  /tmp/config/system/TZ
	debug "`cat  /tmp/config/system/TZ`"
	echo "a:b"  >  /tmp/config/system/dmb.passwd 
	debug "`cat  /tmp/config/system/dmb.passwd `"
	echo "nameserver 192.168.1.100"  >  /tmp/config/system/resolv.conf 
	debug "`cat  /tmp/config/system/resolv.conf `"
	
	delete_config /tmp/config/system/dmb_3g.ini  	 "pf_se"
	delete_config /tmp/config/system/dmb_eth0.ini   "static_gateway" 
	delete_config /tmp/config/system/dmb_flowstat.ini   "period" 
	delete_config /tmp/config/system/dmb_output.ini   "osd" 
	delete_config /tmp/config/system/dmb_proxy.ini   "password" 
	delete_config /tmp/config/system/dmb_server.ini   "pcrt" 
	delete_config /tmp/config/system/dmb_wifi.ini   "static_gateway"
	delete_config /tmp/config/system/dmb_system.ini   "lefttop_show" 

	rm /tmp/config/system/dmb_ssl.ini
	debug 'rm /tmp/config/system/dmb_ssl.ini'
	chmod 777 /tmp/config/system/*
	ls /tmp/config/system/*
	sync
	

	#保留配置升级config
	rm  -rf /tmp/upgrade
	cd /tmp/flashutils/program
	./runupgrade 
	cd -	

	check_config_value /tmp/config/system/dmb_3g.ini  	 "start_3g" "1"
	check_config_value /tmp/config/system/dmb_eth0.ini   "dhcp" "0"
	check_config_value /tmp/config/system/dmb_eth0.ini   "static_ip" "192.168.2.2"
	check_config_value /tmp/config/system/dmb_eth0.ini   "static_netmask" "255.255.255.0"
	check_config_value /tmp/config/system/dmb_flowstat.ini   "fs_swtich" "1"
	check_config_value /tmp/config/system/dmb_output.ini   "mode" "hdmi"
	check_config_value /tmp/config/system/dmb_output.ini   "width" "1920"
	check_config_value /tmp/config/system/dmb_output.ini   "height" "1080"
	check_config_value /tmp/config/system/dmb_proxy.ini   "proxy_switch" "0"
	check_config_value /tmp/config/system/dmb_proxy.ini   "proxy_server_port" "8081"
	check_config_value /tmp/config/system/dmb_proxy.ini   "proxy_server_ip" "192.168.9.25"
	check_config_value /tmp/config/system/dmb_server.ini   "ip" "192.168.3.1"
	check_config_value /tmp/config/system/dmb_system.ini   "language" "en"
	check_config_value /tmp/config/system/dmb_wifi.ini   "start_wifi" "1"
	
	check_text /tmp/config/system/TZ "UTC-09:00" 
	check_text /tmp/config/system/dmb.passwd  "a:b"   
	check_text /tmp/config/system/resolv.conf "nameserver 192.168.1.100"  
	
	check_text /tmp/config/system/dmb_3g.ini  	 "pf_se="
	check_text /tmp/config/system/dmb_eth0.ini   "static_gateway=" 
	check_text /tmp/config/system/dmb_flowstat.ini   "period=" 
	check_text /tmp/config/system/dmb_output.ini   "osd=" 
	check_text /tmp/config/system/dmb_proxy.ini   "password=" 
	check_text /tmp/config/system/dmb_server.ini   "pcrt=" 
	check_text /tmp/config/system/dmb_wifi.ini   "static_gateway="
	check_text /tmp/config/system/dmb_system.ini   "lefttop_show=" 

	check_file_exist /tmp/config/system/dmb_ssl.ini

#after------------------	
##	
	rm -rf /tmp/config/system/*
	cp /tmp/system.bak/* /tmp/config/system/
	rm -rf /tmp/system.bak
	rm -rf /mnt/*
	umount /mnt
}

