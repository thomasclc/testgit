##
#  \file       test_class_play.sh
#  \brief      ���񲥷���ű����
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
	echo ---before_class
}

after_class()
{
	echo ---after_class
}
before_case()
{
	killall -9 dmb_main
	killall -9 dmb_server
	rm $DMB_LOG_PATH/*
	rm $SERVER_XML_PATH/xml/loop_xml/*
	rm /root/dmb/download/*
	rm /root/dmb/playlist/*
#����ԭʼ���ò���ԭΪĬ������
	rm -rf  /tmp/system.bak
	cp -rf  $CONFIG_PATH  /tmp/system.bak
	cp defaule_config/* $CONFIG_PATH
	chmod 777 $CONFIG_PATH/*
	set_config_ini_value "$CONFIG_PATH/dmb_server.ini" "ip"  "$TEST_LOCAL_IP"
	sync

	cp $TEST_PLAYLIST_DIR/ftp.xml  				/tmp/dmb/program/dmb_server/xml/
	cp $TEST_PLAYLIST_DIR/downloadtime.xml  				/tmp/dmb/program/dmb_server/xml/
#�������Գ���	
	debug "start dmb_main"
	cd $DMB_PATH
	./dmb_load_drv
	./dmb_main -qftp:downloadtime -k $DMB_PATH/key_value -dusb &
	cd -
	debug "start dmb_server"
	cd $SERVER_PATH
	./dmb_server &
	cd -
	debug "wait 10s for start the funtion ..."
	sleep 5
}

after_case()
{
	killall -9 dmb_main
	killall -9 dmb_server
	test_log_path="`cat $TEST_LOG_PATH/test.info | awk -F= '$1~/logs_path/  {print $2}'`"
	test_case_name="`cat $TEST_LOG_PATH/test.info | awk -F= '$1~/case_name/  {print $2}'`"
	cat  $DMB_LOG_PATH/$LOG_NAME.* > $test_log_path$test_case_name".log"
	
	#��ԭĿ¼�����SD����ӦĿ¼
	rm -rf $CONFIG_PATH/*
	cp /tmp/system.bak/* $CONFIG_PATH
	rm -rf /tmp/system.bak
	
	rm /root/dmb/download/*
	rm /root/dmb/playlist/*
}
##
#	\���ܱ�� 	DMB1820-TS-PC-001-F21  DMB1820-TS-PC-001-F15
# \����˵��	�ն˲��Ŷ������ڸ�ʽ  �ն˲�������˳��
#	\��������	�·����ʽ����ʱ�������նˣ�ʱ�䣺6�� ���ڣ�13�֣�   ˳�򲥷Ŷ�����
#	\��֤��		�ն���������
##
_test_case_play_date()
{
	send_playlist 	playlist_date.xml
	wait_for_dmb_log  "unit_s"
	sleep 80
}
##
#	\���ܱ�� 	DMB1820-TS-PC-001-F3
# \����˵��	�ն˲��Ŷ���ͼƬ��Ч
#	\��������	�·���ЧͼƬ���նˣ�18�֣�
#	\��֤��		�ն���������
##
_test_case_play_img()
{
	send_playlist 	playlist_img.xml
	wait_for_dmb_log  "unit_e"
}
##
#	\���ܱ�� 	DMB1820-TS-PC-001-F16
# \����˵��	�ն˲�����Ƶ����
#	\��������	�·���Ƶ�����ն�
#	\��֤��		�ն���������
##
_test_case_play_music()
{
	send_playlist 	playlist_music.xml
	wait_for_dmb_log  "unit_e"
}
##
#	\���ܱ�� 	DMB1820-TS-PC-001-F12
# \����˵��	�ն˲��Ŷ������ص�����
#	\��������	�·������ص������ն�
#	\��֤��		�ն���������
##
_test_case_play_overlap()
{
	send_playlist 	playlist_overlap.xml
	wait_for_dmb_log  "unit_e"
}
##
#	\���ܱ�� 	DMB1820-TS-PC-001-F2
# \����˵��	�ն˲��Ŷ������ȼ�����
#	\��������	�·��������ȼ����������ն�
#	\��֤��		�ն���������
##
_test_case_play_level()
{
	send_playlist 	playlist_task_level.xml
	wait_for_dmb_log  "unit_e"		
}
##
#	\���ܱ�� 	DMB1820-TS-PC-001-F2
# \����˵��	�ն�����Ӧ���������ֱ�������
#	\��������	�·����ն˵�ǰ�ֱ������������ն�
#	\��֤��		�ն���������
##
_test_case_play_1920_1080()
{
	send_playlist 	playlist_1920_1080.xml
	wait_for_dmb_log  "unit_e"		
}
##
#	\���ܱ�� 	DMB1820-TS-PC-001-F2
# \����˵��	�ն˲���avin����
#	\��������	�·�avin�����ն�
#	\��֤��		�ն���������
##
_test_case_play_avin()
{
	send_playlist 	playlist_avin.xml
	wait_for_dmb_log  "unit_e"		
}
##
#	\���ܱ�� 	DMB1820-TS-PC-001-F2
# \����˵��	�ն˲��Ų岥��Ļ
#	\��������	�·��岥��Ļ�����ն�
#	\��֤��		�ն���������
##
_test_case_play_insert_text()
{
	send_playlist 	playlist_insert_text.xml
	sleep 60	
}

_test_case_play_gif()
{
	send_playlist 	playlist_gif.xml
	wait_for_dmb_log  "unit_e"	
}

_test_case_play_movies()
{
	send_playlist 	playlist_movies.xml
	wait_for_dmb_log  "unit_e"
	
}

_test_case_play_oder()
{
	send_playlist 	playlist_oder.xml
	wait_for_dmb_log  "unit_e"	
	
}

_test_case_play_spots()
{
	send_playlist 	playlist_spots.xml
	wait_for_dmb_log  "unit_e"		
	
}

_test_case_play_level()
{
	send_playlist 	playlist_task_level.xml
	wait_for_dmb_log  "unit_e"		
	
}

_test_case_play_text()
{
	send_playlist 	playlist_text2.xml
	wait_for_dmb_log  "unit_e"		
	
}


_test_case_play()
{
	send_playlist test_realtime.xml
	
	send_playlist test_playlist.xml
	wait_for_dmb_log  "unit_e"		
	
}