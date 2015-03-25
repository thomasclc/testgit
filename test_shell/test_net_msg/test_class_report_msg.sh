#!/bin/sh
before_class()
{
	echo "before class"
}

after_class()
{
	echo "after class"
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
	
#启动测试程序	
	debug "start dmb_main"
	cd $DMB_PATH
	./dmb_load_drv
	./dmb_main -k $DMB_PATH/key_value -dusb &
	cd -
	debug "start dmb_server"
	cd $SERVER_PATH
	./dmb_server -s &
	cd -
	debug "wait 10s for start the funtion ..."
	sleep 10
}

after_case()
{
	killall -9 dmb_main
	killall -9 dmb_server
	test_log_path="`cat $TEST_LOG_PATH/test.info | awk -F= '$1~/logs_path/  {print $2}'`"
	cat  $DMB_LOG_PATH/$LOG_NAME.* > $test_log_path".log"
	
	#还原目录，清空SD卡对应目录
	rm -rf $CONFIG_PATH/*
	cp /tmp/system.bak/* $CONFIG_PATH
	rm -rf /tmp/system.bak
	
	rm /root/dmb/download/*
	rm /root/dmb/playlist/*
}

_test_case_request()
{
	sleep 5
	check_config_value /tmp/config/system/dmb_system.ini  "licinfo"  '[v1]cnWSb3hxv8IOFMX3THGR8MIrTyndUMOL'
	if [ $TEST_PRODUCT = 2810 ] ; then 
		check_net_msg_report 'login' 'type="broadcom"'
	else
		check_net_msg_report 'login' 'type="sigma"'
	fi
	check_net_msg_report 'contrast' '<contrast value="128" id="" />'
	check_net_msg_report 'bright' '<bright value="120" id="" />'
	check_net_msg_report 'diskinfo' '<diskinfo'
	check_net_msg_report 'server' '<server /></request>'
	check_net_msg_report 'fontfile' '<fontfile /></request>'
	check_net_msg_report 'timezone' '<timezone id="" /></request>'
	check_net_msg_report 'realtimedata' '<realtimedata /></request>'
	check_net_msg_report 'playlist' '<playlist action="request" date=""key="" id="" /></request>'
	check_net_msg_report 'ledplaylist' '<ledplaylist action="request"date="" key="" id="" /></request>'
	check_net_msg_report 'predownload' '<predownload action="request" key=""id="" /></request>'	
	check_net_msg_report 'worktime' '<worktime action="request" key=""id="" /></request>'
	check_net_msg_report 'downloadtime' '<downloadtime action="request"key="" id="" /></request>'
	check_net_msg_report 'diskumount' '<diskumount /></request>'
}

_test_case__request_error_log()
{	
	check_net_msg_report 'errorlog' '<errorlog id=""><error id="3112"'
}


_test_case__request_login()
{	
	check_net_msg_report 'login' '<login name="" mac="0016e8aabbcc"type="broadcom" vom="1920x1080" mi="hdmi" ip="192.168.65.93"mask="255.255.255.0" gateway="192.168.65.1" pwd="" licinfo=""timezone="UTC+08:00" />'
}

