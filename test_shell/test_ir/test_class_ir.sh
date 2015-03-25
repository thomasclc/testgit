##
#  \file       test_class_ir.sh
#  \brief      ң��������Խű�����ҪΪf3�˵�����
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
	MONTH=`date -I | awk -F- '{print $2}'`
	DAY=`date -R | awk  '{print $2}'`
	HOUR=`date  | awk  '{print $4}' | awk -F: '{print $1}'`
	MINUTE=`date  | awk  '{print $4}' | awk -F: '{print $2}'`
	YEAR=`date | awk '{print $6}'`
	
	killall -9 dmb_main
	rm $DMB_LOG_PATH/*
	rm /root/dmb/playlist/*
	
#����ΪĬ������
	rm -rf  /tmp/system.bak
	cp -rf  /tmp/config/system  /tmp/system.bak
	cp defaule_config/* /tmp/config/system/
	chmod 777 /tmp/config/system/*	
	rm $TEST_KEY_PATH
	sync
	
#�������Գ���	
	debug "start dmb_main"
	cd $DMB_PATH
	./dmb_load_drv
	./dmb_main -q -k $TEST_KEY_PATH &
	cd -
	debug "wait 10s for start the funtion ..."
	sleep 10
	send_key_and_wait "esc"
}

after_class()
{
	debug "reload date `date $MONTH$DAY$HOUR$MINUTE$YEAR`"
	killall -9 dmb_main
	test_log_path="`cat $TEST_LOG_PATH/test.info | awk -F= '$1~/logs_path/  {print $2}'`"
	cat  $DMB_LOG_PATH/$LOG_NAME.* > $test_log_path".log"
	
	
	rm -rf /tmp/config/system/*
	cp /tmp/system.bak/* /tmp/config/system/
	rm -rf /tmp/system.bak
}
before_case()
{
	echo -before_case
}

after_case()
{
	send_key_and_wait "esc:esc:wait3"
}
##
#	\���ܱ�� 	DMB1820-TS-IR-001-F7
# \����˵��	�ն�����״̬��ѯ
#	\��������	ͨ��ң�����˵���ѯ�ն�����״̬
#	\��֤��		����״̬���ڲ˵�����ȷ��ʾ
##
_test_case_ir_config_net_state()
{

	if [ "$TEST_PRODUCT" = "1820" ]; then
		send_key_and_wait "f3:2:ok"
		send_key_and_wait "down:down:down:down:down:down:down:down:down:down:down:down:down:down"
	elif [ "$TEST_PRODUCT" = "2810" ] ; then 
		debug 2810
	fi
	
}
##
#	\���ܱ�� 	DMB1820-TS-IR-001-F26
# \����˵��	�ն˴����ѯ
#	\��������	ͨ��ң�����˵���ѯ�ն˴���
#	\��֤��		�ն˴������ڲ˵�����ȷ��ʾ
##
_test_case_ir_error()
{

	if [ "$TEST_PRODUCT" = "1820" ]; then
		send_key_and_wait "f1"
		send_key_and_wait "ok:down:down:down:down:down:down:esc"
	elif [ "$TEST_PRODUCT" = "2810" ] ; then 
		send_key_and_wait "f1:right"
		send_key_and_wait "down:right:down:down:down"
	fi
}
##
#	\���ܱ�� 	DMB1820-TS-IR-001-F18
# \����˵��	�ն�ά����Ϣ��ѯ
#	\��������	ͨ��ң�����˵���ѯ�ն�ά����Ϣ
#	\��֤��		�ն���Ϣ���ڲ˵�����ȷ��ʾ
##
_test_case_ir_info()
{

	if [ "$TEST_PRODUCT" = "1820" ]; then
		send_key_and_wait "f3:6:ok"
		send_key_and_wait "0:ok"
		send_key_and_wait "esc:esc"
		send_key_and_wait "f3:6:ok"
		send_key_and_wait "1:ok"	
		send_key_and_wait "esc:esc"
		send_key_and_wait "f3:6:ok"
		send_key_and_wait "2:ok"	
		send_key_and_wait "esc:esc"
		send_key_and_wait "f3:6:ok"
		send_key_and_wait "3:ok"	
		send_key_and_wait "down:down:down"	
		send_key_and_wait "esc"
		send_key_and_wait "4:ok"	
		send_key_and_wait "down:down:down:down:down:down:down:down:down:down:down:down:down:down"	
		send_key_and_wait "esc"
		send_key_and_wait "5:ok"		
		send_key_and_wait "down:down:down:down:down:down"
		send_key_and_wait "esc"
		send_key_and_wait "6:ok"		
		send_key_and_wait "down:down"
	elif [ "$TEST_PRODUCT" = "2810" ] ; then 
		send_key_and_wait "f3:right"
		send_key_and_wait "right:down:down:down:left:down"
		send_key_and_wait "right:down:down:down:down:left:down"
		send_key_and_wait "right:down:down:down:down:down:down:down:left:down"
		send_key_and_wait "right:down:down:down:down:down:down:down:left:down"
		send_key_and_wait "right:down:down:down:left:down"
		send_key_and_wait "right:down:down:down:left:down"
		send_key_and_wait "right:down:down:down:left:down"
		send_key_and_wait "right:down:down:down:left:down"
		send_key_and_wait "right:down:down:down:down:down:down:down:down:down:down:down:down:down:down:left:down"
		send_key_and_wait "right:down:down:down:down:down:down:down:left:down"
		send_key_and_wait "right:down:down:down"
	fi
}
##
#	\���ܱ�� 	DMB1820-TS-IR-001-F8
# \����˵��	�ն˰汾��Ϣ��ѯ
#	\��������	ͨ��ң�����˵���ѯ�ն˰汾��Ϣ
#	\��֤��		�ն˰汾��Ϣ���ڲ˵�����ȷ��ʾ���Ͱ汾�ļ�����ͬ
##
_test_case_ir_config_version()
{

	
	
	if [ "$TEST_PRODUCT" = "1820" ]; then
		send_key_and_wait "f3:3:ok"
		send_key_and_wait "down:down:down:down:down:down"
	elif [ "$TEST_PRODUCT" = "2810" ] ; then 
		send_key_and_wait "f3:right:down:down:down:right:down:down:down:down:down:down"
	fi
}


##
#	\���ܱ�� 	��
# \����˵��	�ն˲�ѯ��ά��
#	\��������	ͨ��ң�����˵��鿴�ն˶�ά��
#	\��֤��		
##
_test_case_ir_qrencode()
{
	if [ "$TEST_PRODUCT" = "1820" ]; then
		send_key_and_wait "f3:6:ok:7:ok:wait3"
	elif [ "$TEST_PRODUCT" = "2810" ] ; then 
		send_key_and_wait "f3:right:down:down:down:down:down:down:down:down:down:down:down:wait3"
	fi
}


##
#	\���ܱ�� 	DMB1820-TS-IR-001-F1
# \����˵��	�ն���̫������
#	\��������	ͨ��ң�����˵������ն���̫��
#	\��֤��		dmb_eth0.ini�ļ������ܹ���ȷ�޸�
##
_test_case_ir_config_net()
{

	if [ "$TEST_PRODUCT" = "1820" ]; then
	
		send_key_and_wait "f3:0:ok:0:ok"
		send_key_and_wait "right:down"
		#����ip 192.168.1.2 �������� 255.255.255.0  ���� 192.168.1.1
		send_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:del:1:9:2:ar:1:6:8:ar:1:ar:2:down"
		send_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:del:del:2:5:5:ar:2:5:5:ar:2:5:5:ar:0:down"
		send_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:del:1:9:2:ar:1:6:8:ar:1:ar:1"
		send_key_and_wait "ok:wait3"
		
		check_config_value $CONFIG_PATH/dmb_eth0.ini "static_ip" 	"192.168.1.2"   
		check_config_value $CONFIG_PATH/dmb_eth0.ini "static_netmask" 	"255.255.255.0"   
		check_config_value $CONFIG_PATH/dmb_eth0.ini "static_gateway" 		"192.168.1.1"  
		check_config_value $CONFIG_PATH/dmb_eth0.ini "dhcp" 	"0" 	
		
		#����ip 0.0.0.0 �������� 0.0.0.0  ���� 0.0.0.0
		send_key_and_wait "ok:down:del:del:del:del:del:del:del:del:del:del:del:0:ar:0:ar:0:ar:0:down"
		send_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:del:del:0:ar:0:ar:0:ar:0:down"
		send_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:0:ar:0:ar:0:ar:0"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_eth0.ini "static_ip" 	"0.0.0.0"   
		check_config_value $CONFIG_PATH/dmb_eth0.ini "static_netmask" 	"0.0.0.0"   
		check_config_value $CONFIG_PATH/dmb_eth0.ini "static_gateway" 		"0.0.0.0"  		
		
		#����ip 255.255.255.255 �������� 255.255.255.255  ���� 255.255.255.255
		send_key_and_wait "ok:down:del:del:del:del:del:del:del:2:5:5:ar:2:5:5:ar:2:5:5:ar:2:5:5:down"
		send_key_and_wait "del:del:del:del:del:del:del:2:5:5:ar:2:5:5:ar:2:5:5:ar:2:5:5:down"
		send_key_and_wait "del:del:del:del:del:del:del:2:5:5:ar:2:5:5:ar:2:5:5:ar:2:5:5"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_eth0.ini "static_ip" 	"255.255.255.255"   
		check_config_value $CONFIG_PATH/dmb_eth0.ini "static_netmask" 	"255.255.255.255"  
		check_config_value $CONFIG_PATH/dmb_eth0.ini "static_gateway" 	"255.255.255.255"  		
		
		#����ip 256.256.256.256 �������� 256.256.256.256  ���� 256.256.256.256
		send_key_and_wait "ok:down:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:2:5:6:ar:2:5:6:ar:2:5:6:ar:2:5:6:down"
		send_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:2:5:6:ar:2:5:6:ar:2:5:6:ar:2:5:6:down"
		send_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:2:5:6:ar:2:5:6:ar:2:5:6:ar:2:5:6"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_eth0.ini "static_ip" 	"25.25.25.25"   
		check_config_value $CONFIG_PATH/dmb_eth0.ini "static_netmask" 	"25.25.25.25" 
		check_config_value $CONFIG_PATH/dmb_eth0.ini "static_gateway" 	"25.25.25.25" 
		
	elif [ "$TEST_PRODUCT" = "2810" ] ; then 
		send_key_and_wait "f3:down:right:right"
		send_key_and_wait "right:down"
		#����ip 192.168.1.2 �������� 255.255.255.0  ���� 192.168.1.1
		send_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:del:1:9:2:ar:1:6:8:ar:1:ar:2:down"
		send_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:del:del:2:5:5:ar:2:5:5:ar:2:5:5:ar:0:down"
		send_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:del:1:9:2:ar:1:6:8:ar:1:ar:1"
		send_key_and_wait "ok:wait3"
		
		check_config_value $CONFIG_PATH/dmb_eth0.ini "static_ip" 	"192.168.1.2"   
		check_config_value $CONFIG_PATH/dmb_eth0.ini "static_netmask" 	"255.255.255.0"   
		check_config_value $CONFIG_PATH/dmb_eth0.ini "static_gateway" 		"192.168.1.1"  
		check_config_value $CONFIG_PATH/dmb_eth0.ini "dhcp" 	"0" 			
		
		#����ip 0.0.0.0 �������� 0.0.0.0  ���� 0.0.0.0
		send_key_and_wait "left:right:down:del:del:del:del:del:del:del:del:del:del:del:0:ar:0:ar:0:ar:0:down"
		send_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:del:del:0:ar:0:ar:0:ar:0:down"
		send_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:0:ar:0:ar:0:ar:0"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_eth0.ini "static_ip" 	"0.0.0.0"   
		check_config_value $CONFIG_PATH/dmb_eth0.ini "static_netmask" 	"0.0.0.0"   
		check_config_value $CONFIG_PATH/dmb_eth0.ini "static_gateway" 		"0.0.0.0"  
		
		#����ip 255.255.255.255 �������� 255.255.255.255  ���� 255.255.255.255
		send_key_and_wait "left:right:down:del:del:del:del:del:del:del:2:5:5:ar:2:5:5:ar:2:5:5:ar:2:5:5:down"
		send_key_and_wait "del:del:del:del:del:del:del:2:5:5:ar:2:5:5:ar:2:5:5:ar:2:5:5:down"
		send_key_and_wait "del:del:del:del:del:del:del:2:5:5:ar:2:5:5:ar:2:5:5:ar:2:5:5"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_eth0.ini "static_ip" 	"255.255.255.255"   
		check_config_value $CONFIG_PATH/dmb_eth0.ini "static_netmask" 	"255.255.255.255"  
		check_config_value $CONFIG_PATH/dmb_eth0.ini "static_gateway" 	"255.255.255.255"  			
		
		#����ip 256.256.256.256 �������� 256.256.256.256  ���� 256.256.256.256
		send_key_and_wait "left:right:down:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:2:5:6:ar:2:5:6:ar:2:5:6:ar:2:5:6:down"
		send_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:2:5:6:ar:2:5:6:ar:2:5:6:ar:2:5:6:down"
		send_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:2:5:6:ar:2:5:6:ar:2:5:6:ar:2:5:6"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_eth0.ini "static_ip" 	"255.255.255.255"   
		check_config_value $CONFIG_PATH/dmb_eth0.ini "static_netmask" 	"255.255.255.255"  
		check_config_value $CONFIG_PATH/dmb_eth0.ini "static_gateway" 	"255.255.255.255"  			
	fi
}
##
#	\���ܱ�� 	DMB1820-TS-IR-001-F2
# \����˵��	�ն�3G����
#	\��������	ͨ��ң�����˵������ն�3G
#	\��֤��		dmb_3g.ini�ļ������ܹ���ȷ�޸�
##
_test_case_ir_config_3G()
{

	if [ "$TEST_PRODUCT" = "1820" ]; then
		send_key_and_wait "f3:0:ok:1:ok"
		send_key_and_wait "right:down"
		send_key_and_wait "right:down"	
		send_key_and_wait "right:down"
		send_key_and_wait "del:1:down"
		send_key_and_wait "del:2:down"
		send_key_and_wait "del:del:del:del:del:del:1:2:3:4:5:6:down"
		send_key_and_wait "del:del:del:del:0:5:8:8:6:wait3:down"
		send_key_and_wait "del:del:del:del:1:2:3:4:wait3:down"
		send_key_and_wait "1:2:3:4:5:6:7:8:wait3:down"
		send_key_and_wait "8:7:6:5:4:3:2:1:wait3:down"
		send_key_and_wait "6:6:6:2:2:6:6:3:3:3:wait3:down"
		send_key_and_wait "7:7:9:9:3:3:wait3:down"
		send_key_and_wait "1:9:2:ar:1:6:8:ar:1:ar:1:wait3:down"
		send_key_and_wait "del:del:4:4:4:4:7:7:wait3:down"
		send_key_and_wait "right"
		send_key_and_wait "ok:wait3"
		
		check_config_value $CONFIG_PATH/dmb_3g.ini  "start_3g" 	"1"   
		check_config_value $CONFIG_PATH/dmb_3g.ini "3g_system" 	"0"   
		check_config_value $CONFIG_PATH/dmb_3g.ini "3g_type" 		"6"  
		check_config_value $CONFIG_PATH/dmb_3g.ini "port_num" 	"1"   
		check_config_value $CONFIG_PATH/dmb_3g.ini "port_cmd"		"2"  
		check_config_value $CONFIG_PATH/dmb_3g.ini "baud_rate" 	"123456"   
		check_config_value $CONFIG_PATH/dmb_3g.ini "3g_vid" 		"05t6"   
		check_config_value $CONFIG_PATH/dmb_3g.ini "3g_pid"		 	"1234"   
		check_config_value $CONFIG_PATH/dmb_3g.ini "3g_apn" 		"12345678"   
		check_config_value $CONFIG_PATH/dmb_3g.ini "dail_num" 	"87654321"   
		check_config_value $CONFIG_PATH/dmb_3g.ini "user_name"	"name"  
		check_config_value $CONFIG_PATH/dmb_3g.ini "pass_word" 	"pwd"   
		check_config_value $CONFIG_PATH/dmb_3g.ini "pdp_addr" 	"192.168.1.1"  
		check_config_value $CONFIG_PATH/dmb_3g.ini "pdp_type" 	"ip"   
		check_config_value $CONFIG_PATH/dmb_3g.ini "net_mode" 	"1"   
		
		
		send_key_and_wait "ok:down:down:down"
		send_key_and_wait "del:9:9:9:down"
		send_key_and_wait "del:9:9:9:down"
		send_key_and_wait "del:del:del:del:del:del:9:9:9:9:9:9:9:down"
		send_key_and_wait "del:del:del:del:1:2:2:wait2:2:wait2:2:2:2:3:wait2:down"
		send_key_and_wait "del:del:del:del:1:2:2:wait2:2:wait2:2:2:2:3:wait2:down"
		
		send_key_and_wait "del:del:del:del:del:del:del:del"
		send_key_and_wait "1:2:2:wait2:2:wait2:2:2:2:2:2:2:3:ar:ar:ar:ar:ar:ar:ar:4:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:5"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:6:ar:ar:ar:7"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:8:ar:ar:wait2:9"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:wait2"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:wait2:down"

		send_key_and_wait "del:del:del:del:del:del:del:del"
		send_key_and_wait "1:2:2:wait3:2:wait2:2:2:2:2:2:2:3:ar:ar:ar:ar:ar:ar:ar:4:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:5"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:6:ar:ar:ar:7"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:8:ar:ar:wait2:9"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:wait2"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:wait2:down"
		
		send_key_and_wait "del:del:del:del"
		send_key_and_wait "1:2:2:wait3:2:wait2:2:2:2:2:2:2:3:ar:ar:ar:ar:ar:ar:ar:4:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:5"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:6:ar:ar:ar:7"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:arwait2:8:ar:ar:wait2:9"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:wait2:0:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:wait2"
		send_key_and_wait "3:3:3:3:3:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:3:3:3:3:ar:4:4:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:5:5:5"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:wait2"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:wait2"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:wait2"
		send_key_and_wait "9:9:9:9:9:wait2:down"
		
		send_key_and_wait "del:del:del"
		send_key_and_wait "1:2:2:wait2:2:wait2:2:2:2:2:2:2:3:ar:ar:ar:ar:ar:ar:ar:4:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:wait2:5"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:6:ar:ar:ar:7"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:arwait2:8:ar:ar:wait2:9"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:wait2:0:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:wait2"
		send_key_and_wait "3:3:3:3:3:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:3:3:3:3:ar:4:4:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:5:5:5"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:wait2"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:wait2"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:wait2"
		send_key_and_wait "9:9:9:9:9:wait2:down"
			
		send_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:del:del:1:2:2:wait2:2:wait2:2:2:2:2:2:2:3:ar:ar:ar:ar:ar:ar:ar:4:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:5:wait3:down"
		send_key_and_wait "del:del:1:2:2:wait2:2:wait2:2:2:2:2:2:2:3:ar:ar:ar:ar:ar:ar:ar:4:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:5:wait3:down"
		send_key_and_wait "ok:wait3"
 
		check_config_value $CONFIG_PATH/dmb_3g.ini "port_num" 	"99"   
		check_config_value $CONFIG_PATH/dmb_3g.ini "port_cmd"		"99"  
		check_config_value $CONFIG_PATH/dmb_3g.ini "baud_rate" 	"999999"   
		check_config_value $CONFIG_PATH/dmb_3g.ini "3g_vid" 		'1a2b'   
		check_config_value $CONFIG_PATH/dmb_3g.ini "3g_pid"		 	'1a2b'   
		check_config_value $CONFIG_PATH/dmb_3g.ini "3g_apn" 		'1a2B3!4%5��6#7]8*9@'    
		check_config_value $CONFIG_PATH/dmb_3g.ini "dail_num" 	'1a2B3!4%5��6#7]8*9@'   
		check_config_value $CONFIG_PATH/dmb_3g.ini "user_name"	'1a2B!3@4#5$6%7^8*9(0)D-f.g+h<k>?/'    
		check_config_value $CONFIG_PATH/dmb_3g.ini "pass_word" 	'1a2B!3@4#5$6%7^8*9(0)D-f.g+h<k>?/'   
		check_config_value $CONFIG_PATH/dmb_3g.ini "pdp_addr" 	'1a2B3!4%5��6#7]8*9@'
		check_config_value $CONFIG_PATH/dmb_3g.ini "pdp_type" 	'1a2B3!4%5��6#7]8*9@'   
		
	elif [ "$TEST_PRODUCT" = "2810" ] ; then 
		
		send_key_and_wait "f3:down:right:down:down:right"
		send_key_and_wait "right:down"
		send_key_and_wait "right:down:ok:down"
		send_key_and_wait "right:down:ok:down"
		send_key_and_wait "del:1:down"
		send_key_and_wait "del:2:down"
		send_key_and_wait "del:del:del:del:del:del:1:2:3:4:5:6:down"
		send_key_and_wait "del:del:del:del:0:5:8:8:6:wait3:down"
		send_key_and_wait "del:del:del:del:1:2:3:4:wait3:down"
		send_key_and_wait "1:2:3:4:5:6:7:8:wait3:down"
		send_key_and_wait "8:7:6:5:4:3:2:1:wait3:down"
		send_key_and_wait "6:6:6:2:2:6:6:3:3:3:wait3:down"
		send_key_and_wait "7:7:9:9:3:3:wait3:down"
		send_key_and_wait "1:9:2:ar:1:6:8:ar:1:ar:1:wait3:down"
		send_key_and_wait "del:del:4:4:4:4:7:7:wait3:down"
		send_key_and_wait "right:down:ok"
		send_key_and_wait "ok:wait3"
		
		check_config_value $CONFIG_PATH/dmb_3g.ini  "start_3g" 	"1"   
		check_config_value $CONFIG_PATH/dmb_3g.ini "3g_system" 	"2"   
		check_config_value $CONFIG_PATH/dmb_3g.ini "3g_type" 		"6"  
		check_config_value $CONFIG_PATH/dmb_3g.ini "port_num" 	"1"   
		check_config_value $CONFIG_PATH/dmb_3g.ini "port_cmd"		"2"  
		check_config_value $CONFIG_PATH/dmb_3g.ini "baud_rate" 	"123456"   
		check_config_value $CONFIG_PATH/dmb_3g.ini "3g_vid" 		"05t6"   
		check_config_value $CONFIG_PATH/dmb_3g.ini "3g_pid"		 	"1234"   
		check_config_value $CONFIG_PATH/dmb_3g.ini "3g_apn" 		"12345678"   
		check_config_value $CONFIG_PATH/dmb_3g.ini "dail_num" 	"87654321"   
		check_config_value $CONFIG_PATH/dmb_3g.ini "user_name"	"name"  
		check_config_value $CONFIG_PATH/dmb_3g.ini "pass_word" 	"pwd"   
		check_config_value $CONFIG_PATH/dmb_3g.ini "pdp_addr" 	"192.168.1.1"  
		check_config_value $CONFIG_PATH/dmb_3g.ini "pdp_type" 	"ip"   
		check_config_value $CONFIG_PATH/dmb_3g.ini "net_mode" 	"1"   		
			
		send_key_and_wait "left:right:down:down:down"
		send_key_and_wait "del:9:9:9:down"
		send_key_and_wait "del:9:9:9:down"
		send_key_and_wait "del:del:del:del:del:del:9:9:9:9:9:9:9:down"
		send_key_and_wait "del:del:del:del:1:2:2:wait2:2:wait2:2:2:2:3:wait2:down"
		send_key_and_wait "del:del:del:del:1:2:2:wait2:2:wait2:2:2:2:3:wait2:down"
		
		send_key_and_wait "del:del:del:del:del:del:del:del"
		send_key_and_wait "1:2:2:wait2:2:wait2:2:2:2:2:2:2:3:ar:ar:ar:ar:ar:ar:ar:4:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:5"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:6:ar:ar:ar:7"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:8:ar:ar:wait2:9"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:wait2"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:wait2:down"

		send_key_and_wait "del:del:del:del:del:del:del:del"
		send_key_and_wait "1:2:2:wait2:2:wait2:2:2:2:2:2:2:3:ar:ar:ar:ar:ar:ar:ar:4:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:5"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:6:ar:ar:ar:7"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:8:ar:ar:wait2:9"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:wait2"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:wait2:down"
		
		send_key_and_wait "del:del:del:del"
		send_key_and_wait "1:2:2:wait2:2:wait2:2:2:2:2:2:2:3:ar:ar:ar:ar:ar:ar:ar:4:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:wait2:5"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:6:ar:ar:ar:7"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:arwait2:8:ar:ar:wait2:9"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:wait2:0:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:wait2"
		send_key_and_wait "3:3:3:3:3:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:3:3:3:3:ar:4:4:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:5:5:5"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:wait2"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:wait2"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:wait2"
		send_key_and_wait "9:9:9:9:9:wait2:down"
		
		send_key_and_wait "del:del:del"
		send_key_and_wait "1:2:2:wait2:2:wait2:2:2:2:2:2:2:3:ar:ar:ar:ar:ar:ar:ar:4:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:wait2:5"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:6:ar:ar:ar:7"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:arwait2:8:ar:ar:wait2:9"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:wait2:0:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:wait2"
		send_key_and_wait "3:3:3:3:3:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:3:3:3:3:ar:4:4:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:5:5:5"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:wait2"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:wait2"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:wait2"
		send_key_and_wait "9:9:9:9:9:wait2:down"
			
		send_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:del:del:1:2:2:wait2:2:wait2:2:2:2:2:2:2:3:ar:ar:ar:ar:ar:ar:ar:4:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:5:wait3:down"
		send_key_and_wait "del:del:1:2:2:wait2:2:wait2:2:2:2:2:2:2:3:ar:ar:ar:ar:ar:ar:ar:4:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:5:wait3:down"
		send_key_and_wait "ok:wait3"
 
		check_config_value $CONFIG_PATH/dmb_3g.ini "port_num" 	"99"   
		check_config_value $CONFIG_PATH/dmb_3g.ini "port_cmd"		"99"  
		check_config_value $CONFIG_PATH/dmb_3g.ini "baud_rate" 	"999999"   
		check_config_value $CONFIG_PATH/dmb_3g.ini "3g_vid" 		'1a2b'   
		check_config_value $CONFIG_PATH/dmb_3g.ini "3g_pid"		 	'1a2b'   
		check_config_value $CONFIG_PATH/dmb_3g.ini "3g_apn" 		'1a2B3!4%5��6#7]8*9@'    
		check_config_value $CONFIG_PATH/dmb_3g.ini "dail_num" 	'1a2B3!4%5��6#7]8*9@'   
		check_config_value $CONFIG_PATH/dmb_3g.ini "user_name"	'1a2B!3@4#5$6%7^8*9(0)D-f.g+h<k>?/'    
		check_config_value $CONFIG_PATH/dmb_3g.ini "pass_word" 	'1a2B!3@4#5$6%7^8*9(0)D-f.g+h<k>?/'   
		check_config_value $CONFIG_PATH/dmb_3g.ini "pdp_addr" 	'1a2B3!4%5��6#7]8*9@'
		check_config_value $CONFIG_PATH/dmb_3g.ini "pdp_type" 	'1a2B3!4%5��6#7]8*9@'   	
	fi 	
		
}
##
#	\���ܱ�� 	DMB1820-TS-IR-001-F3
# \����˵��	�ն�wifi����
#	\��������	ͨ��ң�����˵������ն�wifi
#	\��֤��		dmb_wifi.ini�ļ������ܹ���ȷ�޸�
##
_test_case_ir_config_wifi()
{
	
	if [ "$TEST_PRODUCT" = "1820" ]; then
		send_key_and_wait "f3:0:ok:2:ok"
		send_key_and_wait "right:down"
		send_key_and_wait "down"	
		send_key_and_wait "1:9:2:ar:1:6:8:ar:1:ar:2:down"
		send_key_and_wait "2:5:5:ar:2:5:5:ar:2:5:5:ar:0:down"
		send_key_and_wait "1:9:2:ar:1:6:8:ar:1:ar:1:down"
		send_key_and_wait "8:8:3:3:3:7:7:7:7:7:8:8:wait3:down"
		send_key_and_wait "7:7:9:9:3:3:wait3:down"
		send_key_and_wait "right"
		send_key_and_wait "ok:wait3"
		
		check_config_value $CONFIG_PATH/dmb_wifi.ini "start_wifi"		"1"     
		check_config_value $CONFIG_PATH/dmb_wifi.ini "wifi_essid"		"test"   
		check_config_value $CONFIG_PATH/dmb_wifi.ini "wifi_encro_type"		"2"   
		check_config_value $CONFIG_PATH/dmb_wifi.ini "wifi_key"		"pwd"   
		check_config_value $CONFIG_PATH/dmb_wifi.ini "dhcp"		"0"   
		check_config_value $CONFIG_PATH/dmb_wifi.ini "static_ip"		"192.168.1.2"   
		check_config_value $CONFIG_PATH/dmb_wifi.ini "static_netmask"		"255.255.255.0"   
		check_config_value $CONFIG_PATH/dmb_wifi.ini "static_gateway"		"192.168.1.1"   

		send_key_and_wait "ok:down:down:del:del:del:del:del:del:del:del:del:del:del:0:ar:0:ar:0:ar:0:down"
		send_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:del:del:0:ar:0:ar:0:ar:0:down"
		send_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:0:ar:0:ar:0:ar:0"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_wifi.ini "static_ip" 	"0.0.0.0"   
		check_config_value $CONFIG_PATH/dmb_wifi.ini "static_netmask" 	"0.0.0.0"   
		check_config_value $CONFIG_PATH/dmb_wifi.ini "static_gateway" 		"0.0.0.0"  
		
		
		send_key_and_wait "ok:down:down:del:del:del:del:del:del:del:2:5:5:ar:2:5:5:ar:2:5:5:ar:2:5:5:down"
		send_key_and_wait "del:del:del:del:del:del:del:2:5:5:ar:2:5:5:ar:2:5:5:ar:2:5:5:down"
		send_key_and_wait "del:del:del:del:del:del:del:2:5:5:ar:2:5:5:ar:2:5:5:ar:2:5:5"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_wifi.ini "static_ip" 	"255.255.255.255"   
		check_config_value $CONFIG_PATH/dmb_wifi.ini "static_netmask" 	"255.255.255.255"  
		check_config_value $CONFIG_PATH/dmb_wifi.ini "static_gateway" 	"255.255.255.255"  		
		
		send_key_and_wait "ok:down:down:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:2:5:6:ar:2:5:6:ar:2:5:6:ar:2:5:6:down"
		send_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:2:5:6:ar:2:5:6:ar:2:5:6:ar:2:5:6:down"
		send_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:2:5:6:ar:2:5:6:ar:2:5:6:ar:2:5:6"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_wifi.ini "static_ip" 	"25.25.25.25"   
		check_config_value $CONFIG_PATH/dmb_wifi.ini "static_netmask" 	"25.25.25.25" 
		check_config_value $CONFIG_PATH/dmb_wifi.ini "static_gateway" 	"25.25.25.25" 
		
	elif [ "$TEST_PRODUCT" = "2810" ] ; then 
		send_key_and_wait "f3:down:right:down:down:down:right"
		send_key_and_wait "right:down"
		send_key_and_wait "down"	
		send_key_and_wait "1:9:2:ar:1:6:8:ar:1:ar:2:down"
		send_key_and_wait "2:5:5:ar:2:5:5:ar:2:5:5:ar:0:down"
		send_key_and_wait "1:9:2:ar:1:6:8:ar:1:ar:1:down"
		send_key_and_wait "del:del:del:del:8:8:3:3:3:7:7:7:7:7:8:8:wait3:down"
		send_key_and_wait "7:7:9:9:3:3:wait3:down"
		send_key_and_wait "right:down:ok"
		send_key_and_wait "ok:wait3"
		
		check_config_value $CONFIG_PATH/dmb_wifi.ini "start_wifi"		"1"     
		check_config_value $CONFIG_PATH/dmb_wifi.ini "wifi_essid"		"test"   
		check_config_value $CONFIG_PATH/dmb_wifi.ini "wifi_encro_type"		"2"   
		check_config_value $CONFIG_PATH/dmb_wifi.ini "wifi_key"		"pwd"   
		check_config_value $CONFIG_PATH/dmb_wifi.ini "dhcp"		"0"   
		check_config_value $CONFIG_PATH/dmb_wifi.ini "static_ip"		"192.168.1.2"   
		check_config_value $CONFIG_PATH/dmb_wifi.ini "static_netmask"		"255.255.255.0"   
		check_config_value $CONFIG_PATH/dmb_wifi.ini "static_gateway"		"192.168.1.1"   
		
		send_key_and_wait "left:right:down:down"
		send_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:0:ar:0:ar:0:ar:0:down"
		send_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:del:del:0:ar:0:ar:0:ar:0:down"
		send_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:0:ar:0:ar:0:ar:0"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_wifi.ini "static_ip" 	"0.0.0.0"   
		check_config_value $CONFIG_PATH/dmb_wifi.ini "static_netmask" 	"0.0.0.0"   
		check_config_value $CONFIG_PATH/dmb_wifi.ini "static_gateway" 		"0.0.0.0"  
		
		
		send_key_and_wait "left:right:down:down:del:del:del:del:del:del:del:2:5:5:ar:2:5:5:ar:2:5:5:ar:2:5:5:down"
		send_key_and_wait "del:del:del:del:del:del:del:2:5:5:ar:2:5:5:ar:2:5:5:ar:2:5:5:down"
		send_key_and_wait "del:del:del:del:del:del:del:2:5:5:ar:2:5:5:ar:2:5:5:ar:2:5:5"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_wifi.ini "static_ip" 	"255.255.255.255"   
		check_config_value $CONFIG_PATH/dmb_wifi.ini "static_netmask" 	"255.255.255.255"  
		check_config_value $CONFIG_PATH/dmb_wifi.ini "static_gateway" 	"255.255.255.255"  		
		
		send_key_and_wait "left:right:down:down:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:2:5:6:ar:2:5:6:ar:2:5:6:ar:2:5:6:down"
		send_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:2:5:6:ar:2:5:6:ar:2:5:6:ar:2:5:6:down"
		send_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:2:5:6:ar:2:5:6:ar:2:5:6:ar:2:5:6"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_wifi.ini "static_ip" 	"255.255.255.255"   
		check_config_value $CONFIG_PATH/dmb_wifi.ini "static_netmask" 	"255.255.255.255"  
		check_config_value $CONFIG_PATH/dmb_wifi.ini "static_gateway" 	"255.255.255.255"  	
	fi
}
##
#	\���ܱ�� 	DMB1820-TS-IR-001-F4
# \����˵��	�ն˴�������
#	\��������	ͨ��ң�����˵������ն˴���
#	\��֤��		dmb_proxy.ini�ļ������ܹ���ȷ�޸�
##
_test_case_ir_config_proxy()
{

	if [ "$TEST_PRODUCT" = "1820" ]; then
		send_key_and_wait "f3:0:ok:3:ok"
		send_key_and_wait "right:down"
		send_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:1:9:2:ar:1:6:8:ar:1:ar:2:down"
		send_key_and_wait "del:del:del:del:1:2:3:4:down"
		send_key_and_wait "right:down"
		send_key_and_wait "del:del:del:del:6:6:6:2:2:6:6:3:3:3:wait3:down"
		send_key_and_wait "del:del:del:7:7:9:9:3:3:wait3:down"
		send_key_and_wait "ok:wait3"	
		check_config_value $CONFIG_PATH/dmb_proxy.ini "proxy_switch"		"1"     
		check_config_value $CONFIG_PATH/dmb_proxy.ini "proxy_server_ip"		"192.168.1.2"   
		check_config_value $CONFIG_PATH/dmb_proxy.ini "proxy_server_port"		"1234"   
		check_config_value $CONFIG_PATH/dmb_proxy.ini "auth"		"1"   
		check_config_value $CONFIG_PATH/dmb_proxy.ini "username"		"name"   
		check_config_value $CONFIG_PATH/dmb_proxy.ini "password"		"pwd"    
		
		send_key_and_wait "ok:down:del:del:del:del:del:del:del:del:del:del:del:0:ar:0:ar:0:ar:0:down"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_proxy.ini "proxy_server_ip"		"0.0.0.0"    
		send_key_and_wait "ok:down:del:del:del:del:del:del:del:2:5:5:ar:2:5:5:ar:2:5:5:ar:2:5:5:down"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_proxy.ini "proxy_server_ip"		"255.255.255.255"   
		send_key_and_wait "ok:down:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:2:5:6:ar:2:5:6:ar:2:5:6:ar:2:5:6:down"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_proxy.ini "proxy_server_ip"		"25.25.25.25"   	
		
		send_key_and_wait "ok:down:down:down:down:del:del:del:del"
		send_key_and_wait "1:2:2:wait2:2:wait2:2:2:2:2:2:2:3:ar:ar:ar:ar:ar:ar:ar:4:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:6:ar:ar:ar:7"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:8:ar:ar:wait2"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:wait2"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_proxy.ini "username"		'1a2B3!4%6#7]8*9@' 
		
		send_key_and_wait "ok:down:down:down:down:down:del:del:del"
		send_key_and_wait "1:2:2:wait2:2:wait2:2:2:2:2:2:2:3:ar:ar:ar:ar:ar:ar:ar:4:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:6:ar:ar:ar:7"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:8:ar:ar:wait2"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:wait2"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_proxy.ini "password"		'1a2B3!4%6#7]8*9@' 
		 
		send_key_and_wait "ok:right:down:down:down:right"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_proxy.ini "proxy_switch"		"0" 
		check_config_value $CONFIG_PATH/dmb_proxy.ini "auth"		"0" 
		
	elif [ "$TEST_PRODUCT" = "2810" ] ; then 
		send_key_and_wait "f3:down:right:down:down:down:down:right"
		send_key_and_wait "right:down:ok:down"
		send_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:1:9:2:ar:1:6:8:ar:1:ar:2:down"
		send_key_and_wait "del:del:del:del:1:2:3:4:down"
		send_key_and_wait "right:down"
		send_key_and_wait "del:del:del:del:6:6:6:2:2:6:6:3:3:3:wait3:down"
		send_key_and_wait "del:del:del:7:7:9:9:3:3:wait3:down"
		send_key_and_wait "ok:wait3"	
		check_config_value $CONFIG_PATH/dmb_proxy.ini "proxy_switch"		"1"     
		check_config_value $CONFIG_PATH/dmb_proxy.ini "proxy_server_ip"		"192.168.1.2"   
		check_config_value $CONFIG_PATH/dmb_proxy.ini "proxy_server_port"		"1234"   
		check_config_value $CONFIG_PATH/dmb_proxy.ini "auth"		"1"   
		check_config_value $CONFIG_PATH/dmb_proxy.ini "username"		"name"   
		check_config_value $CONFIG_PATH/dmb_proxy.ini "password"		"pwd"    
		
		send_key_and_wait "left:right:down:del:del:del:del:del:del:del:del:del:del:del:0:ar:0:ar:0:ar:0:down"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_proxy.ini "proxy_server_ip"		"0.0.0.0"    
		send_key_and_wait "left:right:down:del:del:del:del:del:del:del:2:5:5:ar:2:5:5:ar:2:5:5:ar:2:5:5:down"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_proxy.ini "proxy_server_ip"		"255.255.255.255"   
		send_key_and_wait "left:right:down:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:2:5:6:ar:2:5:6:ar:2:5:6:ar:2:5:6:down"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_proxy.ini "proxy_server_ip"		"255.255.255.255"    	
		
		send_key_and_wait "left:right:down:down:down:down:del:del:del:del"
		send_key_and_wait "1:2:2:wait2:2:wait2:2:2:2:2:2:2:3:ar:ar:ar:ar:ar:ar:ar:4:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:6:ar:ar:ar:7"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:8:ar:ar:wait2"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:wait2"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_proxy.ini "username"		'1a2B3!4%6#7]8*9@' 
		
		send_key_and_wait "left:right:down:down:down:down:down:del:del:del"
		send_key_and_wait "1:2:2:wait2:2:wait2:2:2:2:2:2:2:3:ar:ar:ar:ar:ar:ar:ar:4:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:6:ar:ar:ar:7"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:8:ar:ar:wait2"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:wait2"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_proxy.ini "password"		'1a2B3!4%6#7]8*9@' 
		 
		send_key_and_wait "left:right:right:down:down:down:right"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_proxy.ini "proxy_switch"		"0" 
		check_config_value $CONFIG_PATH/dmb_proxy.ini "auth"		"0" 
	fi 			
}
##
#	\���ܱ�� 	DMB1820-TS-IR-001-F5
# \����˵��	�ն�DNS����
#	\��������	ͨ��ң�����˵������ն�DNS
#	\��֤��		resolv.conf�ļ������ܹ���ȷ�޸�
##
_test_case_ir_config_dns()
{

	if [ "$TEST_PRODUCT" = "1820" ]; then
		send_key_and_wait "f3:0:ok:4:ok"
		send_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:1:9:2:ar:1:6:8:ar:1:ar:2:down"
		send_key_and_wait "ok:wait3"
		check_text  $CONFIG_PATH/resolv.conf   "nameserver 192.168.1.2"  
		send_key_and_wait "ok:del:del:del:del:del:del:del:del:del:del:del:0:ar:0:ar:0:ar:0:down"
		send_key_and_wait "ok:wait3"
		check_text  $CONFIG_PATH/resolv.conf   "nameserver 0.0.0.0"  
		send_key_and_wait "ok:del:del:del:del:del:del:del:2:5:5:ar:2:5:5:ar:2:5:5:ar:2:5:5:down"
		send_key_and_wait "ok:wait3"
		check_text  $CONFIG_PATH/resolv.conf   "nameserver 255.255.255.255"  
		send_key_and_wait "ok:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:2:5:6:ar:2:5:6:ar:2:5:6:ar:2:5:6:down"
		send_key_and_wait "ok:wait3"
		check_text  $CONFIG_PATH/resolv.conf   "nameserver 25.25.25.25"  	
		
	elif [ "$TEST_PRODUCT" = "2810" ] ; then 
		send_key_and_wait "f3:down:right:down:down:down:down:down:right"
		send_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:1:9:2:ar:1:6:8:ar:1:ar:2:down"
		send_key_and_wait "ok:wait3"
		check_text  $CONFIG_PATH/resolv.conf   "nameserver 192.168.1.2"  
		send_key_and_wait "left:right:del:del:del:del:del:del:del:del:del:del:del:0:ar:0:ar:0:ar:0:down"
		send_key_and_wait "ok:wait3"
		check_text  $CONFIG_PATH/resolv.conf   "nameserver 0.0.0.0"  
		send_key_and_wait "left:right:del:del:del:del:del:del:del:2:5:5:ar:2:5:5:ar:2:5:5:ar:2:5:5:down"
		send_key_and_wait "ok:wait3"
		check_text  $CONFIG_PATH/resolv.conf   "nameserver 255.255.255.255"  
		send_key_and_wait "left:right:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:2:5:6:ar:2:5:6:ar:2:5:6:ar:2:5:6:down"
		send_key_and_wait "ok:wait3"
		check_text  $CONFIG_PATH/resolv.conf   "nameserver 255.255.255.255"  
	fi	
}
##
#	\���ܱ�� 	�����ޣ�
# \����˵��	�ն�SSL����
#	\��������	ͨ��ң�����˵������ն�SSL����
#	\��֤��		dmb_ssl.ini�ļ������ܹ���ȷ�޸�
##
_test_case_ir_config_ssl()
{
	if [ "$TEST_PRODUCT" = "1820" ]; then
		check_config_value $CONFIG_PATH/dmb_ssl.ini "ssl_switch"		"0"	
		send_key_and_wait "f3:0:ok:5:ok"
		send_key_and_wait "right:down"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_ssl.ini "ssl_switch"		"1"	
		send_key_and_wait "ok:right:down:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_ssl.ini "ssl_switch"		"0"	
	elif [ "$TEST_PRODUCT" = "2810" ] ; then 
		check_config_value $CONFIG_PATH/dmb_ssl.ini "ssl_switch"		"0"	
		send_key_and_wait "f3:down:right"
		send_key_and_wait "down:down:down:down:down:down:down:down:down:down:down:down:down:down:down:down:down:down:right"
		send_key_and_wait "right:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_ssl.ini "ssl_switch"		"1"	
		send_key_and_wait "right:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_ssl.ini "ssl_switch"		"0"	
	fi
}
##
#	\���ܱ�� 	DMB1820-TS-IR-001-F6
# \����˵��	�ն�ƽ̨����
#	\��������	ͨ��ң�����˵������ն�ƽ̨
#	\��֤��		dmb_server.ini�ļ������ܹ���ȷ�޸�
##
_test_case_ir_config_server()
{

	if [ "$TEST_PRODUCT" = "1820" ]; then
		send_key_and_wait "f3:1:ok"
		send_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:del:del:1:9:2:ar:1:6:8:ar:1:ar:2:wait3:down"
		send_key_and_wait "del:del:del:del:del:1:2:3:4:5:down"
		send_key_and_wait "del:del:del:del:del:5:4:3:2:1:down"
		send_key_and_wait "1:2:3:4:5:6:7:8:wait3"
		send_key_and_wait "ok:wait3"
		
		check_config_value $CONFIG_PATH/dmb_server.ini "ip"		"192.168.1.2"	
		check_config_value $CONFIG_PATH/dmb_server.ini "port"		"12345"	
		check_config_value $CONFIG_PATH/dmb_server.ini "pcrt"		"54321"	
		check_config_value $CONFIG_PATH/dmb_server.ini "boxno"		"12345678"	
		
		send_key_and_wait "ok:del:del:del:del:del:del:del:del:del:del:del:0:ar:0:ar:0:ar:0:wait3:down"
		send_key_and_wait "del:del:del:del:del:0:down"
		send_key_and_wait "del:del:del:del:del:0:down"
		send_key_and_wait "del:del:del:del:del:del:del:del:0:wait3:0:wait3:0:wait3:0:wait3:0:wait3:0:wait3:0:wait3:1:down"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_server.ini "ip"		"0.0.0.0"	
		check_config_value $CONFIG_PATH/dmb_server.ini "port"		"0"	
		check_config_value $CONFIG_PATH/dmb_server.ini "pcrt"		"0"	
		check_config_value $CONFIG_PATH/dmb_server.ini "boxno"		"00000001"	

		send_key_and_wait "ok:del:del:del:del:del:del:del:2:5:wait2:5:ar:2:5:wait2:5:ar:2:5:wait2:5:ar:2:5:wait2:5:wait2:down"
		send_key_and_wait "del:6:5:5:3:5:down"
		send_key_and_wait "del:6:5:5:3:5:down"
		send_key_and_wait "del:del:del:del:del:del:del:del:9:wait2:9:wait2:9:wait2:9:wait2:9:wait2:9:wait2:9:wait2:9:wait2:down"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_server.ini "ip"		"255.255.255.255"	
		check_config_value $CONFIG_PATH/dmb_server.ini "port"		"65535"	
		check_config_value $CONFIG_PATH/dmb_server.ini "pcrt"		"65535"	
		check_config_value $CONFIG_PATH/dmb_server.ini "boxno"		"99999999"	
		
		send_key_and_wait "ok:down:down:down:del:del:del:del:del:del:del:del"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_server.ini "boxno"		""
		
		send_key_and_wait "ok:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:2:5:6:ar:2:5:6:ar:2:5:6:ar:2:5:6"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_server.ini "ip"		"255.255.255.255"	
		
		send_key_and_wait "esc:ok:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:9:9:wait2:9:9:wait2:9:9:ar:2:2:2:wait2:2:2:4:4:4:4:3:3:8:8:8:1:2:3:4:5:ar:2:2:2:2:6:6:6:6:wait2:6:6"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_server.ini "ip"		"www.baidu12345.com"	
		
		send_key_and_wait "ok:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:9:9:wait2:9:9:wait2:9:9:ar:2:2:2:wait2:2:2:4:4:4:4:wait2:3:3:wait2:8:8:8:1:ar:2:2:2:2:6:6:6:6:wait2:6:6"
		send_key_and_wait "ok:wait3"

		check_config_value $CONFIG_PATH/dmb_server.ini "ip"		"www.baidu12345.com"	
		send_key_and_wait "esc:ok:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del"
		send_key_and_wait "9:9:wait2:9:9:wait2:9:9:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:2:2:2:wait2:2:2:4:4:4:4:3:3:8:8:8:1:ar:2:2:2:2:6:6:6:6:wait2:6:6"
		send_key_and_wait "ok:wait3"

		check_config_value $CONFIG_PATH/dmb_server.ini "ip"		"www.baidu12345.com"	
		send_key_and_wait "esc:ok:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del"
		send_key_and_wait "9:9:wait2:9:9:wait2:9:9:ar:2:2:2:wait2:2:2:4:4:4:4:3:3:8:8:8:1:ar:wait2:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:wait2:ar:2:2:2:2:6:6:6:6:wait2:6:6"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_server.ini "ip"		"www.baidu12345.com"	
		
		send_key_and_wait "esc:ok:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del"
		send_key_and_wait "9:9:wait2:9:9:wait2:9:9:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:wait2:ar:2:2:2:wait2:2:2:4:4:4:4:3:3:8:8:8:1:ar:2:2:2:2:6:6:6:6:wait2:6:6"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_server.ini "ip"		"www.baidu12345.com"	
		
		send_key_and_wait "esc:ok:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del"
		send_key_and_wait "9:9:wait2:9:9:wait2:9:9:ar:2:2:2:wait2:2:2:4:4:4:4:3:3:8:8:8:1:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:wait2:ar:2:2:2:2:6:6:6:6:wait2:6:6"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_server.ini "ip"		"www.baidu12345.com"	
		
		send_key_and_wait "esc:ok:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del"
		send_key_and_wait "9:9:wait2:9:9:wait2:9:9:ar:2:2:2:wait2:2:2:4:4:4:4:3:3:8:8:8:1:ar:2:2:2:2:6:6:6:6:wait2:6:6:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_server.ini "ip"		"www.baidu12345.com"	
		
		send_key_and_wait "esc:ok:down:del:6:down:del:6:down:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_server.ini "port"		"65535"	
		check_config_value $CONFIG_PATH/dmb_server.ini "pcrt"		"65535"	
		
		send_key_and_wait "esc:ok:down:down:down:del:del:del:del:del:del:del:del:del:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_server.ini "boxno"		""
		
		send_key_and_wait "down:down:down:0:wait2:0:wait2:0:wait2:0:1:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_server.ini "boxno"		""
		
		send_key_and_wait "esc:ok:down:down:down:2:2:2:2:2:2:6:6:6:6:6:6:6:9:9:9:9:9:9:9:0:wait2:0:wait2:0:1:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_server.ini "boxno"		""
		
		send_key_and_wait "esc:ok:down:down:down:9:wait2:9:wait2:9:wait2:9:wait2:9:wait2:9:wait2:9:wait2:9:wait2:9:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_server.ini "boxno"		"999999999"
				
	elif [ "$TEST_PRODUCT" = "2810" ] ; then 
		send_key_and_wait "f3:down:right:down:down:down:down:down:down:right"
		send_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:del:del:1:9:2:ar:1:6:8:ar:1:ar:2:wait3:down"
		send_key_and_wait "del:del:del:del:del:1:2:3:4:5:down"
		send_key_and_wait "del:del:del:del:del:5:4:3:2:1:down"
		send_key_and_wait "1:2:3:4:5:6:7:8:wait3"
		send_key_and_wait "ok:wait3"
		
		check_config_value $CONFIG_PATH/dmb_server.ini "ip"		"192.168.1.2"	
		check_config_value $CONFIG_PATH/dmb_server.ini "port"		"12345"	
		check_config_value $CONFIG_PATH/dmb_server.ini "pcrt"		"54321"	
		check_config_value $CONFIG_PATH/dmb_server.ini "boxno"		"12345678"	
		
		send_key_and_wait "left:right:del:del:del:del:del:del:del:del:del:del:del:0:ar:0:ar:0:ar:0:down"
		send_key_and_wait "del:del:del:del:del:0:down"
		send_key_and_wait "del:del:del:del:del:0:down"
		send_key_and_wait "del:del:del:del:del:del:del:del:0:0:0:0:0:0:0:1:down"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_server.ini "ip"		"0.0.0.0"	
		check_config_value $CONFIG_PATH/dmb_server.ini "port"		"0"	
		check_config_value $CONFIG_PATH/dmb_server.ini "pcrt"		"0"	
		check_config_value $CONFIG_PATH/dmb_server.ini "boxno"		"00000001"	
		send_key_and_wait "ok:wait3"	
		send_key_and_wait "left:right:del:del:del:del:del:del:del:2:5:wait2::5:ar:2:5:wait2:5:ar:2:5:wait2:5:ar:2:5:wait2:5:down"
		send_key_and_wait "del:6:5:5:3:5:down"
		send_key_and_wait "del:6:5:5:3:5:down"
		send_key_and_wait "del:del:del:del:del:del:del:del:9:wait2:9:wait2:9:wait2:9:wait2:9:wait2:9:wait2:9:wait2:9:wait2:down"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_server.ini "ip"		"255.255.255.255"	
		check_config_value $CONFIG_PATH/dmb_server.ini "port"		"65535"	
		check_config_value $CONFIG_PATH/dmb_server.ini "pcrt"		"65535"	
		check_config_value $CONFIG_PATH/dmb_server.ini "boxno"		"99999999"	
		
		send_key_and_wait "left:right:down:down:down:del:del:del:del:del:del:del:del"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_server.ini "boxno"		""
		
		send_key_and_wait "left:right:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:2:5:6:ar:2:5:6:ar:2:5:6:ar:2:5:6"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_server.ini "ip"		"255.255.255.255"	
		
		send_key_and_wait "left:right:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:9:9:wait2:9:9:wait2:9:9:ar:2:2:2:wait2:2:2:4:4:4:4:3:3:8:8:8:1:2:3:4:5:ar:2:2:2:2:6:6:6:6:wait2:6:6"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_server.ini "ip"		"255.255.255.255"
		
		send_key_and_wait "left:right:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:"
		send_key_and_wait "ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:9:9:wait2:9:9:wait2:9:9:ar:2:2:2:wait2:2:2:4:4:4:4:3:3:8:8:8:1:ar:2:2:2:2:6:6:6:6:wait2:6:6"
		send_key_and_wait "ok:wait3"

		check_config_value $CONFIG_PATH/dmb_server.ini "ip"		"255.255.255.255"
		send_key_and_wait "left:right:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:"
		send_key_and_wait "9:9:wait2:9:9:wait2:9:9:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:2:2:2:wait2:2:2:4:4:4:4:3:3:8:8:8:1:ar:2:2:2:2:6:6:6:6:wait2:6:6"
		send_key_and_wait "ok:wait3"

		check_config_value $CONFIG_PATH/dmb_server.ini "ip"		"255.255.255.255"
		send_key_and_wait "left:right:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:"
		send_key_and_wait "9:9:wait2:9:9:wait2:9:9:ar:2:2:2:wait2:2:2:4:4:4:4:3:3:8:8:8:1:ar:wait2:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:wait2:ar:2:2:2:2:6:6:6:6:wait2:6:6"
		send_key_and_wait "ok:wait3"

		check_config_value $CONFIG_PATH/dmb_server.ini "ip"		"255.255.255.255"
		send_key_and_wait "left:right:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:"
		send_key_and_wait "9:9:wait2:9:9:wait2:9:9:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:wait2:ar:2:2:2:wait2:2:2:4:4:4:4:3:3:8:8:8:1:ar:2:2:2:2:6:6:6:6:wait2:6:6"
		send_key_and_wait "ok:wait3"

		check_config_value $CONFIG_PATH/dmb_server.ini "ip"		"255.255.255.255"
		send_key_and_wait "left:right:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:"
		send_key_and_wait "9:9:wait2:9:9:wait2:9:9:ar:2:2:2:wait2:2:2:4:4:4:4:3:3:8:8:8:1:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:wait2:ar:2:2:2:2:6:6:6:6:wait2:6:6"
		send_key_and_wait "ok:wait3"

		check_config_value $CONFIG_PATH/dmb_server.ini "ip"		"255.255.255.255"
		send_key_and_wait "ok:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:"
		send_key_and_wait "9:9:wait2:9:9:wait2:9:9:ar:2:2:2:wait2:2:2:4:4:4:4:3:3:8:8:8:1:ar:2:2:2:2:6:6:6:6:wait2:6:6:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar:ar"
		send_key_and_wait "ok:wait3"

		check_config_value $CONFIG_PATH/dmb_server.ini "ip"		"255.255.255.255"
		
		send_key_and_wait "left:right:down:del:6:down"
		send_key_and_wait "del:6:down"
		check_config_value $CONFIG_PATH/dmb_server.ini "port"		"65535"	
		check_config_value $CONFIG_PATH/dmb_server.ini "pcrt"		"65535"	
		
		send_key_and_wait "left:right:down:down:down:0:0:0:0:1"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_server.ini "boxno"		""
		
		send_key_and_wait "0:0:0:0:1"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_server.ini "boxno"		""
		
		send_key_and_wait "9:wait2:9:wait2:9:wait2:9:wait2:9:wait2:9:wait2:9:wait2:9:wait2:9"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_server.ini "boxno"		""
		
		send_key_and_wait "2:2:2:2:2:2:6:6:6:6:6:6:6:9:9:9:9:9:9:9:0:0:0:1"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_server.ini "boxno"		""
	fi
}
##
#	\���ܱ�� 	DMB1820-TS-IR-001-F9
# \����˵��	�ն˷ֱ�������
#	\��������	ͨ��ң�����˵������ն˷ֱ��ʣ�������
#	\��֤��		dmb_output.ini�ļ������ܹ���ȷ�޸�
##
_test_case_ir_config_resolution()
{

	if [ "$TEST_PRODUCT" = "1820" ]; then
		check_config_value $CONFIG_PATH/dmb_output.ini "width"		"1024"	
		check_config_value $CONFIG_PATH/dmb_output.ini "height"		"768"	
		send_key_and_wait "f3:4:ok:0"
		send_key_and_wait "ok:down:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "width"		"800"	
		check_config_value $CONFIG_PATH/dmb_output.ini "height"		"600"	
		send_key_and_wait "ok:down:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "width"		"1024"	
		check_config_value $CONFIG_PATH/dmb_output.ini "height"		"768"	
		send_key_and_wait "ok:down:down:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "width"		"1280"	
		check_config_value $CONFIG_PATH/dmb_output.ini "height"		"720"		
		send_key_and_wait "ok:down:down:down:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "width"		"1280"	
		check_config_value $CONFIG_PATH/dmb_output.ini "height"		"768"	
		send_key_and_wait "ok:down:down:down:down:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "width"		"1280"	
		check_config_value $CONFIG_PATH/dmb_output.ini "height"		"1024"	
		send_key_and_wait "ok:down:down:down:down:down:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "width"		"1360"	
		check_config_value $CONFIG_PATH/dmb_output.ini "height"		"768"	
		send_key_and_wait "ok:down:down:down:down:down:down:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "width"		"1366"	
		check_config_value $CONFIG_PATH/dmb_output.ini "height"		"768"	
		send_key_and_wait "ok:down:down:down:down:down:down:down:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "width"		"1440"	
		check_config_value $CONFIG_PATH/dmb_output.ini "height"		"900"	
		send_key_and_wait "ok:down:down:down:down:down:down:down:down:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "width"		"1600"	
		check_config_value $CONFIG_PATH/dmb_output.ini "height"		"1200"	
		send_key_and_wait "ok:down:down:down:down:down:down:down:down:down:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "width"		"1680"	
		check_config_value $CONFIG_PATH/dmb_output.ini "height"		"1050"	
		send_key_and_wait "ok:down:down:down:down:down:down:down:down:down:down:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "width"		"1920"	
		check_config_value $CONFIG_PATH/dmb_output.ini "height"		"1080"	
	elif [ "$TEST_PRODUCT" = "2810" ] ; then 
		debug "no test"
	fi
}
##
#	\���ܱ�� 	DMB1820-TS-IR-001-F10
# \����˵��	�ն����ȶԱȶ�����
#	\��������	ͨ��ң�����˵������ն����ȶԱȶȣ�������
#	\��֤��		dmb_output.ini�ļ������ܹ���ȷ�޸�
##
_test_case_ir_config_light_contrast()
{

	if [ "$TEST_PRODUCT" = "1820" ]; then
	#����
		check_config_value $CONFIG_PATH/dmb_output.ini "light"		"120"	
		check_config_value $CONFIG_PATH/dmb_output.ini "contrast"		"128"	
		send_key_and_wait "f3:4:ok:2:ok"
		send_key_and_wait "left:left:left:left:left:left:left:left:left:left:left:left:left:left:left:left"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "light"		"0"	
		for i in $(seq 30); do  
			send_key_and_wait "ok:right:ok:wait3"
			check_config_value $CONFIG_PATH/dmb_output.ini "light"		$(($i*8))	
	 	done
	 	send_key_and_wait "ok:left:left:left:left:left:left:left:left:left:left:left:left:left:left:left:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "light"		"120"		
	#�Աȶ�	
		send_key_and_wait "ok:down:left:left:left:left:left:left:left:left:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "contrast"		"0"	
		for i in $(seq 15); do  
			send_key_and_wait "ok:down:right:ok:wait3"
			check_config_value $CONFIG_PATH/dmb_output.ini "contrast"		$(($i*16))	
	 	done
		send_key_and_wait "ok:down:right:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "contrast"		"255"	
	 	send_key_and_wait "ok:down:left:left:left:left:left:left:left:left:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "contrast"		"128"
	elif [ "$TEST_PRODUCT" = "2810" ] ; then 
		debug 2810
	fi
}
##
#	\���ܱ�� 	DMB1820-TS-IR-001-F11
# \����˵��	�ն���������
#	\��������	ͨ��ң�����˵������ն����ԣ�������
#	\��֤��		dmb_system.ini�ļ������ܹ���ȷ�޸�
##
_test_case_ir_config_language()
{	

	if [ "$TEST_PRODUCT" = "1820" ]; then
		check_config_value $CONFIG_PATH/dmb_system.ini "language"		"zh-cn"	
	  send_key_and_wait "f3:4:ok:4:ok"
		send_key_and_wait "right:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_system.ini "language"		"en"	
		send_key_and_wait "ok:right:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_system.ini "language"		"zh-cn"	
	elif [ "$TEST_PRODUCT" = "2810" ] ; then 
		debug 2810
	fi
}


##
#	\���ܱ�� 	DMB1820-TS-IR-001-F12
# \����˵��	�ն����ģʽ����
#	\��������	ͨ��ң�����˵������ն����ģʽ��������
#	\��֤��		dmb_output.ini�ļ������ܹ���ȷ�޸�
##
_test_case_ir_config_output_mode()
{	

	if [ "$TEST_PRODUCT" = "1820" ]; then
		check_config_value $CONFIG_PATH/dmb_output.ini "mode"		"vga"
	  send_key_and_wait "f3:4:ok:5:ok"
		send_key_and_wait "right:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "mode"		"hdmi"
		send_key_and_wait "ok:right:ok:wait3"	
		check_config_value $CONFIG_PATH/dmb_output.ini "mode"		"vga"
	elif [ "$TEST_PRODUCT" = "2810" ] ; then 
		debug "no test"
	fi
}

##
#	\���ܱ�� 	DMB1820-TS-IR-001-F9 DMB1820-TS-IR-001-F12
# \����˵��	�ն˷ֱ������� �ն����ģʽ���� (2810����)
#	\��������	ͨ��ң�����˵������ն˷ֱ��ʣ������� ͨ��ң�����˵������ն����ģʽ��������
#	\��֤��		dmb_output.ini�ļ������ܹ���ȷ�޸�
##
_test_case_ir_config_output_resolution()
{	

	if [ "$TEST_PRODUCT" = "1820" ]; then
		debug "no test"
	elif [ "$TEST_PRODUCT" = "2810" ] ; then 
		check_config_value $CONFIG_PATH/dmb_output.ini "width"		"1024"	
		check_config_value $CONFIG_PATH/dmb_output.ini "height"		"768"	
		check_config_value $CONFIG_PATH/dmb_output.ini "mode"		"vga"
	  send_key_and_wait "f3:down:right:down:down:down:down:down:down:down:right"
		send_key_and_wait "down:right:down:ok:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "width"		"1280"	
		check_config_value $CONFIG_PATH/dmb_output.ini "height"		"720"	
		send_key_and_wait "right:down:ok:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "width"		"1280"	
		check_config_value $CONFIG_PATH/dmb_output.ini "height"		"1024"	
		send_key_and_wait "right:down:ok:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "width"		"1440"	
		check_config_value $CONFIG_PATH/dmb_output.ini "height"		"900"	
		send_key_and_wait "right:down:ok:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "width"		"1920"	
		check_config_value $CONFIG_PATH/dmb_output.ini "height"		"1080"	
		send_key_and_wait "right:down:ok:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "width"		"1024"	
		check_config_value $CONFIG_PATH/dmb_output.ini "height"		"768"	
		send_key_and_wait "up:right:down:ok:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "width"		"1280"	
		check_config_value $CONFIG_PATH/dmb_output.ini "height"		"720"	
		check_config_value $CONFIG_PATH/dmb_output.ini "mode"		"hdmi"
		send_key_and_wait "down:right:down:ok:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "width"		"1920"	
		check_config_value $CONFIG_PATH/dmb_output.ini "height"		"1080"	
		send_key_and_wait "right:down:ok:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "width"		"1280"	
		check_config_value $CONFIG_PATH/dmb_output.ini "height"		"720"	
		send_key_and_wait "up:right:down:ok:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "width"		"1280"	
		check_config_value $CONFIG_PATH/dmb_output.ini "height"		"720"	
		check_config_value $CONFIG_PATH/dmb_output.ini "mode"		"vga"
	fi
}
##
#	\���ܱ�� 	DMB1820-TS-IR-001-F13
# \����˵��	�ն���ת�Ƕ�����
#	\��������	ͨ��ң�����˵������ն���ת�Ƕȣ�������
#	\��֤��		dmb_output.ini�ļ������ܹ���ȷ�޸�
##
_test_case_ir_config_rotate()
{	

	if [ "$TEST_PRODUCT" = "1820" ]; then
		check_config_value $CONFIG_PATH/dmb_output.ini "rotate"		"0"	
	  send_key_and_wait "f3:4:ok:6:ok"
		send_key_and_wait "right:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "rotate"		"90"	
		send_key_and_wait "ok:right:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "rotate"		"180"	
		send_key_and_wait "ok:right:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "rotate"		"270"	
		send_key_and_wait "ok:right:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "rotate"		"0"	
	elif [ "$TEST_PRODUCT" = "2810" ] ; then 
		check_config_value $CONFIG_PATH/dmb_output.ini "rotate"		"0"	
	  send_key_and_wait "f3:down:right:down:down:down:down:down:down:down:down:down:down:right"
		send_key_and_wait "right:down:ok:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "rotate"		"90"	
		send_key_and_wait "right:down:ok:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "rotate"		"180"	
		send_key_and_wait "right:down:ok:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "rotate"		"270"	
		send_key_and_wait "right:down:ok:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "rotate"		"0"	
	fi
}
##
#	\���ܱ�� 	DMB1820-TS-IR-001-F14
# \����˵��	�ն�ʱ������
#	\��������	ͨ��ң�����˵������ն�ʱ����������
#	\��֤��		TZ �ļ������ܹ���ȷ�޸�
##
_test_case_ir_config_timezone()
{	

  if [ "$TEST_PRODUCT" = "1820" ]; then
		check_text $CONFIG_PATH/TZ  "UTC-08:00"
		send_key_and_wait "f3:4:ok:7" 
	  send_key_and_wait "ok:left:left:left:left:left:left:left:left:left:left:left:left:left:ok:wait3"
	  check_text $CONFIG_PATH/TZ  "UTC"
	  check_no_text $CONFIG_PATH/TZ "-"	
		
		timezone="-01:00 -02:00 -03:00 -03:30 -04:00 -04:30 -05:00 -05:30 -05:45 -06:00 -06:30 -07:00 -08:00 -08:45 -09:00 -09:30 -10:00 -10:30 -11:00 -11:30 -12:00 -12:45 -13:00 -14:00 +12:00 +11:00 +10:00 +09:30 +09:00 +08:00 +07:00 +06:00 +05:00 +04:30 +04:00 +03:30 +03:00 +02:00 +01:00" 
	  for i in $timezone ; do 
	  	send_key_and_wait "ok:right:ok:wait3"
	  	check_text $CONFIG_PATH/TZ  "UTC"$i
	  done
	elif [ "$TEST_PRODUCT" = "2810" ] ; then 
		check_text $CONFIG_PATH/TZ  "UTC-08:00"
		send_key_and_wait "f3:down:right:down:down:down:down:down:down:down:down:down:down:down:down:down:right" 
	  send_key_and_wait "right:up:up:up:up:up:up:up:up:up:up:up:up:up:ok:ok:wait3"
	  check_text $CONFIG_PATH/TZ  "UTC"
	  check_no_text $CONFIG_PATH/TZ "-"	
		
		timezone="-01:00 -02:00 -03:00 -03:30 -04:00 -04:30 -05:00 -05:30 -05:45 -06:00 -06:30 -07:00 -08:00 -08:45 -09:00 -09:30 -10:00 -10:30 -11:00 -11:30 -12:00 -12:45 -13:00 -14:00 +12:00 +11:00 +10:00 +09:30 +09:00 +08:00 +07:00 +06:00 +05:00 +04:30 +04:00 +03:30 +03:00 +02:00 +01:00" 
	  for i in $timezone ; do 
	  	send_key_and_wait "right:down:ok:ok:wait3"
	  	check_text $CONFIG_PATH/TZ  "UTC"$i
	  done
	fi
}
##
#	\���ܱ�� 	DMB1820-TS-IR-001-F17
# \����˵��	�ն�ͬ������
#	\��������	ͨ��ң�����˵������ն�ͬ������
#	\��֤��		dmb_system.ini�ļ������ܹ���ȷ�޸�
##
_test_case_ir_config_syn()
{	

	if [ "$TEST_PRODUCT" = "1820" ]; then
		check_config_value $CONFIG_PATH/dmb_system.ini "syn_flag"		"0"	
	   send_key_and_wait "f3:4:ok:9:down:ok"
		send_key_and_wait "right:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_system.ini "syn_flag"		"1"	
		send_key_and_wait "ok:right:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_system.ini "syn_flag"		"0"	
	elif [ "$TEST_PRODUCT" = "2810" ] ; then 
		check_config_value $CONFIG_PATH/dmb_system.ini "syn_flag"		"0"	
	  send_key_and_wait "f3:down:right:down:down:down:down:down:down:down:down:down:down:down:down:down:down:down:down:right" 
		send_key_and_wait "right:down:ok:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_system.ini "syn_flag"		"1"	
		send_key_and_wait "right:down:ok:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_system.ini "syn_flag"		"0"	
	fi
}
##
#	\���ܱ�� 	DMB1820-TS-IR-001-F15 DMB1820-TS-IR-001-F27
# \����˵��	�ն���������
#	\��������	ͨ��ң�����˵������ն���������
#	\��֤��		dmb.passwd �ļ������ܹ���ȷ�޸�
##
_test_case_ir_config_pwd()
{	

	if [ "$TEST_PRODUCT" = "1820" ]; then
		send_key_and_wait "f3:4:ok:8:ok"
		send_key_and_wait "0:ok"
		send_key_and_wait "down:down:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "down:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "ok:wait3"
		send_key_and_wait "esc:esc:esc"
		check_text $CONFIG_PATH/dmb.passwd  "admin:fe008700f25cb28940ca8ed91b23b354" 
		send_key_and_wait "f3"
		send_key_and_wait "1:2:3:4:5:6:7:2:2:ok"
		send_key_and_wait "4:ok:8:ok" 
		send_key_and_wait "0:ok"
		send_key_and_wait "down:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "down:down:down:ok"
		send_key_and_wait "ok:wait3"
		send_key_and_wait "esc:esc:esc"
		check_text $CONFIG_PATH/dmb.passwd  "admin:" 
		check_no_text  $CONFIG_PATH/dmb.passwd "fe008700f25cb28940ca8ed91b23b354"	
		
		send_key_and_wait "f3:4:ok:8:ok"
		send_key_and_wait "0:ok"
		send_key_and_wait "down:down:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "down:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "ok:wait3"
		check_text $CONFIG_PATH/dmb.passwd  "admin:fe008700f25cb28940ca8ed91b23b354" 
		
		send_key_and_wait "ok:1:2:down"
		send_key_and_wait "down:1:2:3:4:5:6:7"
		send_key_and_wait "ok:wait3"
		send_key_and_wait "esc"
		check_text $CONFIG_PATH/dmb.passwd  "admin:fe008700f25cb28940ca8ed91b23b354" 
		
		send_key_and_wait "ok:del:del:del:del:del"
		send_key_and_wait "down:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "ok:wait3"
		check_text $CONFIG_PATH/dmb.passwd  "admin:" 
		send_key_and_wait "1:2:wait2:2:2:wait2:2:2:2"
		send_key_and_wait "ok:wait3"
		check_text $CONFIG_PATH/dmb.passwd  "admin:" 		
		send_key_and_wait "del:del:del:del:1:2:3:4:5:6:7:8:9:0:2:2:3:3:4:4:5:5:ar:ar:wait2"
		send_key_and_wait "ok:wait3"
		check_text $CONFIG_PATH/dmb.passwd  "admin:" 	
		send_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:1:2:3:4:5:6:7:8:9:0:2:2:3:3:4:4:5:5:6:6:7:7:wait2"
		send_key_and_wait "ok:wait3"
		check_text $CONFIG_PATH/dmb.passwd  "admin:" 	
		send_key_and_wait "esc"
		
		send_key_and_wait "ok:down:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "down:1:2:3:4:5:6:7:3:3"
		send_key_and_wait "down:1:2:3:4:5:6:7:"
		send_key_and_wait "ok:wait3"
		check_text $CONFIG_PATH/dmb.passwd  "admin:fe008700f25cb28940ca8ed91b23b354"
		send_key_and_wait "esc"
		
		send_key_and_wait "ok:down:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "down:1:2:3:4:5:6:7:3:3"
		send_key_and_wait "down:1:2:3:4:5:6:7:"
		send_key_and_wait "ok:wait3"
		check_text $CONFIG_PATH/dmb.passwd  "admin:fe008700f25cb28940ca8ed91b23b354"
		send_key_and_wait "esc"
		
		send_key_and_wait "ok:down:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "down:1:2:3:4:5:6:7:8"
		send_key_and_wait "down:1:2:3:4:5:6:7:8"
		send_key_and_wait "ok:wait3"
		check_text $CONFIG_PATH/dmb.passwd  "admin:fe008700f25cb28940ca8ed91b23b354"
		send_key_and_wait "esc"
		 	
		send_key_and_wait "ok:down:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "down:2:2:3:3:4:4:5:5:6:6:7:7:8:8:9:9"
		send_key_and_wait "down:2:2:3:3:4:4:5:5:6:6:7:7:8:8:9:9"
		send_key_and_wait "ok:wait3"
		check_text $CONFIG_PATH/dmb.passwd  "admin:fe008700f25cb28940ca8ed91b23b354"
		send_key_and_wait "esc"		
		
		send_key_and_wait "ok:down:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "down:1:2:2:3:4:4:5:6:6:7"
		send_key_and_wait "down:1:2:2:3:4:4:5:6:6:7"
		send_key_and_wait "ok:wait3"
		check_text $CONFIG_PATH/dmb.passwd  "admin:fe008700f25cb28940ca8ed91b23b354"
		send_key_and_wait "esc"	
		
		send_key_and_wait "ok:down:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "down:1:2:2:3:4:4:5:6:6:7:8:8:9"
		send_key_and_wait "down:1:2:2:3:4:4:5:6:6:7:8:8:9"
		send_key_and_wait "ok:wait3"
		check_text $CONFIG_PATH/dmb.passwd  "admin:fe008700f25cb28940ca8ed91b23b354"
		send_key_and_wait "esc"			
		
	elif [ "$TEST_PRODUCT" = "2810" ] ; then 
	
		send_key_and_wait "f3:down:right:down:down:down:down:down:down:down:down:down:down:down:right"
		send_key_and_wait "down:down:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "down:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "ok:wait3"
		send_key_and_wait "esc:esc:esc"
		check_text $CONFIG_PATH/dmb.passwd  "admin:fe008700f25cb28940ca8ed91b23b354" 
		send_key_and_wait "f3:1:2:3:4:5:6:7:2:2:ok"
		send_key_and_wait "down:right:down:down:down:down:down:down:down:down:down:down:down:right" 
		send_key_and_wait "down:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "down:down:down:ok"
		send_key_and_wait "ok:wait3"
		send_key_and_wait "esc:esc:esc"
		check_text $CONFIG_PATH/dmb.passwd  "admin:" 
		check_no_text  $CONFIG_PATH/dmb.passwd "fe008700f25cb28940ca8ed91b23b354"	
		
		send_key_and_wait "f3:down:right:down:down:down:down:down:down:down:down:down:down:down:right" 
		send_key_and_wait "down:down:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "down:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "ok:wait3:left"
		
		check_text $CONFIG_PATH/dmb.passwd  "admin:fe008700f25cb28940ca8ed91b23b354" 
		
		send_key_and_wait "right:1:2:down"
		send_key_and_wait "down:1:2:3:4:5:6:7"
		send_key_and_wait "ok:wait3:left"
		check_text $CONFIG_PATH/dmb.passwd  "admin:fe008700f25cb28940ca8ed91b23b354" 
		
		send_key_and_wait "right:del:del:del:del:del"
		send_key_and_wait "down:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "ok:wait3"
		check_text $CONFIG_PATH/dmb.passwd  "admin:" 
		send_key_and_wait "up:1:2:wait2:2:2:wait2:2:2:2"
		send_key_and_wait "ok:wait3"
		check_text $CONFIG_PATH/dmb.passwd  "admin:" 		
		send_key_and_wait "left:right:del:del:del:del:1:2:3:4:5:6:7:8:9:0:2:2:3:3:4:4:5:5:ar:ar:wait2"
		send_key_and_wait "ok:wait3"
		check_text $CONFIG_PATH/dmb.passwd  "admin:" 	
		send_key_and_wait "left:right:del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:1:2:3:4:5:6:7:8:9:0:2:2:3:3:4:4:5:5:6:6:7:7:wait2"
		send_key_and_wait "ok:wait3"
		check_text $CONFIG_PATH/dmb.passwd  "admin:" 	

		send_key_and_wait "left:right:down:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "down:1:2:3:4:5:6:7:3:3"
		send_key_and_wait "down:1:2:3:4:5:6:7:"
		send_key_and_wait "ok:wait3"
		check_text $CONFIG_PATH/dmb.passwd  "admin:fe008700f25cb28940ca8ed91b23b354"

		
		send_key_and_wait "left:right:down:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "down:1:2:3:4:5:6:7:3:3"
		send_key_and_wait "down:1:2:3:4:5:6:7:"
		send_key_and_wait "ok:wait3"
		check_text $CONFIG_PATH/dmb.passwd  "admin:fe008700f25cb28940ca8ed91b23b354"
	
		send_key_and_wait "left:right:down:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "down:1:2:3:4:5:6:7:8"
		send_key_and_wait "down:1:2:3:4:5:6:7:8"
		send_key_and_wait "ok:wait3"
		check_text $CONFIG_PATH/dmb.passwd  "admin:fe008700f25cb28940ca8ed91b23b354"

		 	
		send_key_and_wait "left:right:down:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "down:2:2:3:3:4:4:5:5:6:6:7:7:8:8:9:9"
		send_key_and_wait "down:2:2:3:3:4:4:5:5:6:6:7:7:8:8:9:9"
		send_key_and_wait "ok:wait3"
		check_text $CONFIG_PATH/dmb.passwd  "admin:fe008700f25cb28940ca8ed91b23b354"

		
		send_key_and_wait "left:right:down:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "down:1:2:2:3:4:4:5:6:6:7"
		send_key_and_wait "down:1:2:2:3:4:4:5:6:6:7"
		send_key_and_wait "ok:wait3"
		check_text $CONFIG_PATH/dmb.passwd  "admin:fe008700f25cb28940ca8ed91b23b354"

		
#		send_key_and_wait "left:right:down:1:2:3:4:5:6:7:2:2"
#		send_key_and_wait "down:1:2:2:3:4:4:5:6:6:7:8:8:9"
#		send_key_and_wait "down:1:2:2:3:4:4:5:6:6:7:8:8:9"
#		send_key_and_wait "ok:wait3"
#		check_text $CONFIG_PATH/dmb.passwd  "admin:fe008700f25cb28940ca8ed91b23b354"

	
	fi
}
##
#	\���ܱ�� 	DMB1820-TS-IR-001-F15 DMB1820-TS-IR-001-F27
# \����˵��	�ն˵�½����
#	\��������	ͨ��ң�����˵������ն˵�½����
#	\��֤��		dmb_system.ini�ļ������ܹ���ȷ�޸�
##
_test_case_ir_login_pwd()
{	

	if [ "$TEST_PRODUCT" = "1820" ]; then
		check_config_value $CONFIG_PATH/dmb_system.ini "pwd"		""	
		send_key_and_wait "f3:4:ok:8:ok:down:ok"
		send_key_and_wait "down:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "down:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_system.ini "pwd"		"fe008700f25cb28940ca8ed91b23b354"	

		send_key_and_wait "ok:down:down:down:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_system.ini "pwd"		""	


		send_key_and_wait "ok:down:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "down:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_system.ini "pwd"		"fe008700f25cb28940ca8ed91b23b354"	
		
		send_key_and_wait "ok:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "down:1:2:2:3:4:4:5:6:6:7:8:8:9"
		send_key_and_wait "down:1:2:2:3:4:4:5:6:6:7:8:8:9"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_system.ini "pwd"		"f5a158b202c3cb43e49109da8f9db60d"	

		
		send_key_and_wait "ok:1:2:2:3:4:4:5:6:6:7:8:8:9"
		send_key_and_wait "down:1:2:3:4:5:6:7:3:3"
		send_key_and_wait "down:1:2:3:4:5:6:7"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_system.ini "pwd"		"f5a158b202c3cb43e49109da8f9db60d"	
		send_key_and_wait "esc"
		

		
		send_key_and_wait "ok:1:2:2:3:4:4:5:6:6:7:8:8:9"
		send_key_and_wait "down:1:2:3:4:5:6:7:8"
		send_key_and_wait "down:1:2:3:4:5:6:7:8"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_system.ini "pwd"		"f5a158b202c3cb43e49109da8f9db60d"	
		send_key_and_wait "esc"
		

		
		send_key_and_wait "ok:1:2:2:3:4:4:5:6:6:7:8:8:9"
		send_key_and_wait "down:1:2:2:3:4:4:5:6:6:7"
		send_key_and_wait "down:1:2:2:3:4:4:5:6:6:7"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_system.ini "pwd"		"f5a158b202c3cb43e49109da8f9db60d"	
		send_key_and_wait "esc"
		
		send_key_and_wait "ok:1:2:2:3:4:4:5:6:6:7:8:8:9"
		send_key_and_wait "down:1:2:3:4:5:6:7:8"
		send_key_and_wait "down:1:2:3:4:5:6:7:8"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_system.ini "pwd"		"f5a158b202c3cb43e49109da8f9db60d"	
		send_key_and_wait "esc"

		send_key_and_wait "ok:1:2:2:3:4:4:5:6:6:7:8:8:9"
		send_key_and_wait "down:2:2:3:3:4:4:5:5:6:6:7:7:8:8:9:9"
		send_key_and_wait "down:2:2:3:3:4:4:5:5:6:6:7:7:8:8:9:9"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_system.ini "pwd"		"f5a158b202c3cb43e49109da8f9db60d"	
		send_key_and_wait "esc"		
		
	elif [ "$TEST_PRODUCT" = "2810" ] ; then 
		check_config_value $CONFIG_PATH/dmb_system.ini "pwd"		""	
		send_key_and_wait "f3:down:right:down:down:down:down:down:down:down:down:down:down:down:down:right"

		send_key_and_wait "down:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "down:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_system.ini "pwd"		"fe008700f25cb28940ca8ed91b23b354"	

		send_key_and_wait "down:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_system.ini "pwd"		""	

		send_key_and_wait "left:right:down:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "down:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_system.ini "pwd"		"fe008700f25cb28940ca8ed91b23b354"	
		
		send_key_and_wait "left:right:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "down:1:2:3:4:5:6:7:3:3"
		send_key_and_wait "down:1:2:3:4:5:6:7"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_system.ini "pwd"		"fe008700f25cb28940ca8ed91b23b354"	

		
		send_key_and_wait "left:right:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "down:1:2:3:4:5:6:7:8"
		send_key_and_wait "down:1:2:3:4:5:6:7:8"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_system.ini "pwd"		"fe008700f25cb28940ca8ed91b23b354"	

		
#		send_key_and_wait "left:right:1:2:3:4:5:6:7:2:2"
#		send_key_and_wait "down:1:2:2:3:4:4:5:6:6:7:8:8:9"
#		send_key_and_wait "down:1:2:2:3:4:4:5:6:6:7:8:8:9"
#		send_key_and_wait "ok:wait3"
#		check_config_value $CONFIG_PATH/dmb_system.ini "pwd"		"fe008700f25cb28940ca8ed91b23b354"	

		
		send_key_and_wait "left:right:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "down:1:2:2:3:4:4:5:6:6:7"
		send_key_and_wait "down:1:2:2:3:4:4:5:6:6:7"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_system.ini "pwd"		"fe008700f25cb28940ca8ed91b23b354"	

		
		send_key_and_wait "left:right:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "down:1:2:3:4:5:6:7:8"
		send_key_and_wait "down:1:2:3:4:5:6:7:8"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_system.ini "pwd"		"fe008700f25cb28940ca8ed91b23b354"	


		send_key_and_wait "left:right:1:2:3:4:5:6:7:2:2"
		send_key_and_wait "down:2:2:3:3:4:4:5:5:6:6:7:7:8:8:9:9"
		send_key_and_wait "down:2:2:3:3:4:4:5:5:6:6:7:7:8:8:9:9"
		send_key_and_wait "ok:wait3"
		check_config_value $CONFIG_PATH/dmb_system.ini "pwd"		"fe008700f25cb28940ca8ed91b23b354"	
	
	fi
}
##
#	\���ܱ�� 	�����ޣ�
# \����˵��	�ն˴���ͼ��
#	\��������	ͨ��ң�����˵������ն˴���ͼ�꿪��
#	\��֤��		dmb_system.ini�ļ������ܹ���ȷ�޸�
##
_test_case_ir_config_error_ico()
{	

	if [ "$TEST_PRODUCT" = "1820" ]; then
		check_config_value $CONFIG_PATH/dmb_system.ini "lefttop_show"		"0"	
	  send_key_and_wait "f3:4:ok:9:down:down:ok"
		send_key_and_wait "right:ok:wait3"	
		check_config_value $CONFIG_PATH/dmb_system.ini "lefttop_show"		"1"	
		send_key_and_wait "ok:right:ok:wait3"	
		check_config_value $CONFIG_PATH/dmb_system.ini "lefttop_show"		"0"	
	elif [ "$TEST_PRODUCT" = "2810" ] ; then 
		debug "no test"
	fi
}
##
#	\���ܱ�� 	DMB1820-TS-IR-001-F16
# \����˵��	�ն�ϵͳʱ��
#	\��������	ͨ��ң�����˵������ն�ϵͳʱ��
#	\��֤��		�ն�ʱ���ܹ���ȷ�޸�
##
_test_case_ir_config_date()
{	

	if [ "$TEST_PRODUCT" = "1820" ]; then

		
	  send_key_and_wait "f3:4:ok:9:ok"
		send_key_and_wait "del:del:del:del:2:0:0:1:down"
		send_key_and_wait "del:del:1:down"
		send_key_and_wait "del:del:1:down"
		send_key_and_wait "del:del:0:down"
		send_key_and_wait "del:del:0:down"
		send_key_and_wait "del:del:0"
		send_key_and_wait "ok:wait3"
		check_date_text 200101010000
		
		send_key_and_wait "ok:down:down:del:del:2:9:up:del:2:up"
		send_key_and_wait "del:0:ok:wait3"
		check_date_text 20000229
		send_key_and_wait "ok:del:4:ok:wait3"
		check_date_text 20040229
		send_key_and_wait "ok:del:8:ok:wait3"
		check_date_text 20080229
		send_key_and_wait "ok:del:del:1:6:ok:wait3"
		check_date_text 20160229
		send_key_and_wait "ok:del:del:2:0:ok:wait3"
		check_date_text 20200229
		send_key_and_wait "ok:del:del:2:4:ok:wait3"
		check_date_text 20240229
		send_key_and_wait "ok:del:del:2:8:ok:wait3"
		check_date_text 20280229
		send_key_and_wait "ok:del:del:3:2:ok:wait3"
		check_date_text 20320229
		send_key_and_wait "ok:del:del:3:6:ok:wait3"
		check_date_text 20360229
		send_key_and_wait "ok:del:del:0:1:ok:wait3"
		check_date_text 20360229
		send_key_and_wait "del:0:down:down:del:del:3:0:ok:wait3"
		check_date_text 20360229
		send_key_and_wait "up:up:del:4:ok:wait3"
		check_date_text 20360229
		send_key_and_wait "del:8:ok:wait3"
		check_date_text 20360229
		send_key_and_wait "del:del:1:6:ok:wait3"
		check_date_text 20360229
		send_key_and_wait "del:del:2:0:ok:wait3"
		check_date_text 20360229
		send_key_and_wait "del:del:2:4:ok:wait3"
		check_date_text 20360229
		send_key_and_wait "del:del:2:8:ok:wait3"
		check_date_text 20360229
		send_key_and_wait "del:del:3:2:ok:wait3"
		check_date_text 20360229
		send_key_and_wait "del:del:3:6:ok:wait3"
		check_date_text 20360229		
		
		send_key_and_wait "del:del:del:del:2:0:0:1:down"
		send_key_and_wait "del:del:1:down"
		send_key_and_wait "del:del:1:down"
		send_key_and_wait "del:del:0:down"
		send_key_and_wait "del:del:0:down"
		send_key_and_wait "del:del:0"
		send_key_and_wait "ok:wait3"
		check_date_text 2001010100
		
		send_key_and_wait "ok:del:del:del:del:1:9:9:9:down:ok:wait3"
		check_date_text 2001010100
		send_key_and_wait "del:del:del:del:2:0:3:8:down:ok:wait3"
		check_date_text 2001010100
		send_key_and_wait "del:del:del:del:2:0:0:1:down"
		send_key_and_wait "del:del:0:ok:wait3"
		check_date_text 2001010100
		send_key_and_wait "del:del:1:3:ok:wait3"
		check_date_text 2001010100
		
		send_key_and_wait "esc:ok:down:down:del:del:3:0:up"
		send_key_and_wait "del:del:4:ok:wait3"
		check_date_text 2001043000
		send_key_and_wait "ok:down:del:del:6:ok:wait3"
		check_date_text 2001063000
		send_key_and_wait "ok:down:del:del:9:ok:wait3"
		check_date_text 2001093000
		send_key_and_wait "ok:down:del:del:1:1:ok:wait3"
		check_date_text 2001113000
		send_key_and_wait "ok:down:down:del:del:3:1:up"
		send_key_and_wait "del:del:1:ok:wait3"
		check_date_text 2001013100		
		send_key_and_wait "ok:down:del:del:3:ok:wait3"
		check_date_text 2001033100		
		send_key_and_wait "ok:down:del:del:5:ok:wait3"
		check_date_text 2001053100		
		send_key_and_wait "ok:down:del:del:7:ok:wait3"
		check_date_text 2001073100		
		send_key_and_wait "ok:down:del:del:8:ok:wait3"
		check_date_text 2001083100		
		send_key_and_wait "ok:down:del:del:1:0:ok:wait3"
		check_date_text 2001103100		
		send_key_and_wait "ok:down:del:del:1:2:ok:wait3"
		check_date_text 2001123100		
		send_key_and_wait "ok:down:del:del:4:ok:wait3"
		check_date_text 2001123100	
		send_key_and_wait "del:del:6:ok:wait3"
		check_date_text 2001123100	
		send_key_and_wait "del:del:9:ok:wait3"
		check_date_text 2001123100	
		send_key_and_wait "del:del:1:1:ok:wait3"
		check_date_text 2001123100	
		send_key_and_wait "esc:ok:down:down:del:del:3:2:up"	
		send_key_and_wait "del:del:1:ok:wait3"
		check_date_text 2001123100				
		send_key_and_wait "del:del:3:ok:wait3"
		check_date_text 2001123100	
		send_key_and_wait "del:del:5:ok:wait3"
		check_date_text 2001123100
		send_key_and_wait "del:del:7:ok:wait3"
		check_date_text 2001123100
		send_key_and_wait "del:del:8:ok:wait3"
		check_date_text 2001123100
		send_key_and_wait "del:del:1:0:ok:wait3"
		check_date_text 2001123100
		send_key_and_wait "del:del:1:2:ok:wait3"
		check_date_text 2001123100	
		
		send_key_and_wait "esc:ok:del:del:del:del:2:0:0:1:down"
		send_key_and_wait "del:del:1:down"
		send_key_and_wait "del:del:1:down"
		send_key_and_wait "del:del:0:down"
		send_key_and_wait "del:del:0:down"
		send_key_and_wait "del:del:0"
		send_key_and_wait "ok:wait3"
		check_date_text 200101010000
		send_key_and_wait "ok:down:down:down:del:del:2:4:ok:wait3"
		check_date_text 200101010000
		send_key_and_wait "del:del:0:1:down:del:del:6:0:ok:wait3"
		check_date_text 200101010000

	


	elif [ "$TEST_PRODUCT" = "2810" ] ; then 
	
		send_key_and_wait "f3:down:right:down:down:down:down:down:down:down:down:down:down:down:down:down:down:right" 
		send_key_and_wait "del:del:del:del:2:0:0:1:down"
		send_key_and_wait "del:del:1:down"
		send_key_and_wait "del:del:1:down"
		send_key_and_wait "del:del:1:down"
		send_key_and_wait "del:del:0:down"
		send_key_and_wait "del:del:0"
		send_key_and_wait "ok:wait3"
		check_date_text 200101010100
		
		send_key_and_wait "up:up:up:del:del:2:9:up:del:2:up"
		send_key_and_wait "del:0"
		send_key_and_wait "ok:wait3"
		check_date_text 20000229
		send_key_and_wait "del:4"
		send_key_and_wait "ok:wait3"
		check_date_text 20040229
		send_key_and_wait "del:8"
		send_key_and_wait "ok:wait3"
		check_date_text 20080229
		send_key_and_wait "del:del:1:6"
		send_key_and_wait "ok:wait3"
		check_date_text 20160229
		send_key_and_wait "del:del:2:0"
		send_key_and_wait "ok:wait3"
		check_date_text 20200229
		send_key_and_wait "del:del:2:4"
		send_key_and_wait "ok:wait3"
		check_date_text 20240229
		send_key_and_wait "del:del:2:8"
		send_key_and_wait "ok:wait3"
		check_date_text 20280229
		send_key_and_wait "del:del:3:2"
		send_key_and_wait "ok:wait3"
		check_date_text 20320229
		send_key_and_wait "del:del:3:6"
		send_key_and_wait "ok:wait3"
		check_date_text 20360229
		send_key_and_wait "del:del:0:1"
		send_key_and_wait "ok:wait3"
		check_date_text 20360229
		send_key_and_wait "del:0:down:down:del:del:3:0"
		send_key_and_wait "ok:wait3"
		check_date_text 20360229
		send_key_and_wait "up:up"
		send_key_and_wait "del:4"
		send_key_and_wait "ok:wait3"
		check_date_text 20360229
		send_key_and_wait "del:8"
		send_key_and_wait "ok:wait3"
		check_date_text 20360229
		send_key_and_wait "del:del:1:6"
		send_key_and_wait "ok:wait3"
		check_date_text 20360229
		send_key_and_wait "del:del:2:0"
		send_key_and_wait "ok:wait3"
		check_date_text 20360229
		send_key_and_wait "del:del:2:4"
		send_key_and_wait "ok:wait3"
		check_date_text 20360229
		send_key_and_wait "del:del:2:8"
		send_key_and_wait "ok:wait3"
		check_date_text 20360229
		send_key_and_wait "del:del:3:2"
		send_key_and_wait "ok:wait3"
		check_date_text 20360229
		send_key_and_wait "del:del:3:6"
		send_key_and_wait "ok:wait3"
		check_date_text 20360229		
		
		send_key_and_wait "left:right:del:del:del:del:2:0:0:1:down"
		send_key_and_wait "del:del:1:down"
		send_key_and_wait "del:del:1:down"
		send_key_and_wait "del:del:1:down"
		send_key_and_wait "del:del:0:down"
		send_key_and_wait "del:del:0"
		send_key_and_wait "ok:wait3"
		check_date_text 2001010101
		
#		send_key_and_wait "up:up:up:up:up:del:del:del:del:1:9:9:9:down:ok:wait3"
#		check_date_text 2001010101
		send_key_and_wait "up:up:up:up:up:del:del:del:del:2:0:3:8:down:ok:wait3"
		check_date_text 2001010101
		send_key_and_wait "del:del:del:del:2:0:0:1:down"
		send_key_and_wait "del:del:0:ok:wait3"
		check_date_text 2001010101
		send_key_and_wait "del:del:1:3:ok:wait3"
		check_date_text 2001010101
		
		send_key_and_wait "left:right:down:down:del:del:3:0:up"
		send_key_and_wait "del:del:4:ok:wait3"
		check_date_text 2001043001
		send_key_and_wait "del:del:6:ok:wait3"
		check_date_text 2001063001
		send_key_and_wait "del:del:9:ok:wait3"
		check_date_text 2001093001
		send_key_and_wait "del:del:1:1:ok:wait3"
		check_date_text 2001113001
		send_key_and_wait "left:right:down:down:del:del:3:1:up"
		send_key_and_wait "del:del:1:ok:wait3"
		check_date_text 2001013101		
		send_key_and_wait "del:del:3:ok:wait3"
		check_date_text 2001033101		
		send_key_and_wait "del:del:5:ok:wait3"
		check_date_text 2001053101		
		send_key_and_wait "del:del:7:ok:wait3"
		check_date_text 2001073101		
		send_key_and_wait "del:del:8:ok:wait3"
		check_date_text 2001083101		
		send_key_and_wait "del:del:1:0:ok:wait3"
		check_date_text 2001103101		
		send_key_and_wait "del:del:1:2:ok:wait3"
		check_date_text 2001123101		
		send_key_and_wait "del:del:4:ok:wait3"
		check_date_text 2001123101	
		send_key_and_wait "del:del:6:ok:wait3"
		check_date_text 2001123101	
		send_key_and_wait "del:del:9:ok:wait3"
		check_date_text 2001123101	
		send_key_and_wait "del:del:1:1:ok:wait3"
		check_date_text 2001123101	
		send_key_and_wait "left:right:down:down:del:del:3:2:up"	
		send_key_and_wait "del:del:1:ok:wait3"
		check_date_text 2001123101				
		send_key_and_wait "del:del:3:ok:wait3"
		check_date_text 2001123101	
		send_key_and_wait "del:del:5:ok:wait3"
		check_date_text 2001123101
		send_key_and_wait "del:del:7:ok:wait3"
		check_date_text 2001123101
		send_key_and_wait "del:del:8:ok:wait3"
		check_date_text 2001123101
		send_key_and_wait "del:del:1:0:ok:wait3"
		check_date_text 2001123101
		send_key_and_wait "del:del:1:2:ok:wait3"
		check_date_text 2001123101	
		
		send_key_and_wait "left:right:del:del:del:del:2:0:0:1:down"
		send_key_and_wait "del:del:1:down"
		send_key_and_wait "del:del:1:down"
		send_key_and_wait "del:del:1:down"
		send_key_and_wait "del:del:0:down"
		send_key_and_wait "del:del:0"
		send_key_and_wait "ok:wait3"
		check_date_text 200101010100
		send_key_and_wait "up:up:del:del:2:4:ok:wait3"
		check_date_text 200101010100
		send_key_and_wait "del:del:0:1:down:del:del:6:0:ok:wait3"
		check_date_text 200101010100
		
	fi
}

##
#	\���ܱ�� 	DMB1820-TS-IR-001-F21
# \����˵��	�ն�����
#	\��������	ͨ��ң�����˵������ն�������������
#	\��֤��		�ն������ܹ���ȷ�޸�
##
_test_case_ir_config_volume()
{

	if [ "$TEST_PRODUCT" = "1820" ]; then
		check_config_value $CONFIG_PATH/dmb_system.ini "volume"		"20"	
		send_key_and_wait  "vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown"
		sleep 3
		check_config_value $CONFIG_PATH/dmb_system.ini "volume"		"0"	
		
		for i in $(seq 24); do  
			send_key_and_wait "vup"
			sleep 3
			check_config_value $CONFIG_PATH/dmb_system.ini "volume"		$i
	 	done
		
		send_key_and_wait  "vdown:vdown:vdown:vdown"
		sleep 3
		check_config_value $CONFIG_PATH/dmb_system.ini "volume"		"20"	
	elif [ "$TEST_PRODUCT" = "2810" ] ; then 
		check_config_value $CONFIG_PATH/dmb_system.ini "volume"		"20"	
		send_key_and_wait  "vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown"
		sleep 3
		check_config_value $CONFIG_PATH/dmb_system.ini "volume"		"0"	
		
		for i in $(seq 24); do  
			send_key_and_wait "vup"
			sleep 3
			check_config_value $CONFIG_PATH/dmb_system.ini "volume"		$i
	 	done
		
		send_key_and_wait  "vdown:vdown:vdown:vdown:vdown"
		sleep 3
		check_config_value $CONFIG_PATH/dmb_system.ini "volume"		"20"	
	fi
}

##
#	\���ܱ�� 	��
# \����˵��	�ն��������
#	\��������	ͨ��ң�����˵������ն��������
#	\��֤��		�ն���������ܹ���ȷ�޸�
##
_test_case_ir_net_choise()
{
	if [ "$TEST_PRODUCT" = "1820" ]; then
		check_config_value $CONFIG_PATH/dmb_proxy.ini "dmb_net_choise"	"1"	
		send_key_and_wait "f3:0:ok:6"
		send_key_and_wait "ok:right:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_proxy.ini "dmb_net_choise"	"2"	
		send_key_and_wait "ok:right:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_proxy.ini "dmb_net_choise"	"1"	
		
	elif [ "$TEST_PRODUCT" = "2810" ] ; then 
		check_config_value $CONFIG_PATH/dmb_proxy.ini "dmb_net_choise"	"1"	
		send_key_and_wait "f3:down:right:down:right"
		send_key_and_wait "right:down:ok:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_proxy.ini "dmb_net_choise"	"2"	
		send_key_and_wait "right:down:ok:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_proxy.ini "dmb_net_choise"	"1"	
	fi
}

##
#	\���ܱ�� 	��
# \����˵��	�ն�U�̲���������
#	\��������	ͨ��ң�����˵������ն�U�̲���������
#	\��֤��		�ն�U�̲����������ܹ���ȷ�޸�
##
_test_case_ir_usb()
{
	if [ "$TEST_PRODUCT" = "1820" ]; then
		check_config_value $CONFIG_PATH/dmb_system.ini "u_denied_flag"	"0"	
		send_key_and_wait "f3:4:ok:9:down:down:down"
		send_key_and_wait "ok:right:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_system.ini "u_denied_flag"	"1"	
		send_key_and_wait "ok:right:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_system.ini "u_denied_flag"	"0"	
		
	elif [ "$TEST_PRODUCT" = "2810" ] ; then 
		check_config_value $CONFIG_PATH/dmb_system.ini "u_denied_flag"	"0"	
		send_key_and_wait "f3:down:right:down:down:down:down:down:down:down:down:down:down:down:down:down:down:down:down:down:right"
		send_key_and_wait "right:down:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_system.ini "u_denied_flag"	"1"	
		send_key_and_wait "right:down:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_system.ini "u_denied_flag"	"0"	
	fi
}

##
#	\���ܱ�� 	��
# \����˵��	�ն��������
#	\��������	ͨ��ң�����˵������ն��������
#	\��֤��		
##
_test_case_ir_usb()
{
	if [ "$TEST_PRODUCT" = "1820" ]; then
		send_key_and_wait "f3:4:ok:9:down:down:down:down:down:ok"
		send_key_and_wait "ok:wait3:down:ok:wait3:down:ok:wait3" 
	elif [ "$TEST_PRODUCT" = "2810" ] ; then 
		send_key_and_wait "f3:down:right:down:down:down:down:down:down:down:down:down:down:down:down:down:down:down:down:down:down:down:right"
		send_key_and_wait "ok:wait3:down:ok:wait3:down:ok:wait3"
	fi
}



