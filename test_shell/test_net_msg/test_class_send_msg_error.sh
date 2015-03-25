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
	
	rm /root/dmb/download/*
	rm /root/dmb/playlist/*
}

before_case()
{
	echo -before_case
	rm $SERVER_XML_PATH/loop_xml/*
	rm /root/dmb/download/*
	rm /root/dmb/playlist/*
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
_test_case_downloadtime_data_error()
{
	send_msg_and_wiat "downloadtime_data_error.xml"  
	file_md5_compare /tmp/config/system/ftp.conf     $TEST_XML_DIR/$xml_name
	
}