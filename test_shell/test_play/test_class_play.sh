##
#  \file       test_class_play.sh
#  \brief      任务播放类脚本相关
#
#   Copyright (C) 2004-2011 福建星网视易信息系统有限公司
#   All rights reserved by 福建星网视易信息系统有限公司
#
#  \changelog  ：
#   2013年2月3日  创建
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
#保存原始配置并还原为默认配置
	rm -rf  /tmp/system.bak
	cp -rf  $CONFIG_PATH  /tmp/system.bak
	cp defaule_config/* $CONFIG_PATH
	chmod 777 $CONFIG_PATH/*
	set_config_ini_value "$CONFIG_PATH/dmb_server.ini" "ip"  "$TEST_LOCAL_IP"
	sync

	cp $TEST_PLAYLIST_DIR/ftp.xml  				/tmp/dmb/program/dmb_server/xml/
	cp $TEST_PLAYLIST_DIR/downloadtime.xml  				/tmp/dmb/program/dmb_server/xml/
#启动测试程序	
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
	
	#还原目录，清空SD卡对应目录
	rm -rf $CONFIG_PATH/*
	cp /tmp/system.bak/* $CONFIG_PATH
	rm -rf /tmp/system.bak
	
	rm /root/dmb/download/*
	rm /root/dmb/playlist/*
}
##
#	\功能编号 	DMB1820-TS-PC-001-F21  DMB1820-TS-PC-001-F15
# \功能说明	终端播放多种日期格式  终端播放任务顺序
#	\用例步骤	下发多格式日期时间任务到终端（时间：6种 日期：13种）   顺序播放多任务
#	\验证点		终端正常播放
##
_test_case_play_date()
{
	send_playlist 	playlist_date.xml
	wait_for_dmb_log  "unit_s"
	sleep 80
}
##
#	\功能编号 	DMB1820-TS-PC-001-F3
# \功能说明	终端播放多种图片特效
#	\用例步骤	下发特效图片到终端（18种）
#	\验证点		终端正常播放
##
_test_case_play_img()
{
	send_playlist 	playlist_img.xml
	wait_for_dmb_log  "unit_e"
}
##
#	\功能编号 	DMB1820-TS-PC-001-F16
# \功能说明	终端播放音频任务
#	\用例步骤	下发音频任务到终端
#	\验证点		终端正常播放
##
_test_case_play_music()
{
	send_playlist 	playlist_music.xml
	wait_for_dmb_log  "unit_e"
}
##
#	\功能编号 	DMB1820-TS-PC-001-F12
# \功能说明	终端播放多区域重叠任务
#	\用例步骤	下发区域重叠任务到终端
#	\验证点		终端正常播放
##
_test_case_play_overlap()
{
	send_playlist 	playlist_overlap.xml
	wait_for_dmb_log  "unit_e"
}
##
#	\功能编号 	DMB1820-TS-PC-001-F2
# \功能说明	终端播放多种优先级任务
#	\用例步骤	下发多种优先级任务任务到终端
#	\验证点		终端正常播放
##
_test_case_play_level()
{
	send_playlist 	playlist_task_level.xml
	wait_for_dmb_log  "unit_e"		
}
##
#	\功能编号 	DMB1820-TS-PC-001-F2
# \功能说明	终端自适应播放其他分辨率任务
#	\用例步骤	下发非终端当前分辨率任务任务到终端
#	\验证点		终端正常播放
##
_test_case_play_1920_1080()
{
	send_playlist 	playlist_1920_1080.xml
	wait_for_dmb_log  "unit_e"		
}
##
#	\功能编号 	DMB1820-TS-PC-001-F2
# \功能说明	终端播放avin任务
#	\用例步骤	下发avin任务到终端
#	\验证点		终端正常播放
##
_test_case_play_avin()
{
	send_playlist 	playlist_avin.xml
	wait_for_dmb_log  "unit_e"		
}
##
#	\功能编号 	DMB1820-TS-PC-001-F2
# \功能说明	终端播放插播字幕
#	\用例步骤	下发插播字幕任务到终端
#	\验证点		终端正常播放
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