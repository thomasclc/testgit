#!/bin/sh
before_class()
{
	killall -9 dmb_main
	killall -9 dmb_server
	rm $DMB_LOG_PATH/*
	rm $SERVER_XML_PATH/loop_xml/*
	rm /root/dmb/download/*
	rm /root/dmb/playlist/*
#保存原始配置并还原为默认配置
	rm -rf  /tmp/system.bak
	cp -rf  $CONFIG_PATH  /tmp/system.bak
	cp defaule_config/* $CONFIG_PATH
	chmod 777 $CONFIG_PATH/*
	
	set_config_ini_value "$CONFIG_PATH/dmb_server.ini" "ip"  "$TEST_LOCAL_IP"
	
	sync
	
#启动测试程序	
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
	
	#还原目录，清空SD卡对应目录
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
#	\功能编号 	DMB1820-TS-TM-001-F23
# \功能说明	终端登陆平台获取授权信息
#	\用例步骤	终端成功登陆平台后
#	\验证点		dmb_system.ini文件能够正常更新
##
_test_case_licinfo()
{
	sleep 5
	check_config_value /tmp/config/system/dmb_system.ini  "licinfo"  '[v1]cnWSb3hxv8IOFMX3THGR8MIrTyndUMOL'
}
##
#	\功能编号 	（暂无）
# \功能说明	终端从平台获取ftp地址
#	\用例步骤	下发ftp消息给终端
#	\验证点		ftp.conf 文件能够正常更新
##
_test_case_ftp()
{
	send_msg_and_wiat "ftp.xml"  
	file_md5_compare /tmp/config/system/ftp.conf     $TEST_XML_DIR/$xml_name
	
}
##
#	\功能编号 	DMB1820-TS-PC-001-F23
# \功能说明	终端从平台获取字体信息
#	\用例步骤	下发字体消息给终端
#	\验证点		fontfile.xml文件能够正常更新
##
_test_case_font()
{
	send_msg_and_wiat "font.xml"  
	file_md5_compare /root/dmb/playlist/fontfile.xml.new     $TEST_XML_DIR/$xml_name
	file_md5_compare /root/dmb/playlist/fontfile.xml.old     $TEST_XML_DIR/$xml_name
	
}
##
#	\功能编号 	DMB1820-TS-TM-001-F12
# \功能说明	平台设置终端时区
#	\用例步骤	下发时区消息给终端
#	\验证点		TZ文件能够正常更新
##
_test_case_timezone()
{
	send_msg_and_wiat "timezone.xml" 
	check_text $CONFIG_PATH/TZ  "UTC-09:00" 
	
}
##
#	\功能编号 	DMB1820-TS-PC-001-F27
# \功能说明	平台下发实时数据消息
#	\用例步骤	下发实时数据消息给终端
#	\验证点		realtime.xml文件能够正常更新
##
_test_case_realtime()
{
	send_msg_and_wiat "realtime_data.xml" 
	file_md5_compare /root/dmb/playlist/realtime.xml.new     $TEST_XML_DIR/$xml_name
	file_md5_compare /root/dmb/playlist/realtime.xml.old     $TEST_XML_DIR/$xml_name	
	
}
##
#	\功能编号 	DMB1820-TS-PC-001-F1
# \功能说明	平台下发播放列表
#	\用例步骤	下发播放列表给终端
#	\验证点		playlist.xml文件能够正常更新
##
_test_case_playlist()
{
	send_msg_and_wiat "playlist.xml" 
	file_md5_compare /root/dmb/playlist/playlist.xml.new     $TEST_XML_DIR/$xml_name
	file_md5_compare /root/dmb/playlist/playlist.xml.old     $TEST_XML_DIR/$xml_name
	
}
##
#	\功能编号 	DMB1820-TS-DM-001-F1
# \功能说明	平台下发LED播放列表
#	\用例步骤	下发LED播放列表给终端
#	\验证点		ledplaylist.xml文件能够正常更新
##
_test_case_ledplaylist()
{
	send_msg_and_wiat "ledplaylist.xml" 
	file_md5_compare /root/dmb/playlist/ledplaylist.xml.new     $TEST_XML_DIR/$xml_name
	file_md5_compare /root/dmb/playlist/ledplaylist.xml.old     $TEST_XML_DIR/$xml_name
}
##
#	\功能编号 	DMB1820-TS-TM-001-F11
# \功能说明	平台下发预下载消息
#	\用例步骤	下发预下载消息给终端
#	\验证点		predownload.xml文件能够正常更新
##
_test_case_predownload()
{
	send_msg_and_wiat "predownload.xml" 
	file_md5_compare /root/dmb/playlist/predownload.xml.new     $TEST_XML_DIR/$xml_name
	file_md5_compare /root/dmb/playlist/predownload.xml.old     $TEST_XML_DIR/$xml_name

}
##
#	\功能编号 	DMB1820-TS-TM-001-F22
# \功能说明	平台下设置终端配置密码
#	\用例步骤	下发配置密码消息给终端
#	\验证点		dmb.passwd 文件能够正常更新
##
_test_case_setpwd()
{
	send_msg_and_wiat "setpwd.xml"
	check_text $CONFIG_PATH/dmb.passwd  "admin:1234567a" 
	
}
##
#	\功能编号 	DMB1820-TS-TM-001-F8
# \功能说明	平台设置终端分时音量
#	\用例步骤	下发音量消息给终端
#	\验证点		volume.xml文件能够正常更新
##
_test_case_volume()
{
	send_msg_and_wiat "volume.xml" 
	file_md5_compare /root/dmb/download/volume.xml     $TEST_XML_DIR/$xml_name
}
##
#	\功能编号 	（暂无）
# \功能说明	平台下发终端天气信息
#	\用例步骤	下发天气消息给终端
#	\验证点		weather.xml文件能够正常更新
##
_test_case_weather()
{
	send_msg_and_wiat "weather.xml" 
	file_md5_compare /root/dmb/playlist/weather.xml.old     $TEST_XML_DIR/$xml_name
	file_md5_compare /root/dmb/playlist/weather.xml.new     $TEST_XML_DIR/$xml_name
}
##
#	\功能编号 	DMB1820-TS-TM-001-F21
# \功能说明	平台设置终端时间同步
#	\用例步骤	下发ntp同步消息给终端
#	\验证点		（暂无）
##
_test_case_worktime()
{
	send_msg_and_wiat "ntp.xml" 
}
##
#	\功能编号 	DMB1820-TS-TM-001-F9
# \功能说明	平台设置终端工作时间
#	\用例步骤	下发工作时间给终端
#	\验证点		worktime.xml文件能够正常更新
##
_test_case_worktime()
{
	send_msg_and_wiat "worktime.xml" 
	file_md5_compare /root/dmb/download/worktime.xml    $TEST_XML_DIR/$xml_name

}
##
#	\功能编号 	DMB1820-TS-TM-001-F13
# \功能说明	平台设置终端3G配置
#	\用例步骤	下发3G配置给终端
#	\验证点		dialtime.xml文件能够正常更新
##
_test_case_dialtime()
{
	send_msg_and_wiat "dialtime.xml" 
	file_md5_compare /root/dmb/download/dialtime.xml     $TEST_XML_DIR/$xml_name
}
##
#	\功能编号 	DMB1820-TS-TM-001-F10
# \功能说明	平台设置终端下载时间
#	\用例步骤	下发下载时间配置给终端
#	\验证点		downloadtime.xml文件能够正常更新
##
_test_case_downloadtime()
{
	send_msg_and_wiat "downloadtime.xml" 
	file_md5_compare /root/dmb/download/downloadtime.xml    $TEST_XML_DIR/$xml_name

}
##
#	\功能编号 	DMB1820-TS-TM-001-F15
# \功能说明	平台设置终端非工作时间卸载磁盘
#	\用例步骤	下发磁盘配置给终端
#	\验证点		downloadtime.xml文件能够正常更新
##
_test_case_diskumount()
{
	send_msg_and_wiat "diskumount.xml" 
	check_config_value /tmp/config/system/dmb_eth0.ini   "diskumount" "1"
	
}
##
#	\功能编号 	DMB1820-TS-TM-001-F16
# \功能说明	平台设置终端亮度
#	\用例步骤	下发亮度配置给终端
#	\验证点		dmb_output.ini文件能够正常更新
##
_test_case_bright()
{
	send_msg_and_wiat "bright.xml" 	
	check_config_value /tmp/config/system/dmb_output.ini   "light" "144"
	
	
}
##
#	\功能编号 	DMB1820-TS-TM-001-F17
# \功能说明	平台设置终端对比度
#	\用例步骤	下发对比度配置给终端
#	\验证点		dmb_output.ini文件能够正常更新
##
_test_case_contrast()
{
	send_msg_and_wiat "contrast.xml" 	
	check_config_value /tmp/config/system/dmb_output.ini   "contrast" "160"
}
##
#	\功能编号 	DMB1820-TS-TM-001-F18 DMB1820-TS-TM-001-F19
# \功能说明	平台设置终端输出模式
#	\用例步骤	下发输出配置给终端
#	\验证点		dmb_output.ini文件能够正常更新
##
_test_case_outputswitch()
{
	send_msg_and_wiat "outputswitch.xml" 	
	check_config_value /tmp/config/system/dmb_output.ini   "mode" "hdmi"
	check_config_value /tmp/config/system/dmb_output.ini   "width" "1920"
	check_config_value /tmp/config/system/dmb_output.ini   "height" "1080"
	
}
