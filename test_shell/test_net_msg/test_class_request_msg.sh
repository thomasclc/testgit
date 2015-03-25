#!/bin/sh
before_class()
{
	killall -9 dmb_main
	killall -9 dmb_server
	rm $DMB_LOG_PATH/*
	rm $SERVER_XML_PATH/xml/loop_xml/*
	rm /root/dmb/download/*
	rm /root/dmb/playlist/*
#保存原始配置并还原为默认配置
	rm -rf  /tmp/system.bak
	cp -rf  /tmp/config/system  /tmp/system.bak
	cp defaule_config/* /tmp/config/system/
	chmod 777 /tmp/config/system/*
	
	dmb_ip=`ifconfig | grep "inet addr:" | grep -v  127.0.0.1 | awk -F: '{print $2}' | awk '{print $1}'` 
	set_config_ini_value "/tmp/config/system/dmb_server.ini" "ip"  "$dmb_ip"
	
	sync
	
	
#server消息拷贝至发送目录
	cp $TEST_XML_DIR/ledplaylist.xml  /tmp/dmb/program/dmb_server/xml/
	cp $TEST_XML_DIR/ftp.xml  				/tmp/dmb/program/dmb_server/xml/
	cp $TEST_XML_DIR/downloadtime.xml /tmp/dmb/program/dmb_server/xml/
	cp $TEST_XML_DIR/font.xml  				/tmp/dmb/program/dmb_server/xml/
	cp $TEST_XML_DIR/playlist.xml 	  /tmp/dmb/program/dmb_server/xml/
	cp $TEST_XML_DIR/weather.xml 		  /tmp/dmb/program/dmb_server/xml/
	cp $TEST_XML_DIR/realtime_data.xml  /tmp/dmb/program/dmb_server/xml/

#启动测试程序
	debug "start dmb_main"
	cd $DMB_PATH
	./dmb_load_drv
	./dmb_main -k $DMB_PATH/key_value -dusb &
	cd -
	debug "start dmb_server"
	cd $SERVER_PATH
	./dmb_server -s&
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
	
	#还原目录，清空SD卡对应目录
	rm -rf /tmp/config/system/*
	cp /tmp/system.bak/* /tmp/config/system/
	rm -rf /tmp/system.bak
	
	rm /root/dmb/download/*
	rm /root/dmb/playlist/*
}

before_case()
{
	echo -before_case
	rm $SERVER_XML_PATH/xml/loop_xml/*
}

after_case()
{
	echo -after_case
	rm $SERVER_XML_PATH/xml/loop_xml/*
}

_test_case_request_wait_effect()
{
	sleep 20
}
_test_case_request_ftp()
{
	file_md5_compare /tmp/config/system/ftp.conf     $TEST_XML_DIR/ftp.xml 
}
_test_case_request_font()
{
	file_md5_compare /root/dmb/playlist/fontfile.xml.new     $TEST_XML_DIR/font.xml  	
	file_md5_compare /root/dmb/playlist/fontfile.xml.old     $TEST_XML_DIR/font.xml  	
}
_test_case_request_realtime()
{
	file_md5_compare /root/dmb/playlist/realtime.xml.new     $TEST_XML_DIR/realtime_data.xml
	file_md5_compare /root/dmb/playlist/realtime.xml.old     $TEST_XML_DIR/realtime_data.xml
}
_test_case_request_playlist()
{
	file_md5_compare /root/dmb/playlist/playlist.xml.new     $TEST_XML_DIR/playlist.xml 
	file_md5_compare /root/dmb/playlist/playlist.xml.old     $TEST_XML_DIR/playlist.xml 
}
_test_case_request_ledplaylist()
{
	file_md5_compare /root/dmb/playlist/ledplaylist.xml.new     $TEST_XML_DIR/ledplaylist.xml
	file_md5_compare /root/dmb/playlist/ledplaylist.xml.old     $TEST_XML_DIR/ledplaylist.xml
}
_test_case_request_weather()
{
	file_md5_compare /root/dmb/playlist/weather.xml.old     $TEST_XML_DIR/weather.xml 	
	file_md5_compare /root/dmb/playlist/weather.xml.new     $TEST_XML_DIR/weather.xml 	
}
_test_case_request_downloadtime()
{
	file_md5_compare /root/dmb/download/downloadtime.xml     $TEST_XML_DIR/downloadtime.xml 
}
