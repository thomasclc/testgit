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
	./dmb_main -q -k $TEST_KEY_PATH -dusb &
	cd -
	debug "wait 10s for start the funtion ..."
	sleep 10
}

after_case()
{
	debug "reload date `date $MONTH$DAY$HOUR$MINUTE$YEAR`"
	killall -9 dmb_main
	test_log_path="`cat $TEST_LOG_PATH/test.info | awk -F= '$1~/logs_path/  {print $2}'`"
	cat  $DMB_LOG_PATH/$LOG_NAME.* > $test_log_path".log"
	
	
	rm -rf /tmp/config/system/*
	cp /tmp/system.bak/* /tmp/config/system/
	rm -rf /tmp/system.bak
}
##
#	\功能编号 	DMB1820-TS-IR-001-F20
# \功能说明	终端暗码配置终端输出模式
#	\用例步骤	通过遥控器暗码配置终端输出模式
#	\验证点		dmb_output.ini正确修改
##
_test_case_ir_config_vga()
{
	send_key_and_wait "ar:wait1:ns:wait1:2:wait1:8:wait1:7:wait1:1:wait1:ns"
	check_config_value $CONFIG_PATH/dmb_output.ini "mode"		"vga"
}

##
#	\功能编号 	DMB1820-TS-IR-001-F20
# \功能说明	终端暗码配置终端输出模式
#	\用例步骤	通过遥控器暗码配置终端输出模式
#	\验证点		dmb_output.ini正确修改
##
_test_case_ir_config_hdmi()
{
	send_key_and_wait "ar:wait1:ns:wait1:2:wait1:8:wait1:7:wait1:2:wait1:ns"
	check_config_value $CONFIG_PATH/dmb_output.ini "mode"		"hdmi"
}

##
#	\功能编号 	DMB1820-TS-IR-001-F20
# \功能说明	终端暗码配置终端输出模式
#	\用例步骤	通过遥控器暗码配置终端输出模式
#	\验证点		dmb_output.ini正确修改
##
_test_case_ir_config_av()
{
	send_key_and_wait "ar:wait1:ns:wait1:2:wait1:8:wait1:7:wait1:0:wait1:ns"
	check_config_value $CONFIG_PATH/dmb_output.ini "mode"		"hdmi"
}
##
#	\功能编号 	DMB1820-TS-IR-001-F20
# \功能说明	终端暗码配置终端输出模式
#	\用例步骤	通过遥控器暗码配置终端输出模式
#	\验证点		dmb_output.ini正确修改
##
_test_case_ir_config_lvds()
{
	send_key_and_wait "ar:wait1:ns:wait1:2:wait1:8:wait1:7:wait1:3:wait1:ns"
	check_config_value $CONFIG_PATH/dmb_output.ini "mode"		"hdmi"
}
##
#	\功能编号 	DMB1820-TS-IR-001-F20
# \功能说明	终端暗码配置终端语言
#	\用例步骤	通过遥控器暗码配置终端语言
#	\验证点		dmb_output.ini正确修改
##
_test_case_ir_config_language()
{
	send_key_and_wait "ar:wait1:ns:wait1:0:wait1:0:wait1:ns"
	check_config_value $CONFIG_PATH/dmb_system.ini "language"		"en"
	send_key_and_wait "ar:wait1:ns:wait1:9:wait1:9:wait1:ns"
	check_config_value $CONFIG_PATH/dmb_system.ini "language"		"zh-cn"
	send_key_and_wait "ar:wait1:ns:wait1:0:wait1:0:wait1:ns"
	check_config_value $CONFIG_PATH/dmb_system.ini "language"		"en"
	send_key_and_wait "ar:wait1:ns:wait1:9:wait1:9:wait1:ns"
	check_config_value $CONFIG_PATH/dmb_system.ini "language"		"zh-cn"
}

