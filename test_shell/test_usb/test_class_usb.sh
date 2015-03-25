##
#  \file       test_class_usb.sh
#  \brief      U�̹�����ؽű�
#
#   Copyright (C) 2004-2011 ��������������Ϣϵͳ���޹�˾
#   All rights reserved by ��������������Ϣϵͳ���޹�˾
#
#  \changelog  ��
#   2013��2��3��  ����
##
#!/bin/sh
before_class()
{
	killall -9 dmb_main
	rm $DMB_LOG_PATH/*
}

after_class()
{
	killall -9 dmb_main
	test_log_path="`cat $TEST_LOG_PATH/test.info | awk -F= '$1~/logs_path/  {print $2}'`"
	cat  $DMB_LOG_PATH/$LOG_NAME.* > $test_log_path".log"
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
#	\���ܱ�� 	DMB1820-TS-TM-001-F25
# \����˵��	�ն�U�̵�������
#	\��������	���뺬�������ļ���U�����ն˳����������
#	\��֤��		���U�����漰�޸ĵ��������Ƿ�ȫ������
##
_test_case_usb_load_config()
{
	if [ -z "`fdisk -l | grep  /dev/sda1`" ]; then 
		debug "ERROR: has no U disk"
		TEST_RESULT=0
		return	
	fi
	#��������
	rm -rf  /tmp/system.bak
	cp -rf  /tmp/config/system  /tmp/system.bak
	#׼��U���ļ�
	mount /dev/sda1 /mnt
	rm -rf  /mnt/*
	cp -rf ./test_usb/loadconfig_file/dmb  /mnt/
	umount /mnt
	#���ó�ʼ���û���
	mv /root/dmb/download/worktime.xml 			/tmp/
	mv /root/dmb/download/downloadtime.xml 	/tmp/

	cp defaule_config/* /tmp/config/system/
	chmod 777 /tmp/config/system/*
	
	sync

	
	
	#�������Գ���	
	debug "start dmb_main"
	cd $DMB_PATH
	./dmb_load_drv
	./dmb_main  &
	cd -
	debug "wait 10s for start the funtion ..."
	sleep 10
	debug "wait for doing test"
	sleep 10
	
	killall -9 dmb_main
#	check_config_value

	
	check_config_value /tmp/config/system/dmb_3g.ini  	 "start_3g" "1"
	check_config_value /tmp/config/system/dmb_3g.ini  	 "3g_type" "10"
	check_config_value /tmp/config/system/dmb_3g.ini  	 "baud_rate" "921600"
	check_config_value /tmp/config/system/dmb_3g.ini  	 "3g_vid" "19d2"
	check_config_value /tmp/config/system/dmb_3g.ini  	 "3g_pid" "0016"
	check_config_value /tmp/config/system/dmb_3g.ini  	 "pf_se" "20"
	check_config_value /tmp/config/system/dmb_3g.ini  	 "pn_se" "20"
	check_config_value /tmp/config/system/dmb_3g.ini  	 "port_num" "2"
	check_config_value /tmp/config/system/dmb_3g.ini  	 "port_cmd" "2"
	
	check_config_value /tmp/config/system/dmb_eth0.ini   "dhcp" "0"
	check_config_value /tmp/config/system/dmb_eth0.ini   "static_ip" "192.168.2.2"
	check_config_value /tmp/config/system/dmb_eth0.ini   "static_netmask" "255.255.255.0"
	check_config_value /tmp/config/system/dmb_eth0.ini   "static_gateway" "192.168.2.1"
	
	
	check_config_value /tmp/config/system/dmb_output.ini   "mode" "hdmi"
	check_config_value /tmp/config/system/dmb_output.ini   "width" "1920"
	check_config_value /tmp/config/system/dmb_output.ini   "height" "1080"
	check_config_value /tmp/config/system/dmb_output.ini   "rotate" "270"
	check_config_value /tmp/config/system/dmb_output.ini   "contrast" "64"
	check_config_value /tmp/config/system/dmb_output.ini   "light"  "56"
	
	check_config_value /tmp/config/system/dmb_proxy.ini   "proxy_switch" "1"
	check_config_value /tmp/config/system/dmb_proxy.ini   "proxy_server_port" "8081"
	check_config_value /tmp/config/system/dmb_proxy.ini   "proxy_server_ip" "192.168.9.25"
	
	check_config_value /tmp/config/system/dmb_server.ini   "ip" "192.168.66.90"
	
	check_config_value /tmp/config/system/dmb_system.ini   "volume" "0"

	
	check_text /tmp/config/system/TZ "UTC-09:30" 
	check_text /tmp/config/system/resolv.conf "nameserver 110.90.119.99"  
	
	
	sed 's/sequence\=\"terminal[1-9][1-9]\"//' /root/dmb/download/dialtime.xml   > /root/dmb/download/dialtime.xml.tmp
	sed 's/sequence\=\"server[1-9][1-9]\"//' 	/root/dmb/download/downloadtime.xml   > /root/dmb/download/downloadtime.xml.tmp
	sed 's/sequence\=\"server[1-9][1-9]\"//' 	/root/dmb/download/volume.xml   > /root/dmb/download/volume.xml.tmp
	sed 's/sequence\=\"server[1-9][1-9]\"//'	/root/dmb/download/worktime.xml   > /root/dmb/download/worktime.xml.tmp
	
	file_md5_compare  /root/dmb/download/dialtime.xml.tmp     	test_usb/download_test/dialtime.xml 
	file_md5_compare  /root/dmb/download/downloadtime.xml.tmp   test_usb/download_test/downloadtime.xml
	file_md5_compare  /root/dmb/download/volume.xml.tmp    			test_usb/download_test/volume.xml
	file_md5_compare  /root/dmb/download/worktime.xml.tmp    		test_usb/download_test/worktime.xml

#	#��ԭ����
	rm -rf /tmp/config/system/*
	cp /tmp/system.bak/* /tmp/config/system/
	rm -rf /tmp/system.bak
	
	rm	/root/dmb/download/*     

	mount /dev/sda1 /mnt
	rm -rf /mnt/*
	umount /mnt

}