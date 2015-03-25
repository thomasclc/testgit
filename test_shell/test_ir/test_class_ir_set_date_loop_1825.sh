##
#  \file       test_class_ir.sh
#  \brief      遥控器类测试脚本，主要为f3菜单功能
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
	killall -9 dmb_main
	rm $DMB_LOG_PATH/*
	rm /root/dmb/playlist/*
	
#设置为默认配置
	rm -rf  /tmp/system.bak
	cp -rf  /tmp/config/system  /tmp/system.bak
	cp defaule_config/* /tmp/config/system/
	chmod 777 /tmp/config/system/*	
	sync

#启动测试程序	
	debug "start dmb_main"
	cd $DMB_PATH
	./dmb_load_drv
	./dmb_main -q -k $TEST_KEY_PATH &
	cd -
	debug "wait 10s for start the funtion ..."
	sleep 10
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
#	\功能编号 	
# \功能说明	终端反复设置时间(1825版本)
#	\用例步骤	通过遥控器菜单发反复修改任务
#	\验证点		每次都能修改成功
##
_test_case_ir_set_date_loop()
{

	send_key_and_wait "f3:4:ok:9"
	while [ 1 ] ; do
		debug "set time: 12:59:00 "
		send_key_and_wait "ok:down:down:down:del:del:1:2:down:del:del:5:9:down:del:del:ok:wait2"
		if [ ! -z "`date  | awk  '{print $4}' | awk -F: '  $1~/12/ && $2~/59/ ' `" ] ;
		then
			debug "set date success"
		else
			debug "now: `date`"
			debug "set date fault"
			TEST_RESULT=0;
			break 	
		fi
		
		
		echo "set time: 01:01:00 "
		send_key_and_wait "ok:down:down:down:del:del:1:down:del:del:1:down:del:del:ok:wait2"
		
		if [ ! -z "`date  | awk  '{print $4}' | awk -F: '  $1~/01/ && $2~/01/ ' `" ] ;
		then
			debug "set date success"
		else
			debug "now: `date`"
			debug "set date fault"
			TEST_RESULT=0;
			break 	
		fi
		

	done
}
