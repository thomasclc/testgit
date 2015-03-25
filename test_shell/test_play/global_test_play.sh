##
#  \file       global_test_play.sh
#  \brief      调度播放测试脚本通用方法提供脚本
#
#   Copyright (C) 2004-2011 福建星网视易信息系统有限公司
#   All rights reserved by 福建星网视易信息系统有限公司
#
#  \changelog  ：
#   2013年12月27日  创建
##

#!/bin/sh
#. ./global.sh
test_play_clean_env()
{
	general_clean_env
#	rm /root/dmb/media/*
	rm /root/dmb/playlist/*
	rm /root/dmb/download/*
	rm $SERVER_XML_PATH/send_xml/*
	rm $SERVER_XML_PATH/loop_xml/*
	cp $CURRENT_PATH/playlist/ftp.xml  $SERVER_XML_PATH/send_xml/
}

test_play_test_ready()
{
	general_test_ready
	if [ "$SEND_XML_FILE_NAME" ]; then
		cp $CURRENT_PATH/playlist/$SEND_XML_FILE_NAME  $SERVER_XML_PATH/send_xml/
	fi	
	
	dmb_ip=`get_config_ini_value  "$CONFIG_PATH/dmb_eth0.ini"  "static_ip"` 
	set_config_ini_value "$CONFIG_PATH/dmb_server.ini" 		"ip"  				"$dmb_ip"
	set_config_ini_value "$CONFIG_PATH/dmb_wifi.ini" "start_wifi"  "0"
	set_config_ini_value "$CONFIG_PATH/dmb_3g.ini" 				"start_3g"  	"0"
}

test_play_test_reload()
{	
	rm $SERVER_XML_PATH/send_xml/*
	rm $SERVER_XML_PATH/loop_xml/*
}

test_play_test_check()
{
	mv 	$TEST_LOG_PATH/$TEST_LOG_ERR  $TEST_LOG_PATH/$TEST_LOG_ERR.tmp
  cat $TEST_LOG_PATH/$TEST_LOG_ERR.tmp |  awk -F^ '$1 !~/dmb_ntp/ { print   }'  > $TEST_LOG_PATH/$TEST_LOG_ERR
 	rm  $TEST_LOG_PATH/$TEST_LOG_ERR.tmp	  
	if [ -s $TEST_LOG_PATH/$TEST_LOG_ERR ];   
	then   
		debug "------------ERROR : log file has ERROR----------------"
		debug "` cat $TEST_LOG_PATH/$TEST_LOG_ERR `"
		debug "------------ERROR : log file has ERROR----------------"
#		TEST_RESULT=0;
	fi	
}
test_play_do_test()
{
##run dmb_server
	cd $SERVER_PATH
	./$SERVER_NAME $1 &
	if [ $! ];then
		SERVER_PID=$!
	fi
	debug "SERVER_PID: $SERVER_PID"
##run dmb_main
	cd $DMB_PATH
	./$DMB_NAME $2 &
	if [ $! ];then
		DMB_PID=$!
	fi
	debug "DMB_PID: $DMB_PID"
	cd $CURRENT_PATH

	while [ -s ` awk -F^ ' $2 ~/unit_e/ { print   }' $DMB_LOG_PATH/$LOG_NAME.* `  ] ;    
	do
    debug "----------------wait for playing..."
    sleep $WAIT_QUIT_TIME ;
  done
	sleep 30	
	
  debug "---play finish!"
	debug "----------------kill server PID= $SERVER_PID"
  kill $KILL_PAR $SERVER_PID
  debug "----------------kill dmb PID= $DMB_PID"
  kill $KILL_PAR $DMB_PID    
  debug "dmb nomal stop"
  sleep 10
  while [ ! -s ` ps -e | awk -v val=$SERVER_PID '$1==val {print $1}'`  ] ; do
		debug "----------------wait for stoping...server"
		sleep 10  ;
  done
#  while [ ! -s ` ps -e | awk -v val=$DMB_PID '$1==val {print $1}'`  ] ; do
#		debug "----------------wait for stoping...dmb"
#		sleep 10  ;
#  done
  kill -9 $DMB_PID   
  
  cat  $DMB_LOG_PATH/$LOG_NAME.3 >> $TEST_LOG_PATH/$TEST_DMB_LOG
  cat  $DMB_LOG_PATH/$LOG_NAME.2 >> $TEST_LOG_PATH/$TEST_DMB_LOG
  cat  $DMB_LOG_PATH/$LOG_NAME.1 >> $TEST_LOG_PATH/$TEST_DMB_LOG
}
test_play_check()
{
	cat $TEST_LOG_PATH/$TEST_DMB_LOG |  awk -F^ '$2 ~/unit_a/ || $2 ~/unit_s/ || $2 ~/unit_e/ || $2 ~/stuff_p/ || $2 ~/stuff_e/ { print $2  } '  >> $TEST_LOG_PATH/$TEST_DMB_LOG.tmp
	file_md5_compare $CURRENT_PATH/playlist/$SEND_XML_FILE_NAME /root/dmb/playlist/playlist.xml.new
	file_md5_compare $TEST_LOG_PATH/$TEST_DMB_LOG.tmp $CURRENT_PATH/playlog/$TEST_NAME
#	rm  $TEST_LOG_PATH/$TEST_DMB_LOG.tmp
}