#!/bin/sh
before_class()
{
	killall -9 dmb_main
	killall -9 dmb_server
	rm $DMB_LOG_PATH/*
	rm $SERVER_XML_PATH/loop_xml/*
	rm /root/dmb/download/*
	rm /root/dmb/playlist/*
#����ԭʼ���ò���ԭΪĬ������
	rm -rf  /tmp/system.bak
	cp -rf  $CONFIG_PATH  /tmp/system.bak
	cp defaule_config/* $CONFIG_PATH
	chmod 777 $CONFIG_PATH/*
	
	set_config_ini_value "$CONFIG_PATH/dmb_server.ini" "ip"  "$TEST_LOCAL_IP"
	
	sync
	
#�������Գ���	
	debug "start dmb_main"
	cd $DMB_PATH
	./dmb_load_drv
	./dmb_main -q -k $DMB_PATH/key_value -dusb &
	cd -
	debug "start dmb_server"
	cd $SERVER_PATH
	./dmb_server -s &
	cd -
	debug "wait 10s for start the funtion ..."
	sleep 10
}

after_class()
{
	
	killall -9 dmb_main
	killall -9 dmb_server
	test_log_path="`cat $TEST_LOG_PATH/test.info | awk -F= '$1~/logs_path/  {print $2}'`"
	cat  $DMB_LOG_PATH/$LOG_NAME.* > $test_log_path".log"
	
	#��ԭĿ¼�����SD����ӦĿ¼
	rm -rf $CONFIG_PATH/*
	cp /tmp/system.bak/* $CONFIG_PATH
	rm -rf /tmp/system.bak
	
#	rm /root/dmb/download/*
	rm /root/dmb/playlist/*
}

before_case()
{
	echo -before_case
	rm $SERVER_XML_PATH/loop_xml/*
}

after_case()
{
	echo -after_case
	rm $SERVER_XML_PATH/loop_xml/*
#	rm $SERVER_XML_PATH/../msg/*
}
##
#	\���ܱ�� 	DMB1820-TS-TM-001-F23
# \����˵��	�ն˵�½ƽ̨��ȡ��Ȩ��Ϣ
#	\��������	�ն˳ɹ���½ƽ̨��
#	\��֤��		dmb_system.ini�ļ��ܹ���������
##
_test_case_licinfo()
{
	sleep 5
	check_config_value /tmp/config/system/dmb_system.ini  "licinfo"  '[v1]cnWSb3hxv8IOFMX3THGR8MIrTyndUMOL'
}
##
#	\���ܱ�� 	�����ޣ�
# \����˵��	�ն˴�ƽ̨��ȡftp��ַ
#	\��������	�·�ftp��Ϣ���ն�
#	\��֤��		ftp.conf �ļ��ܹ���������
##
_test_case_ftp()
{
	send_msg_and_wiat "ftp.xml"  
	file_md5_compare /tmp/config/system/ftp.conf     $TEST_XML_DIR/$xml_name
	
}
##
#	\���ܱ�� 	DMB1820-TS-PC-001-F23
# \����˵��	�ն˴�ƽ̨��ȡ������Ϣ
#	\��������	�·�������Ϣ���ն�
#	\��֤��		fontfile.xml�ļ��ܹ���������
##
_test_case_font()
{
	send_msg_and_wiat "font.xml"  
	file_md5_compare /root/dmb/playlist/fontfile.xml.new     $TEST_XML_DIR/$xml_name
	file_md5_compare /root/dmb/playlist/fontfile.xml.old     $TEST_XML_DIR/$xml_name
	
}
##
#	\���ܱ�� 	DMB1820-TS-TM-001-F12
# \����˵��	ƽ̨�����ն�ʱ��
#	\��������	�·�ʱ����Ϣ���ն�
#	\��֤��		TZ�ļ��ܹ���������
##
_test_case_timezone()
{
	send_msg_and_wiat "timezone.xml" 
	check_text $CONFIG_PATH/TZ  "UTC-09:00" 
	
}
##
#	\���ܱ�� 	DMB1820-TS-PC-001-F27
# \����˵��	ƽ̨�·�ʵʱ������Ϣ
#	\��������	�·�ʵʱ������Ϣ���ն�
#	\��֤��		realtime.xml�ļ��ܹ���������
##
_test_case_realtime()
{
	send_msg_and_wiat "realtime_data.xml" 
	file_md5_compare /root/dmb/playlist/realtime.xml.new     $TEST_XML_DIR/$xml_name
	file_md5_compare /root/dmb/playlist/realtime.xml.old     $TEST_XML_DIR/$xml_name	
	
}
##
#	\���ܱ�� 	DMB1820-TS-PC-001-F1
# \����˵��	ƽ̨�·������б�
#	\��������	�·������б���ն�
#	\��֤��		playlist.xml�ļ��ܹ���������
##
_test_case_playlist()
{
	send_msg_and_wiat "playlist.xml" 
	file_md5_compare /root/dmb/playlist/playlist.xml.new     $TEST_XML_DIR/$xml_name
	file_md5_compare /root/dmb/playlist/playlist.xml.old     $TEST_XML_DIR/$xml_name
	
}
##
#	\���ܱ�� 	DMB1820-TS-DM-001-F1
# \����˵��	ƽ̨�·�LED�����б�
#	\��������	�·�LED�����б���ն�
#	\��֤��		ledplaylist.xml�ļ��ܹ���������
##
_test_case_ledplaylist()
{
	send_msg_and_wiat "ledplaylist.xml" 
	file_md5_compare /root/dmb/playlist/ledplaylist.xml.new     $TEST_XML_DIR/$xml_name
	file_md5_compare /root/dmb/playlist/ledplaylist.xml.old     $TEST_XML_DIR/$xml_name
}
##
#	\���ܱ�� 	DMB1820-TS-TM-001-F11
# \����˵��	ƽ̨�·�Ԥ������Ϣ
#	\��������	�·�Ԥ������Ϣ���ն�
#	\��֤��		predownload.xml�ļ��ܹ���������
##
_test_case_predownload()
{
	send_msg_and_wiat "predownload.xml" 
	file_md5_compare /root/dmb/playlist/predownload.xml.new     $TEST_XML_DIR/$xml_name
	file_md5_compare /root/dmb/playlist/predownload.xml.old     $TEST_XML_DIR/$xml_name

}
##
#	\���ܱ�� 	DMB1820-TS-TM-001-F22
# \����˵��	ƽ̨�������ն���������
#	\��������	�·�����������Ϣ���ն�
#	\��֤��		dmb.passwd �ļ��ܹ���������
##
_test_case_setpwd()
{
	send_msg_and_wiat "setpwd.xml"
	check_text $CONFIG_PATH/dmb.passwd  "admin:1234567a" 
	
}
##
#	\���ܱ�� 	DMB1820-TS-TM-001-F8
# \����˵��	ƽ̨�����ն˷�ʱ����
#	\��������	�·�������Ϣ���ն�
#	\��֤��		volume.xml�ļ��ܹ���������
##
_test_case_volume()
{
	send_msg_and_wiat "volume.xml" 
	file_md5_compare /root/dmb/download/volume.xml     $TEST_XML_DIR/$xml_name
}
##
#	\���ܱ�� 	�����ޣ�
# \����˵��	ƽ̨�·��ն�������Ϣ
#	\��������	�·�������Ϣ���ն�
#	\��֤��		weather.xml�ļ��ܹ���������
##
_test_case_weather()
{
	send_msg_and_wiat "weather.xml" 
	file_md5_compare /root/dmb/playlist/weather.xml.old     $TEST_XML_DIR/$xml_name
	file_md5_compare /root/dmb/playlist/weather.xml.new     $TEST_XML_DIR/$xml_name
}
##
#	\���ܱ�� 	DMB1820-TS-TM-001-F21
# \����˵��	ƽ̨�����ն�ʱ��ͬ��
#	\��������	�·�ntpͬ����Ϣ���ն�
#	\��֤��		�����ޣ�
##
_test_case_worktime()
{
	send_msg_and_wiat "ntp.xml" 
}
##
#	\���ܱ�� 	DMB1820-TS-TM-001-F9
# \����˵��	ƽ̨�����ն˹���ʱ��
#	\��������	�·�����ʱ����ն�
#	\��֤��		worktime.xml�ļ��ܹ���������
##
_test_case_worktime()
{
	send_msg_and_wiat "worktime.xml" 
	file_md5_compare /root/dmb/download/worktime.xml    $TEST_XML_DIR/$xml_name

}
##
#	\���ܱ�� 	DMB1820-TS-TM-001-F13
# \����˵��	ƽ̨�����ն�3G����
#	\��������	�·�3G���ø��ն�
#	\��֤��		dialtime.xml�ļ��ܹ���������
##
_test_case_dialtime()
{
	send_msg_and_wiat "dialtime.xml" 
	file_md5_compare /root/dmb/download/dialtime.xml     $TEST_XML_DIR/$xml_name
}
##
#	\���ܱ�� 	DMB1820-TS-TM-001-F10
# \����˵��	ƽ̨�����ն�����ʱ��
#	\��������	�·�����ʱ�����ø��ն�
#	\��֤��		downloadtime.xml�ļ��ܹ���������
##
_test_case_downloadtime()
{
	send_msg_and_wiat "downloadtime.xml" 
	file_md5_compare /root/dmb/download/downloadtime.xml    $TEST_XML_DIR/$xml_name

}
##
#	\���ܱ�� 	DMB1820-TS-TM-001-F15
# \����˵��	ƽ̨�����ն˷ǹ���ʱ��ж�ش���
#	\��������	�·��������ø��ն�
#	\��֤��		downloadtime.xml�ļ��ܹ���������
##
_test_case_diskumount()
{
	send_msg_and_wiat "diskumount.xml" 
	check_config_value /tmp/config/system/dmb_eth0.ini   "diskumount" "1"
	
}
##
#	\���ܱ�� 	DMB1820-TS-TM-001-F16
# \����˵��	ƽ̨�����ն�����
#	\��������	�·��������ø��ն�
#	\��֤��		dmb_output.ini�ļ��ܹ���������
##
_test_case_bright()
{
	send_msg_and_wiat "bright.xml" 	
	check_config_value /tmp/config/system/dmb_output.ini   "light" "144"
	
	
}
##
#	\���ܱ�� 	DMB1820-TS-TM-001-F17
# \����˵��	ƽ̨�����ն˶Աȶ�
#	\��������	�·��Աȶ����ø��ն�
#	\��֤��		dmb_output.ini�ļ��ܹ���������
##
_test_case_contrast()
{
	send_msg_and_wiat "contrast.xml" 	
	check_config_value /tmp/config/system/dmb_output.ini   "contrast" "160"
}
##
#	\���ܱ�� 	DMB1820-TS-TM-001-F18 DMB1820-TS-TM-001-F19
# \����˵��	ƽ̨�����ն����ģʽ
#	\��������	�·�������ø��ն�
#	\��֤��		dmb_output.ini�ļ��ܹ���������
##
_test_case_outputswitch()
{
	send_msg_and_wiat "outputswitch.xml" 	
	check_config_value /tmp/config/system/dmb_output.ini   "mode" "hdmi"
	check_config_value /tmp/config/system/dmb_output.ini   "width" "1920"
	check_config_value /tmp/config/system/dmb_output.ini   "height" "1080"
	
}
