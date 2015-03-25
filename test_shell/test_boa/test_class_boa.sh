##
#  \file       test_class_boa.sh
#  \brief      boa��������Խű�
#
#   Copyright (C) 2004-2011 ��������������Ϣϵͳ���޹�˾
#   All rights reserved by ��������������Ϣϵͳ���޹�˾
#
#  \changelog  ��
#   2013��12��3��  ����
##

#!/bin/sh
before_class()
{
	echo ---before_class
#	killall -9 boa
	
	#����ΪĬ������
	rm -rf  /tmp/system.bak
	cp -rf  /tmp/config/system  /tmp/system.bak
	cp defaule_config/* /tmp/config/system/
	chmod 777 /tmp/config/system/*	
	sync	
	
	#����boa
	if [ -z "`ps | grep boa`" ] ; then
		cd $DMB_WEB_PATH/../..
		./startboa
		cd -
	fi
}
after_class()
{
	echo ---after_class
	#��ԭ����
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
	echo -after_case
}
##
#	\���ܱ�� 	DMB1820-TS-WEB-001-F3 
# \����˵��	��̫������
#	\��������	����ipconfig.cgi�ļ��������������̫����������
#	\��֤��		dmb_eth0.ini���������Ƿ���ȷ�޸�
##
_test_case_setipconfig()
{
	curl_set "ipconfig.cgi"  'ipaddress=192.168.2.2&netmask=255.255.255.0&gateway=192.168.2.1&submit=Save'
	check_config_value $CONFIG_PATH/dmb_eth0.ini  static_ip 		 "192.168.2.2"	
	check_config_value $CONFIG_PATH/dmb_eth0.ini  static_netmask "255.255.255.0"
	check_config_value $CONFIG_PATH/dmb_eth0.ini  static_gateway "192.168.2.1"
}
##
#	\���ܱ�� 	DMB1820-TS-WEB-001-F3 
# \����˵��	��̫�����û�ȡ
#	\��������	����getipconfig��ȡ��̫������
#	\��֤��		��ȡ���ݸ��ն�dmb_eth0.ini������һ��
##
_test_case_getipconfig()
{
	curl_get "getipconfig.cgi"
	check_curl_get_result $CONFIG_PATH/dmb_eth0.ini static_ip 			ip
	check_curl_get_result $CONFIG_PATH/dmb_eth0.ini static_netmask 	netmask
	check_curl_get_result $CONFIG_PATH/dmb_eth0.ini static_gateway 	gateway

}
##
#	\���ܱ�� 	DMB1820-TS-WEB-001-F16
# \����˵��	�ն�Ӳ����Ϣ��ѯ
#	\��������	����getdiskinfo.cgi��ȡӲ����Ϣ
#	\��֤��		��ȡ���ݸ��ն˵�ǰӲ��������Ϣ���
##
_test_case_getdiskinfo()
{
	curl_get "getdiskinfo.cgi"
}
##
#	\���ܱ�� 	DMB1820-TS-MT-009-F2
# \����˵��	�ն���ҳ���Ի�ȡ
#	\��������	����getlanguagetype.cgi��ȡ��ҳ����
#	\��֤��		��ȡ���ݸ��ն˶�Ӧ���������ɵ�����js�ļ���ͬ
##
_test_case_getlanguagetype()
{
	curl_get "getlanguagetype.cgi"
#	test_log_path="`cat $TEST_LOG_PATH/test.info | awk -F= '$1~/logs_path/  {print $2}'`"_"`cat $TEST_LOG_PATH/test.info | awk -F= '$1~/case_name/  {print $2}'`"
#	test_lang="`get_config_ini_value $CONFIG_PATH/dmb_system.ini language`"
#	file_md5_compare	 $test_log_path".get" /tmp/lang.js.$test_lang""
}
##
#	\���ܱ�� 	DMB1820-TS-WEB-001-F11	DMB1820-TS-WEB-001-F12	DMB1820-TS-WEB-001-F14 DMB1820-TS-WEB-001-F15 
# \����˵��	�ն�ϵͳ���û�ȡ
#	\��������	����getsysteminfo.cgi��ȡ�ն˵�ǰϵͳ���ã����ģʽ����ת�Ƕȣ�ͬ�����أ�����ͼ�꿪�أ�����ֱ��ʣ�ʱ����
#	\��֤��		��ȡ���ݸ��ն�dmb_output.ini��dmb_system.ini�ڶ�Ӧ������ͬ
##
_test_case_getsysteminfo()
{
	curl_get "getsysteminfo.cgi"

	check_curl_get_result $CONFIG_PATH/dmb_output.ini mode 			outputoption
	check_curl_get_result $CONFIG_PATH/dmb_output.ini rotate 		rotation

	check_curl_get_result $CONFIG_PATH/dmb_system.ini syn_flag 			synenable
	check_curl_get_result $CONFIG_PATH/dmb_system.ini lefttop_show 	enableicon
	
#��֤����ֱ���
	test_log_path="`cat $TEST_LOG_PATH/test.info | awk -F= '$1~/logs_path/  {print $2}'`"_"`cat $TEST_LOG_PATH/test.info | awk -F= '$1~/case_name/  {print $2}'`"
	test_resolution="`cat $test_log_path".get" | sed 's/,/\n/g' |  awk -F: -v tmpkey="resolution"  ' $1==tmpkey {print $2} ' |  sed 's/"//g'`"
	test_width=`echo $test_resolution | awk -Fx '{print $1}'`
	test_height=`echo $test_resolution | awk -Fx '{print $2}'`
	check_config_value $CONFIG_PATH/dmb_output.ini width		$test_width
	check_config_value $CONFIG_PATH/dmb_output.ini height		$test_height
#��֤ʱ��	
	test_log_path="`cat $TEST_LOG_PATH/test.info | awk -F= '$1~/logs_path/  {print $2}'`"_"`cat $TEST_LOG_PATH/test.info | awk -F= '$1~/case_name/  {print $2}'`"
	test_timezone="`cat $test_log_path".get" | sed 's/,/\n/g' |  awk -F: -v tmpkey="timezone"  ' $1==tmpkey {print $2} ' |  sed 's/"//g'`"
	check_text $CONFIG_PATH/TZ  $test_timezone

	test_log_path="`cat $TEST_LOG_PATH/test.info | awk -F= '$1~/logs_path/  {print $2}'`"_"`cat $TEST_LOG_PATH/test.info | awk -F= '$1~/case_name/  {print $2}'`"
	if [ $TEST_PRODUCT = 1320 ] ; then
		check_text $test_log_path".get"  '["vga","hdmi",]'
	elif 	[ $TEST_PRODUCT = 1620 ] ; then
		check_text $test_log_path".get"  '["vga","hdmi","av",]'
	elif 	[ $TEST_PRODUCT = 1820 ] ; then
		check_text $test_log_path".get"  '["vga","hdmi",]'
	elif 	[ $TEST_PRODUCT = 2810 ] ; then
		check_text $test_log_path".get"  '["vga","hdmi",]'
	fi
}
##
#	\���ܱ�� 	DMB1820-TS-WEB-001-F17
# \����˵��	�ն˰汾��ȡ
#	\��������	����getverinfo.cgi��ȡ�ն˵�ǰ�汾��Ϣ
#	\��֤��		��ȡ�汾���ն˳���汾���ļ�ϵͳ�汾����ͬ
##
_test_case_getverinfo()
{
	curl_get "getverinfo.cgi"
	test_log_path="`cat $TEST_LOG_PATH/test.info | awk -F= '$1~/logs_path/  {print $2}'`"_"`cat $TEST_LOG_PATH/test.info | awk -F= '$1~/case_name/  {print $2}'`"
	test_configver="`cat $test_log_path".get" | sed 's/,/\n/g' |  awk -F: -v tmpkey="configver"  ' $1==tmpkey {print $2} ' |  sed 's/"//g'`"
	test_dmbver="`cat $test_log_path".get" | sed 's/,/\n/g' |  awk -F: -v tmpkey="dmbver"  ' $1==tmpkey {print $2} ' |  sed 's/"//g'`"
	test_flashutilsver="`cat $test_log_path".get" | sed 's/,/\n/g' |  awk -F: -v tmpkey="flashutilsver"  ' $1==tmpkey {print $2} ' |  sed 's/"//g'`"
	test_kernelver="`cat $test_log_path".get" | sed 's/,/\n/g' |  awk -F: -v tmpkey="kernelver"  ' $1==tmpkey {print $2} ' |  sed 's/"//g'`"
	test_rootfsver="`cat $test_log_path".get" | sed 's/,/\n/g' |  awk -F: -v tmpkey="rootfsver"  ' $1==tmpkey {print $2} ' |  sed 's/"//g'`"
	
	
	check_text  /tmp/dmb/version  $test_dmbver
	check_text  /version  $test_rootfsver
  check_text  /tmp/flashutils/version  $test_flashutilsver
	check_text  /tmp/config/version  $test_configver
	
	test_kernel_verson="`uname -a | awk '{print $3}'`"
	cmp_vale $test_kernel_verson $test_kernelver
}
##
#	\���ܱ�� 	DMB1820-TS-WEB-001-F5
# \����˵��	WIFI����
#	\��������	����wificonfig.cgi�ļ��������������WIFI��������
#	\��֤��		dmb_wifi.ini���������Ƿ���ȷ�޸�
##
_test_case_setipconfig()
{
	curl_set "wificonfig.cgi"  'ipaddress=192.168.99.2&netmask=255.255.255.0&gateway=192.168.99.1&essid=test&key=test&encrotype=1&enablewifi=1&submit=Save'
	check_config_value $CONFIG_PATH/dmb_wifi.ini  static_ip 		 "192.168.99.2"	
	check_config_value $CONFIG_PATH/dmb_wifi.ini  static_netmask 		 "255.255.255.0"	
	check_config_value $CONFIG_PATH/dmb_wifi.ini  static_gateway 		 "192.168.99.1"	
	check_config_value $CONFIG_PATH/dmb_wifi.ini  wifi_essid 		 "test"	
	check_config_value $CONFIG_PATH/dmb_wifi.ini  wifi_key 		 "test"	
	check_config_value $CONFIG_PATH/dmb_wifi.ini  wifi_encro_type 		 "1"	
	check_config_value $CONFIG_PATH/dmb_wifi.ini  start_wifi 		 "1"	
}
##
#	\���ܱ�� 	DMB1820-TS-WEB-001-F5
# \����˵��	WIFI���û�ȡ
#	\��������	����getwificonfig.cgi�ļ���ȡWIFI��������
#	\��֤��		��ȡ�����ݸ�dmb_wifi.ini�����������
##
_test_case_getwificonfig()
{
	curl_get "getwificonfig.cgi"

	check_curl_get_result $CONFIG_PATH/dmb_wifi.ini dhcp 		enabledhcp
	check_curl_get_result $CONFIG_PATH/dmb_wifi.ini static_ip 		ipaddress
	check_curl_get_result $CONFIG_PATH/dmb_wifi.ini static_netmask 		netmask
	check_curl_get_result $CONFIG_PATH/dmb_wifi.ini static_gateway 		gateway
	check_curl_get_result $CONFIG_PATH/dmb_wifi.ini wifi_essid 		essid
	check_curl_get_result $CONFIG_PATH/dmb_wifi.ini wifi_key 		key
	check_curl_get_result $CONFIG_PATH/dmb_wifi.ini wifi_encro_type 		encrotype
	check_curl_get_result $CONFIG_PATH/dmb_wifi.ini start_wifi 		enablewifi
}
##
#	\���ܱ�� 	DMB1820-TS-WEB-001-F7
# \����˵��	DNS����
#	\��������	����dnsconfig.cgi�����������dns
#	\��֤��		resolv.conf�ļ�����Ϊ�����õ�ֵ
##
_test_case_dnsconfig()
{
	curl_set "dnsconfig.cgi"  'ip=110.90.119.99&submit=Save'
	check_text  $CONFIG_PATH/resolv.conf   "nameserver 110.90.119.99"
}
##
#	\���ܱ�� 	DMB1820-TS-WEB-001-F7
# \����˵��	DNS���û�ȡ
#	\��������	����getdnsconfig.cgi��ȡdns����
#	\��֤��		��ȡ���ݸ�resolv.conf�ļ��������
##
_test_case_getdnsconfig()
{
	curl_get "getdnsconfig.cgi"
	test_log_path="`cat $TEST_LOG_PATH/test.info | awk -F= '$1~/logs_path/  {print $2}'`"_"`cat $TEST_LOG_PATH/test.info | awk -F= '$1~/case_name/  {print $2}'`"
	test_ip="`cat $test_log_path".get" | sed 's/,/\n/g' |  awk -F: -v tmpkey="ip"  ' $1==tmpkey {print $2} ' |  sed 's/"//g'`"
	check_text  $CONFIG_PATH/resolv.conf   "nameserver $test_ip"
}
##
#	\���ܱ�� 	DMB1820-TS-WEB-001-F10
# \����˵��	�ն˵�½�����޸�
#	\��������	����loginpwchange.cgi������������ն˵�½����
#	\��֤��		dmb_system.ini�ж�Ӧ������ȷ�޸�
##
_test_case_loginpwchange()
{
	set_config_ini_value $CONFIG_PATH/dmb_system.ini "pwd" 		"123456"  
	curl_set "loginpwchange.cgi"  'passwordold=123456&passwordnew=1234567a&repassword=1234567a&submit=Save'
	check_config_value $CONFIG_PATH/dmb_system.ini  pwd 		 "fe008700f25cb28940ca8ed91b23b354"	
}
##
#	\���ܱ�� 	DMB1820-TS-WEB-001-F10
# \����˵��	��ȡ�ն˵�½����
#	\��������	����getloginpw.cgi��ȡ�ն˵�½����
#	\��֤��		��ȡ����Ϣ��dmb_system.ini�ж�Ӧ�������
##
_test_case_getloginpw()
{
	curl_get "getloginpw.cgi"
	check_curl_get_result $CONFIG_PATH/dmb_system.ini pwd usrpwmd5  
}
##
#	\���ܱ�� 	DMB1820-TS-WEB-001-F10
# \����˵��	����ն˵�½����
#	\��������	����loginpwreset.cgi��յ�½����
#	\��֤��		dmb_system.ini�ж�Ӧ�������
##
_test_case_loginpwreset()
{
	set_config_ini_value $CONFIG_PATH/dmb_system.ini "pwd" 		"123456"  
	curl_get "loginpwreset.cgi"
	check_config_value $CONFIG_PATH/dmb_system.ini  pwd 		 ""	
}
##
#	\���ܱ�� 	DMB1820-TS-WEB-001-F10
# \����˵��	�ն����������޸�
#	\��������	����pwchange.cgi�޸��ն���������
#	\��֤��		dmb.passwd���ݺ������������
##
_test_case_pwchange()
{
	curl_set "pwchange.cgi"  'username=admin&passwordold=&passwordnew=1234567a&repassword=1234567a&submit=Save'
	check_text  $CONFIG_PATH/dmb.passwd   "admin:fe008700f25cb28940ca8ed91b23b354"
	echo "admin:" > $CONFIG_PATH/dmb.passwd 
}
##
#	\���ܱ�� 	DMB1820-TS-WEB-001-F10
# \����˵��	�ն����������ȡ
#	\��������	����getconfigpw.cgi��ȡ�ն���������
#	\��֤��		��ȡ�����ݺ�dmb.passwd�������
##
_test_case_getconfigpw()
{
	echo "admin:fe008700f25cb28940ca8ed91b23b354" > $CONFIG_PATH/dmb.passwd 
	TEST_BOA_PWD="admin:fe008700f25cb28940ca8ed91b23b354"
	curl_get "getconfigpw.cgi"
	test_log_path="`cat $TEST_LOG_PATH/test.info | awk -F= '$1~/logs_path/  {print $2}'`"_"`cat $TEST_LOG_PATH/test.info | awk -F= '$1~/case_name/  {print $2}'`"
	test_username="`cat $test_log_path".get" | sed 's/,/\n/g' |  awk -F: -v tmpkey="username"  ' $1==tmpkey {print $2} ' |  sed 's/"//g'`"
	test_usrpwmd5="`cat $test_log_path".get" | sed 's/,/\n/g' |  awk -F: -v tmpkey="usrpwmd5"  ' $1==tmpkey {print $2} ' |  sed 's/"//g'`"
	check_text  $CONFIG_PATH/dmb.passwd  "$test_username":"$test_usrpwmd5"
	echo "admin:" > $CONFIG_PATH/dmb.passwd 
	TEST_BOA_PWD="admin:"
}
##
#	\���ܱ�� 	DMB1820-TS-WEB-001-F4
# \����˵��	�ն��޸�3G����
#	\��������	����3gconfig.cgi�����������3G��Ϣ
#	\��֤��		���õ����ݺ�dmb_3g.ini�����
##
_test_case_3gconfig()
{
	curl_set "3gconfig.cgi"  'type3G=7&status=1&modulation=1&port=4&cmd=1&baud=38400&vendor=19d2&accessPoint=123456&dialnum=12345678&userName=name&password=pwd&pdpip=192.168.11.1&pdptype=PPP&netmode=1&submit=Save'
	check_config_value $CONFIG_PATH/dmb_3g.ini  3g_type 		7	
	check_config_value $CONFIG_PATH/dmb_3g.ini  start_3g 		1
	check_config_value $CONFIG_PATH/dmb_3g.ini  3g_system 	1	
	check_config_value $CONFIG_PATH/dmb_3g.ini  port_num 		4
	check_config_value $CONFIG_PATH/dmb_3g.ini  port_cmd 		1
	check_config_value $CONFIG_PATH/dmb_3g.ini  baud_rate 	38400	
	check_config_value $CONFIG_PATH/dmb_3g.ini  3g_vid 		19d2
#	check_config_value $CONFIG_PATH/dmb_3g.ini  3g_pid 		0094
	check_config_value $CONFIG_PATH/dmb_3g.ini  3g_apn 		123456
	check_config_value $CONFIG_PATH/dmb_3g.ini  dail_num 		12345678	
	check_config_value $CONFIG_PATH/dmb_3g.ini  user_name 		name	
	check_config_value $CONFIG_PATH/dmb_3g.ini  pass_word 		pwd	
	check_config_value $CONFIG_PATH/dmb_3g.ini  pdp_addr 		192.168.11.1	
	check_config_value $CONFIG_PATH/dmb_3g.ini  pdp_type 		PPP	
	check_config_value $CONFIG_PATH/dmb_3g.ini  net_mode 		1	
}
##
#	\���ܱ�� 	DMB1820-TS-WEB-001-F4
# \����˵��	�ն˻�ȡ3G����
#	\��������	����get3gconfig.cgi��ȡ3G����
#	\��֤��		��ȡ����Ϣ��dmb_3g.ini�����
##
_test_case_get3gconfig()
{
	curl_get "get3gconfig.cgi"
	check_curl_get_result $CONFIG_PATH/dmb_3g.ini  3g_type 		type3G	
	check_curl_get_result $CONFIG_PATH/dmb_3g.ini  start_3g 		status	
	check_curl_get_result $CONFIG_PATH/dmb_3g.ini  3g_system 		modulation	
	check_curl_get_result $CONFIG_PATH/dmb_3g.ini  port_num 		port	
	check_curl_get_result $CONFIG_PATH/dmb_3g.ini  port_cmd 		cmd_port	
	check_curl_get_result $CONFIG_PATH/dmb_3g.ini  baud_rate 		baud	
	check_curl_get_result $CONFIG_PATH/dmb_3g.ini  3g_apn 		accessPoint	
	check_curl_get_result $CONFIG_PATH/dmb_3g.ini  dail_num 		dialnum	
	check_curl_get_result $CONFIG_PATH/dmb_3g.ini  user_name 		userName	
	check_curl_get_result $CONFIG_PATH/dmb_3g.ini  pass_word 		password	
	check_curl_get_result $CONFIG_PATH/dmb_3g.ini  pdp_addr 		pdpip	
	check_curl_get_result $CONFIG_PATH/dmb_3g.ini  pdp_type 		pdptype	
	check_curl_get_result $CONFIG_PATH/dmb_3g.ini  net_mode 		netmode	
	
	test_log_path="`cat $TEST_LOG_PATH/test.info | awk -F= '$1~/logs_path/  {print $2}'`"_"`cat $TEST_LOG_PATH/test.info | awk -F= '$1~/case_name/  {print $2}'`"
	test_vendor="`cat $test_log_path".get" | sed 's/,/\n/g' |  awk -F: -v tmpkey="vendor"  ' $1==tmpkey {print $2} ' |  sed 's/"//g'`"
	test_3g_vid="`echo $test_vendor | awk -F. '{print $1}'`"
	test_3g_pid="`echo $test_vendor | awk -F. '{print $2}'`"
	check_config_value $CONFIG_PATH/dmb_3g.ini  3g_vid 		$test_3g_vid
	check_config_value $CONFIG_PATH/dmb_3g.ini  3g_pid 		$test_3g_pid
}
##
#	\���ܱ�� 	DMB1820-TS-WEB-001-F2
# \����˵��	boa�����ն���־
#	\��������	�����ն˳�����־
#	\��֤��		���ص���־���ն�/root/dmb/log/�ж�Ӧ�����ļ���ͬ
##
_test_case_getdmblog()
{
	test_log_path="`cat $TEST_LOG_PATH/test.info | awk -F= '$1~/logs_path/  {print $2}'`"

	$LOCAL_CURL_PATH  -u$TEST_BOA_PWD  $TEST_LOCAL_IP/log/dmb_log.1 -o "$test_log_path".download1
	$LOCAL_CURL_PATH  -u$TEST_BOA_PWD  $TEST_LOCAL_IP/log/dmb_log.2 -o "$test_log_path".download2
	$LOCAL_CURL_PATH  -u$TEST_BOA_PWD  $TEST_LOCAL_IP/log/dmb_log.3 -o "$test_log_path".download3
	file_md5_compare $DMB_LOG_PATH/$LOG_NAME.1  "$test_log_path".download1
	file_md5_compare $DMB_LOG_PATH/$LOG_NAME.2  "$test_log_path".download2
	file_md5_compare $DMB_LOG_PATH/$LOG_NAME.3  "$test_log_path".download3
	
	$LOCAL_CURL_PATH  -u$TEST_BOA_PWD  $TEST_LOCAL_IP/log/playlog.xml -o "$test_log_path".download_playlog
	file_md5_compare $DMB_LOG_PATH/play_log.xml  "$test_log_path".download_playlog
	
	$LOCAL_CURL_PATH  -u$TEST_BOA_PWD  $TEST_LOCAL_IP/log/led_log.0 -o "$test_log_path".download_led0
	$LOCAL_CURL_PATH  -u$TEST_BOA_PWD  $TEST_LOCAL_IP/log/led_log.1 -o "$test_log_path".download_led1
	$LOCAL_CURL_PATH  -u$TEST_BOA_PWD  $TEST_LOCAL_IP/log/led_log.2 -o "$test_log_path".download_led2
	file_md5_compare $DMB_LOG_PATH/led_log.0  "$test_log_path".download_led0
	file_md5_compare $DMB_LOG_PATH/led_log.1  "$test_log_path".download_led1
	file_md5_compare $DMB_LOG_PATH/led_log.2  "$test_log_path".download_led2
	
	$LOCAL_CURL_PATH  -u$TEST_BOA_PWD  $TEST_LOCAL_IP/playlist/playlist.xml.old -o "$test_log_path".download_playlist
	file_md5_compare /root/dmb/playlist/playlist.xml.old  "$test_log_path".download_playlist
	$LOCAL_CURL_PATH  -u$TEST_BOA_PWD  $TEST_LOCAL_IP/playlist/realtime.xml.new -o "$test_log_path".download_realtime
	file_md5_compare /root/dmb/playlist/realtime.xml.new  "$test_log_path".download_realtime
}
##
#	\���ܱ�� 	DMB1820-TS-WEB-001-F8
# \����˵��	�ն˷���������
#	\��������	����serverconfig.cgi������������ն˷���������
#	\��֤��		dmb_server.ini�����ܹ���ȷ�޸�
##
_test_case_serverconfig()
{
	curl_set "serverconfig.cgi"  'serverip=192.168.100.100&port=60002&pcrt=60003&boxno=12345678&submit=Save'
	check_config_value $CONFIG_PATH/dmb_server.ini ip			192.168.100.100
	check_config_value $CONFIG_PATH/dmb_server.ini port		60002
	check_config_value $CONFIG_PATH/dmb_server.ini pcrt		60003
	check_config_value $CONFIG_PATH/dmb_server.ini boxno	12345678
}
##
#	\���ܱ�� 	DMB1820-TS-WEB-001-F8
# \����˵��	�ն˷��������û�ȡ
#	\��������	����getserverconfig.cgi��ȡ�ն˷���������
#	\��֤��		��ȡ���ݺ�dmb_server.ini�������
##
_test_case_getserverconfig()
{
	curl_get "getserverconfig.cgi"
	check_curl_get_result $CONFIG_PATH/dmb_server.ini  ip  serverip
	check_curl_get_result $CONFIG_PATH/dmb_server.ini  port  port
	check_curl_get_result $CONFIG_PATH/dmb_server.ini  pcrt  pcrt
	check_curl_get_result $CONFIG_PATH/dmb_server.ini  boxno  boxno
}
##
#	\���ܱ�� 	DMB1820-TS-WEB-001-F6
# \����˵��	�ն˴�������
#	\��������	����proxyconfig.cgi������������ն˴���
#	\��֤��		dmb_proxy.ini�����ܹ���ȷ�޸�
##
_test_case_proxyconfig()
{
	curl_set "proxyconfig.cgi"  'tempuse=0&temptest=0&submit=Save'
	check_config_value $CONFIG_PATH/dmb_proxy.ini  proxy_switch    0
	check_config_value $CONFIG_PATH/dmb_proxy.ini  auth   0
	curl_set "proxyconfig.cgi"  'tempuse=2&dailitype=2&dailiip=192.168.69.145&dailiport=1080&temptest=1&usrname=user&dalipw=123&submit=Save'
	check_config_value $CONFIG_PATH/dmb_proxy.ini  proxy_switch    2
	check_config_value $CONFIG_PATH/dmb_proxy.ini  proxy_server_ip  192.168.69.145
	check_config_value $CONFIG_PATH/dmb_proxy.ini  proxy_server_port   1080
	check_config_value $CONFIG_PATH/dmb_proxy.ini  auth   1
	check_config_value $CONFIG_PATH/dmb_proxy.ini  username  user
	check_config_value $CONFIG_PATH/dmb_proxy.ini  password  123
}
##
#	\���ܱ�� 	DMB1820-TS-WEB-001-F6
# \����˵��	�ն˴������û�ȡ
#	\��������	����getproxyconfig.cgi��ȡ�ն˴������
#	\��֤��		��ȡ���ݺ�dmb_proxy.ini�������
##
_test_case_getproxyconfig()
{
	curl_get "getproxyconfig.cgi"
	check_curl_get_result $CONFIG_PATH/dmb_proxy.ini  proxy_switch   proxytype
	check_curl_get_result $CONFIG_PATH/dmb_proxy.ini  proxy_server_ip   proxyip
	check_curl_get_result $CONFIG_PATH/dmb_proxy.ini  proxy_server_port   proxyport
	check_curl_get_result $CONFIG_PATH/dmb_proxy.ini  auth   opentest
	check_curl_get_result $CONFIG_PATH/dmb_proxy.ini  username  usrname
	check_curl_get_result $CONFIG_PATH/dmb_proxy.ini  password  password
}
##
#	\���ܱ�� 	�����ޣ�
# \����˵��	�ն�ssl����
#	\��������	����sslconfig.cgi�����ն�������Ϣ����
#	\��֤��		dmb_ssl.ini�ļ��������ܹ���Ӧ�޸�
##
_test_case_sslconfig()
{
	curl_set "sslconfig.cgi"  'enablessl=1&submit=Save'
	check_config_value $CONFIG_PATH/dmb_ssl.ini  ssl_switch    1
}
##
#	\���ܱ�� 	�����ޣ�
# \����˵��	��ȡ�ն�ssl����
#	\��������	����getsslconfig.cgi��ȡ�ն�������Ϣ����
#	\��֤��		��ȡ���ݸ�dmb_ssl.ini�ļ����������
##
_test_case_getsslconfig()
{
	curl_get "getsslconfig.cgi"
	check_curl_get_result $CONFIG_PATH/dmb_ssl.ini  ssl_switch   enablessl

}
