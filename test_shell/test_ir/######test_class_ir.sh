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
	send_ir_key_and_wait "Exit"
}


##
#	\功能编号 	DMB1820-TS-IR-001-F7
# \功能说明	终端网络状态查询
#	\用例步骤	通过遥控器菜单查询终端网络状态
#	\验证点		网络状态能在菜单中正确显示
##
_test_case_ir_config_net_state()
{
#	send_ir_key_and_wait "f3:2:ok"
#	send_ir_key_and_wait "down:down:down:down:down:down:down:down:down:down:down:down:down:down"

	send_ir_key_and_wait "enter_menu"
	send_ir_key_and_wait "enter_menu_status_info"
	send_ir_key_and_wait "enter_status_info_ethernet" 
	send_ir_key_and_wait "status_info_ethernet_traversal"

}
##
#	\功能编号 	DMB1820-TS-IR-001-F26
# \功能说明	终端错误查询
#	\用例步骤	通过遥控器菜单查询终端错误
#	\验证点		终端错误能在菜单中正确显示
##
_test_case_ir_error()
{
	send_ir_key_and_wait "enter_menu"
	send_ir_key_and_wait "enter_menu_error_info"
	send_ir_key_and_wait "status_info_ethernet_traversal"
}
##
#	\功能编号 	DMB1820-TS-IR-001-F18
# \功能说明	终端维护信息查询
#	\用例步骤	通过遥控器菜单查询终端维护信息
#	\验证点		终端信息能在菜单中正确显示
##
_test_case_ir_status_info_ethernet()
{
	send_ir_key_and_wait "enter_menu"
	send_ir_key_and_wait "enter_menu_status_info"
	send_ir_key_and_wait "enter_status_info_ethernet"
	send_ir_key_and_wait "status_info_ethernet_traversal"
}
_test_case_ir_status_info_3G()
{
	send_ir_key_and_wait "enter_menu"
	send_ir_key_and_wait "enter_menu_status_info"
	send_ir_key_and_wait "enter_status_info_ethernet"
	send_ir_key_and_wait "status_info_ethernet_traversal"
}
_test_case_ir_status_info_wifi()
{
	send_ir_key_and_wait "enter_menu"
	send_ir_key_and_wait "enter_menu_status_info"
	send_ir_key_and_wait "enter_status_info_wifi"
	send_ir_key_and_wait "status_info_wifi_traversal"
}
_test_case_ir_status_info_version()
{
	send_ir_key_and_wait "enter_menu"
	send_ir_key_and_wait "enter_menu_status_info"
	send_ir_key_and_wait "enter_status_info_version"
	send_ir_key_and_wait "status_info_version_traversal"
}
_test_case_ir_status_info_USB()
{
	send_ir_key_and_wait "enter_menu"
	send_ir_key_and_wait "enter_menu_status_info"
	send_ir_key_and_wait "enter_status_info_USB"
	send_ir_key_and_wait "status_info_USB_traversal"
}
_test_case_ir_status_info_hard_disk()
{
	send_ir_key_and_wait "enter_menu"
	send_ir_key_and_wait "enter_menu_status_info"
	send_ir_key_and_wait "enter_status_info_hard_disk"
	send_ir_key_and_wait "status_info_hard_disk_traversal"
}
_test_case_ir_status_info_download()
{
	send_ir_key_and_wait "enter_menu"
	send_ir_key_and_wait "enter_menu_status_info"
	send_ir_key_and_wait "enter_status_info_download"
	send_ir_key_and_wait "status_info_download_traversal"
}
_test_case_ir_status_info_hardware()
{
	send_ir_key_and_wait "enter_menu"
	send_ir_key_and_wait "enter_menu_status_info"
	send_ir_key_and_wait "enter_status_info_hardware"
	send_ir_key_and_wait "status_info_hardware_traversal"
}
_test_case_ir_status_info_application()
{
	send_ir_key_and_wait "enter_menu"
	send_ir_key_and_wait "enter_menu_status_info"
	send_ir_key_and_wait "enter_status_info_applicatio"
	send_ir_key_and_wait "status_info_applicatio_traversal"
}
_test_case_ir_status_info_network()
{
	send_ir_key_and_wait "enter_menu"
	send_ir_key_and_wait "enter_menu_status_info"
	send_ir_key_and_wait "enter_status_info_network"
	send_ir_key_and_wait "status_info_network_traversal"
}
_test_case_ir_status_info_synchrony()
{
	send_ir_key_and_wait "enter_menu"
	send_ir_key_and_wait "enter_menu_status_info"
	send_ir_key_and_wait "enter_status_info_synchrony"
	send_ir_key_and_wait "status_info_synchrony_traversal"
}
_test_case_ir_status_info_LED()
{
	send_ir_key_and_wait "enter_menu"
	send_ir_key_and_wait "enter_menu_status_info"
	send_ir_key_and_wait "enter_status_info_LED"
	send_ir_key_and_wait "status_info_LED_traversal"
}
##
#	\功能编号 	DMB1820-TS-IR-001-F1
# \功能说明	终端以太网配置
#	\用例步骤	通过遥控器菜单配置终端以太网
#	\验证点		dmb_eth0.ini文件内容能够正确修改
##
_test_case_ir_config_net()
{
#	send_ir_key_and_wait "f3:0:ok:0:ok"
#	send_ir_key_and_wait "right:down"
#	send_ir_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:del:1:9:2:ar:1:6:8:ar:1:ar:2:down"
#	send_ir_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:del:del:2:5:5:ar:2:5:5:ar:2:5:5:ar:0:down"
#	send_ir_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:del:1:9:2:ar:1:6:8:ar:1:ar:1"
#	send_ir_key_and_wait "ok:wait3"

	send_ir_key_and_wait "enter_menu"
	send_ir_key_and_wait "enter_menu_set"
	send_ir_key_and_wait "enter_set_ethernet"
	send_ir_key_and_wait "set_ethernet_DHCP"
	send_ir_key_and_wait "Next"
	send_ir_key_and_wait "set_ethernet_IP"
	send_ir_key_and_wait "Next"
	send_ir_key_and_wait "set_ethernet_mask"
	send_ir_key_and_wait "Next"
	send_ir_key_and_wait "set_ethernet_gateway"
	send_ir_key_and_wait "Save"
	send_ir_key_and_wait "Exit"
	
	check_config_value $CONFIG_PATH/dmb_eth0.ini "static_ip" 	"192.168.1.2"   
	check_config_value $CONFIG_PATH/dmb_eth0.ini "static_netmask" 	"255.255.255.0"   
	check_config_value $CONFIG_PATH/dmb_eth0.ini "static_gateway" 		"192.168.1.1"  
	check_config_value $CONFIG_PATH/dmb_eth0.ini "dhcp" 	"0" 	
	
	send_ir_key_and_wait "enter_menu"
	send_ir_key_and_wait "enter_menu_set"
	send_ir_key_and_wait "enter_set_ethernet"
	send_ir_key_and_wait "Next"
	send_ir_key_and_wait "set_ethernet_IP_errors"
	send_ir_key_and_wait "Next"
	send_ir_key_and_wait "set_ethernet_mask_errors"
	send_ir_key_and_wait "Next"
	send_ir_key_and_wait "set_ethernet_gateway_errors"
	send_ir_key_and_wait "Save"
	send_ir_key_and_wait "Exit"	
	
	check_config_value $CONFIG_PATH/dmb_eth0.ini "static_ip" 	"192.168.1.2"   
	check_config_value $CONFIG_PATH/dmb_eth0.ini "static_netmask" 	"255.255.255.0"   
	check_config_value $CONFIG_PATH/dmb_eth0.ini "static_gateway" 		"192.168.1.1"  
	
	
}
##
#	\功能编号 	DMB1820-TS-IR-001-F2
# \功能说明	终端3G配置
#	\用例步骤	通过遥控器菜单配置终端3G
#	\验证点		dmb_3g.ini文件内容能够正确修改
##
_test_case_ir_config_3G()
{
#	send_ir_key_and_wait "f3:0:ok:1:ok"
#	send_ir_key_and_wait "right:down"
#	send_ir_key_and_wait "right:down"	
#	send_ir_key_and_wait "right:down"
#	send_ir_key_and_wait "del:1:down"
#	send_ir_key_and_wait "del:2:down"
#	send_ir_key_and_wait "del:del:del:del:del:del:1:2:3:4:5:6:down"
#	send_ir_key_and_wait "del:del:del:del:0:5:8:8:6:wait3:down"
#	send_ir_key_and_wait "del:del:del:del:1:2:3:4:wait3:down"
#	send_ir_key_and_wait "1:2:3:4:5:6:7:8:wait3:down"
#	send_ir_key_and_wait "8:7:6:5:4:3:2:1:wait3:down"
#	send_ir_key_and_wait "6:6:6:2:2:6:6:3:3:3:wait3:down"
#	send_ir_key_and_wait "7:7:9:9:3:3:wait3:down"
#	send_ir_key_and_wait "1:9:2:ar:1:6:8:ar:1:ar:1:wait3:down"
#	send_ir_key_and_wait "del:del:4:4:4:4:7:7:wait3:down"
#	send_ir_key_and_wait "right"
#	send_ir_key_and_wait "ok:wait3"
	
	send_ir_key_and_wait "enter_menu"
	send_ir_key_and_wait "enter_menu_set"
	send_ir_key_and_wait "enter_set_3G"
	send_ir_key_and_wait "set_3G_start_state"
	send_ir_key_and_wait "Next"
	send_ir_key_and_wait "set_3G_model"
	send_ir_key_and_wait "Next"
	send_ir_key_and_wait "set_3G_format"
	send_ir_key_and_wait "Next"
	send_ir_key_and_wait "set_3G_port_num"
	send_ir_key_and_wait "Next"
	send_ir_key_and_wait "set_3G_congih_num"
	send_ir_key_and_wait "Next"
	send_ir_key_and_wait "set_3G_baud_rate"
	send_ir_key_and_wait "Next"
	send_ir_key_and_wait "set_3G_vendor"
	send_ir_key_and_wait "Next"
	send_ir_key_and_wait "set_3G_productor"
	send_ir_key_and_wait "Next"
	send_ir_key_and_wait "set_3G_access_point"
	send_ir_key_and_wait "Next"
	send_ir_key_and_wait "set_3G_dial"
	send_ir_key_and_wait "Next"
	send_ir_key_and_wait "set_3G_username"
	send_ir_key_and_wait "Next"
	send_ir_key_and_wait "set_3G_password"
	send_ir_key_and_wait "Next"
	send_ir_key_and_wait "set_3G_PDP_address"
	send_ir_key_and_wait "Next"
	send_ir_key_and_wait "set_3G_PDP_typedel"
	send_ir_key_and_wait "Next"
	send_ir_key_and_wait "set_3G_network"
	send_ir_key_and_wait "Save"
	send_ir_key_and_wait "Exit"	
	
	check_config_value $CONFIG_PATH/dmb_3g.ini  "start_3g" 	"1"   
	check_config_value $CONFIG_PATH/dmb_3g.ini "3g_system" 	"0"   
	check_config_value $CONFIG_PATH/dmb_3g.ini "3g_type" 		"6"  
	check_config_value $CONFIG_PATH/dmb_3g.ini "port_num" 	"1"   
	check_config_value $CONFIG_PATH/dmb_3g.ini "baud_rate" 	"123456"   
	check_config_value $CONFIG_PATH/dmb_3g.ini "3g_vid" 		"05t6"   
	check_config_value $CONFIG_PATH/dmb_3g.ini "3g_pid"		 	"1234"   
	check_config_value $CONFIG_PATH/dmb_3g.ini "3g_apn" 		"12345678"   
	check_config_value $CONFIG_PATH/dmb_3g.ini "dail_num" 	"87654321"   
	check_config_value $CONFIG_PATH/dmb_3g.ini "user_name"	"name"  
	check_config_value $CONFIG_PATH/dmb_3g.ini "pass_word" 	"pwd"   
	check_config_value $CONFIG_PATH/dmb_3g.ini "pdp_addr" 	"192.168.1.1"  
	check_config_value $CONFIG_PATH/dmb_3g.ini "pdp_type" 	"ip"   
	check_config_value $CONFIG_PATH/dmb_3g.ini "net_mode" 	"1"   
	check_config_value $CONFIG_PATH/dmb_3g.ini "port_cmd"		"2"   	
		
}
##
#	\功能编号 	DMB1820-TS-IR-001-F3
# \功能说明	终端wifi配置
#	\用例步骤	通过遥控器菜单配置终端wifi
#	\验证点		dmb_wifi.ini文件内容能够正确修改
##
_test_case_ir_config_wifi()
{
#	send_ir_key_and_wait "f3:0:ok:2:ok"
#	send_ir_key_and_wait "right:down"
#	send_ir_key_and_wait "down"	
#	send_ir_key_and_wait "1:9:2:ar:1:6:8:ar:1:ar:2:down"
#	send_ir_key_and_wait "2:5:5:ar:2:5:5:ar:2:5:5:ar:0:down"
#	send_ir_key_and_wait "1:9:2:ar:1:6:8:ar:1:ar:1:down"
#	send_ir_key_and_wait "8:8:3:3:3:7:7:7:7:7:8:8:wait3:down"
#	send_ir_key_and_wait "7:7:9:9:3:3:wait3:down"
#	send_ir_key_and_wait "right"
#	send_ir_key_and_wait "ok:wait3"

	send_ir_key_and_wait "enter_menu"
	send_ir_key_and_wait "enter_menu_set"
	send_ir_key_and_wait "enter_set_wifi"
	send_ir_key_and_wait "set_wifi_start_state"
	send_ir_key_and_wait "Next"
	send_ir_key_and_wait "set_wifi_access"
	send_ir_key_and_wait "Next"
	send_ir_key_and_wait "set_wifi_IP"
	send_ir_key_and_wait "Next"
	send_ir_key_and_wait "set_wifi_mask"
	send_ir_key_and_wait "Next"
	send_ir_key_and_wait "set_wifi_gateway"
	send_ir_key_and_wait "Next"
	send_ir_key_and_wait "set_wifi_essid"
	send_ir_key_and_wait "Next"
	send_ir_key_and_wait "set_wifi_password"
	send_ir_key_and_wait "Next"
	send_ir_key_and_wait "set_wifi_encryption"
	send_ir_key_and_wait "Save"
	send_ir_key_and_wait "Exit"		

	
	check_config_value $CONFIG_PATH/dmb_wifi.ini "start_wifi"		"1"     
	check_config_value $CONFIG_PATH/dmb_wifi.ini "wifi_essid"		"test"   
	check_config_value $CONFIG_PATH/dmb_wifi.ini "wifi_encro_type"		"2"   
	check_config_value $CONFIG_PATH/dmb_wifi.ini "wifi_key"		"pwd"   
	check_config_value $CONFIG_PATH/dmb_wifi.ini "dhcp"		"0"   
	check_config_value $CONFIG_PATH/dmb_wifi.ini "static_ip"		"192.168.1.2"   
	check_config_value $CONFIG_PATH/dmb_wifi.ini "static_netmask"		"255.255.255.0"   
	check_config_value $CONFIG_PATH/dmb_wifi.ini "static_gateway"		"192.168.1.1"   	
}
##
#	\功能编号 	DMB1820-TS-IR-001-F4
# \功能说明	终端代理配置
#	\用例步骤	通过遥控器菜单配置终端代理
#	\验证点		dmb_proxy.ini文件内容能够正确修改
##
_test_case_ir_config_proxy()
{
#	send_ir_key_and_wait "f3:0:ok:3:ok"
#	send_ir_key_and_wait "right:down"
#	send_ir_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:1:9:2:ar:1:6:8:ar:1:ar:2:down"
#	send_ir_key_and_wait "del:del:del:del:1:2:3:4:down"
#	send_ir_key_and_wait "right:down"
#	send_ir_key_and_wait "del:del:del:del:6:6:6:2:2:6:6:3:3:3:wait3:down"
#	send_ir_key_and_wait "del:del:del:7:7:9:9:3:3:wait3:down"
#	send_ir_key_and_wait "ok:wait3"

	send_ir_key_and_wait "enter_menu"
	send_ir_key_and_wait "enter_menu_set"
	send_ir_key_and_wait "enter_set_proxy"
	send_ir_key_and_wait "set_proxy_start"
	send_ir_key_and_wait "Next"
	send_ir_key_and_wait "set_proxy_IP"
	send_ir_key_and_wait "Next"
	send_ir_key_and_wait "set_proxy_port_num"
	send_ir_key_and_wait "Next"
	send_ir_key_and_wait "set_proxy_authentication"
	send_ir_key_and_wait "Next"
	send_ir_key_and_wait "set_proxy_user_name"
	send_ir_key_and_wait "Next"
	send_ir_key_and_wait "set_proxy_password"
	send_ir_key_and_wait "Save"
	send_ir_key_and_wait "Exit"		

	check_config_value $CONFIG_PATH/dmb_proxy.ini "proxy_switch"		"1"     
	check_config_value $CONFIG_PATH/dmb_proxy.ini "proxy_server_ip"		"192.168.1.2"   
	check_config_value $CONFIG_PATH/dmb_proxy.ini "proxy_server_port"		"1234"   
	check_config_value $CONFIG_PATH/dmb_proxy.ini "auth"		"1"   
	check_config_value $CONFIG_PATH/dmb_proxy.ini "username"		"name"   
	check_config_value $CONFIG_PATH/dmb_proxy.ini "password"		"pwd"     			
}
##
#	\功能编号 	DMB1820-TS-IR-001-F5
# \功能说明	终端DNS配置
#	\用例步骤	通过遥控器菜单配置终端DNS
#	\验证点		resolv.conf文件内容能够正确修改
##
_test_case_ir_config_dns()
{
#	send_ir_key_and_wait "f3:0:ok:4:ok"
#	send_ir_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:del:del:del:del:1:9:2:ar:1:6:8:ar:1:ar:2:down"
#	send_ir_key_and_wait "ok:wait3"

	send_ir_key_and_wait "enter_menu"
	send_ir_key_and_wait "enter_menu_set"
	send_ir_key_and_wait "enter_set_DNS"
	send_ir_key_and_wait "set_DNS"
	send_ir_key_and_wait "Save"
	send_ir_key_and_wait "Exit"			
	check_text  $CONFIG_PATH/resolv.conf   "nameserver 192.168.1.2"  	
}
##
#	\功能编号 	（暂无）
# \功能说明	终端SSL配置
#	\用例步骤	通过遥控器菜单配置终端SSL开关
#	\验证点		dmb_ssl.ini文件内容能够正确修改
##
_test_case_ir_config_ssl()
{
	check_config_value $CONFIG_PATH/dmb_ssl.ini "ssl_switch"		"0"	
	send_ir_key_and_wait "f3:0:ok:5:ok"
	send_ir_key_and_wait "right:down"
	send_ir_key_and_wait "ok:wait3"
	check_config_value $CONFIG_PATH/dmb_ssl.ini "ssl_switch"		"1"	
	send_ir_key_and_wait "ok:right:down:ok:wait3"
	check_config_value $CONFIG_PATH/dmb_ssl.ini "ssl_switch"		"0"	
}
##
#	\功能编号 	DMB1820-TS-IR-001-F6
# \功能说明	终端平台配置
#	\用例步骤	通过遥控器菜单配置终端平台
#	\验证点		dmb_server.ini文件内容能够正确修改
##
_test_case_ir_config_server()
{
#	send_ir_key_and_wait "f3:1:ok"
#	send_ir_key_and_wait "del:del:del:del:del:del:del:del:del:del:del:del:del:1:9:2:ar:1:6:8:ar:1:ar:2:wait3:down"
#	send_ir_key_and_wait "del:del:del:del:del:1:2:3:4:5:down"
#	send_ir_key_and_wait "del:del:del:del:del:5:4:3:2:1:down"
#	send_ir_key_and_wait "1:2:3:4:5:6:7:8:wait3"
#	send_ir_key_and_wait "ok:wait3"

	send_ir_key_and_wait "enter_menu"
	send_ir_key_and_wait "enter_menu_set"
	send_ir_key_and_wait "enter_set_server"
	send_ir_key_and_wait "set_server_IP"
	send_ir_key_and_wait "Next"
	send_ir_key_and_wait "set_server_com_port"
	send_ir_key_and_wait "Next"
	send_ir_key_and_wait "set_server_control_port"
	send_ir_key_and_wait "Next"
	send_ir_key_and_wait "set_server_number"
	send_ir_key_and_wait "Save"
	send_ir_key_and_wait "Exit"			

	
	check_config_value $CONFIG_PATH/dmb_server.ini "ip"		"192.168.1.2"	
	check_config_value $CONFIG_PATH/dmb_server.ini "port"		"12345"	
	check_config_value $CONFIG_PATH/dmb_server.ini "pcrt"		"54321"	
	check_config_value $CONFIG_PATH/dmb_server.ini "boxno"		"12345678"	
}
##
#	\功能编号 	DMB1820-TS-IR-001-F9
# \功能说明	终端分辨率配置
#	\用例步骤	通过遥控器菜单配置终端分辨率（遍历）
#	\验证点		dmb_output.ini文件内容能够正确修改
##
_test_case_ir_config_resolution()
{
#	check_config_value $CONFIG_PATH/dmb_output.ini "width"		"1024"	
#	check_config_value $CONFIG_PATH/dmb_output.ini "height"		"768"	
#	send_ir_key_and_wait "f3:4:ok:0"
#	send_ir_key_and_wait "ok:down:ok:wait3"
#	check_config_value $CONFIG_PATH/dmb_output.ini "width"		"800"	
#	check_config_value $CONFIG_PATH/dmb_output.ini "height"		"600"	
#	send_ir_key_and_wait "ok:down:ok:wait3"
#	check_config_value $CONFIG_PATH/dmb_output.ini "width"		"1024"	
#	check_config_value $CONFIG_PATH/dmb_output.ini "height"		"768"	
#	send_ir_key_and_wait "ok:down:down:ok:wait3"
#	check_config_value $CONFIG_PATH/dmb_output.ini "width"		"1280"	
#	check_config_value $CONFIG_PATH/dmb_output.ini "height"		"720"		
#	send_ir_key_and_wait "ok:down:down:down:ok:wait3"
#	check_config_value $CONFIG_PATH/dmb_output.ini "width"		"1280"	
#	check_config_value $CONFIG_PATH/dmb_output.ini "height"		"768"	
#	send_ir_key_and_wait "ok:down:down:down:down:ok:wait3"
#	check_config_value $CONFIG_PATH/dmb_output.ini "width"		"1280"	
#	check_config_value $CONFIG_PATH/dmb_output.ini "height"		"1024"	
#	send_ir_key_and_wait "ok:down:down:down:down:down:ok:wait3"
#	check_config_value $CONFIG_PATH/dmb_output.ini "width"		"1360"	
#	check_config_value $CONFIG_PATH/dmb_output.ini "height"		"768"	
#	send_ir_key_and_wait "ok:down:down:down:down:down:down:ok:wait3"
#	check_config_value $CONFIG_PATH/dmb_output.ini "width"		"1366"	
#	check_config_value $CONFIG_PATH/dmb_output.ini "height"		"768"	
#	send_ir_key_and_wait "ok:down:down:down:down:down:down:down:ok:wait3"
#	check_config_value $CONFIG_PATH/dmb_output.ini "width"		"1440"	
#	check_config_value $CONFIG_PATH/dmb_output.ini "height"		"900"	
#	send_ir_key_and_wait "ok:down:down:down:down:down:down:down:down:ok:wait3"
#	check_config_value $CONFIG_PATH/dmb_output.ini "width"		"1600"	
#	check_config_value $CONFIG_PATH/dmb_output.ini "height"		"1200"	
#	send_ir_key_and_wait "ok:down:down:down:down:down:down:down:down:down:ok:wait3"
#	check_config_value $CONFIG_PATH/dmb_output.ini "width"		"1680"	
#	check_config_value $CONFIG_PATH/dmb_output.ini "height"		"1050"	
#	send_ir_key_and_wait "ok:down:down:down:down:down:down:down:down:down:down:ok:wait3"
#	check_config_value $CONFIG_PATH/dmb_output.ini "width"		"1920"	
#	check_config_value $CONFIG_PATH/dmb_output.ini "height"		"1080"	
}
##
#	\功能编号 	DMB1820-TS-IR-001-F10
# \功能说明	终端亮度对比度配置
#	\用例步骤	通过遥控器菜单配置终端亮度对比度（遍历）
#	\验证点		dmb_output.ini文件内容能够正确修改
##
_test_case_ir_config_light_contrast()
{
#亮度
	check_config_value $CONFIG_PATH/dmb_output.ini "light"		"120"	
	check_config_value $CONFIG_PATH/dmb_output.ini "contrast"		"128"	
	send_ir_key_and_wait "f3:4:ok:2:ok"
	send_ir_key_and_wait "left:left:left:left:left:left:left:left:left:left:left:left:left:left:left:left"
	send_ir_key_and_wait "ok:wait3"
	check_config_value $CONFIG_PATH/dmb_output.ini "light"		"0"	
	for i in $(seq 30); do  
		send_ir_key_and_wait "ok:right:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "light"		$(($i*8))	
 	done
 	send_ir_key_and_wait "ok:left:left:left:left:left:left:left:left:left:left:left:left:left:left:left:ok:wait3"
	check_config_value $CONFIG_PATH/dmb_output.ini "light"		"120"		
#对比度	
	send_ir_key_and_wait "ok:down:left:left:left:left:left:left:left:left:ok:wait3"
	check_config_value $CONFIG_PATH/dmb_output.ini "contrast"		"0"	
	for i in $(seq 15); do  
		send_ir_key_and_wait "ok:down:right:ok:wait3"
		check_config_value $CONFIG_PATH/dmb_output.ini "contrast"		$(($i*16))	
 	done
	send_ir_key_and_wait "ok:down:right:ok:wait3"
	check_config_value $CONFIG_PATH/dmb_output.ini "contrast"		"255"	
 	send_ir_key_and_wait "ok:down:left:left:left:left:left:left:left:left:ok:wait3"
	check_config_value $CONFIG_PATH/dmb_output.ini "contrast"		"128"
}
##
#	\功能编号 	DMB1820-TS-IR-001-F11
# \功能说明	终端语言配置
#	\用例步骤	通过遥控器菜单配置终端语言（遍历）
#	\验证点		dmb_system.ini文件内容能够正确修改
##
_test_case_ir_config_language()
{	
	check_config_value $CONFIG_PATH/dmb_system.ini "language"		"zh-cn"	
  send_ir_key_and_wait "f3:4:ok:4:ok"
	send_ir_key_and_wait "right:ok:wait3"
	check_config_value $CONFIG_PATH/dmb_system.ini "language"		"en"	
	send_ir_key_and_wait "ok:right:ok:wait3"
	check_config_value $CONFIG_PATH/dmb_system.ini "language"		"zh-cn"	
}
##
#	\功能编号 	DMB1820-TS-IR-001-F12
# \功能说明	终端输出模式配置
#	\用例步骤	通过遥控器菜单配置终端输出模式（遍历）
#	\验证点		dmb_output.ini文件内容能够正确修改
##
_test_case_ir_config_output_mode()
{	
	check_config_value $CONFIG_PATH/dmb_output.ini "mode"		"vga"
  send_ir_key_and_wait "f3:4:ok:5:ok"
	send_ir_key_and_wait "right:ok:wait3"
	check_config_value $CONFIG_PATH/dmb_output.ini "mode"		"hdmi"
	send_ir_key_and_wait "ok:right:ok:wait3"	
	check_config_value $CONFIG_PATH/dmb_output.ini "mode"		"vga"
}
##
#	\功能编号 	DMB1820-TS-IR-001-F13
# \功能说明	终端旋转角度配置
#	\用例步骤	通过遥控器菜单配置终端旋转角度（遍历）
#	\验证点		dmb_output.ini文件内容能够正确修改
##
_test_case_ir_config_rotate()
{	
	check_config_value $CONFIG_PATH/dmb_output.ini "rotate"		"0"	
  send_ir_key_and_wait "f3:4:ok:6:ok"
	send_ir_key_and_wait "right:ok:wait3"
	check_config_value $CONFIG_PATH/dmb_output.ini "rotate"		"90"	
	send_ir_key_and_wait "ok:right:ok:wait3"
	check_config_value $CONFIG_PATH/dmb_output.ini "rotate"		"180"	
	send_ir_key_and_wait "ok:right:ok:wait3"
	check_config_value $CONFIG_PATH/dmb_output.ini "rotate"		"270"	
	send_ir_key_and_wait "ok:right:ok:wait3"
	check_config_value $CONFIG_PATH/dmb_output.ini "rotate"		"0"	
}
##
#	\功能编号 	DMB1820-TS-IR-001-F14
# \功能说明	终端时区配置
#	\用例步骤	通过遥控器菜单配置终端时区（遍历）
#	\验证点		TZ 文件内容能够正确修改
##
_test_case_ir_config_timezone()
{	
	check_text $CONFIG_PATH/TZ  "UTC-08:00"
	send_ir_key_and_wait "f3:4:ok:7" 
  send_ir_key_and_wait "ok:left:left:left:left:left:left:left:left:left:left:left:left:left:ok:wait3"
  check_text $CONFIG_PATH/TZ  "UTC"
  check_no_text $CONFIG_PATH/TZ "-"	
	
	timezone="-01:00 -02:00 -03:00 -03:30 -04:00 -04:30 -05:00 -05:30 -05:45 -06:00 -06:30 -07:00 -08:00 -08:45 -09:00 -09:30 -10:00 -10:30 -11:00 -11:30 -12:00 -12:45 -13:00 -14:00 +12:00 +11:00 +10:00 +09:30 +09:00 +08:00 +07:00 +06:00 +05:00 +04:30 +04:00 +03:30 +03:00 +02:00 +01:00" 
  for i in $timezone ; do 
  	send_ir_key_and_wait "ok:right:ok:wait3"
  	check_text $CONFIG_PATH/TZ  "UTC"$i
  done
}
##
#	\功能编号 	DMB1820-TS-IR-001-F17
# \功能说明	终端同步开关
#	\用例步骤	通过遥控器菜单配置终端同步开关
#	\验证点		dmb_system.ini文件内容能够正确修改
##
_test_case_ir_config_syn()
{	
	check_config_value $CONFIG_PATH/dmb_system.ini "syn_flag"		"0"	
  send_ir_key_and_wait "f3:4:ok:9:down:ok"
	send_ir_key_and_wait "right:ok:wait3"
	check_config_value $CONFIG_PATH/dmb_system.ini "syn_flag"		"1"	
	send_ir_key_and_wait "ok:right:ok:wait3"
	check_config_value $CONFIG_PATH/dmb_system.ini "syn_flag"		"0"	
}
##
#	\功能编号 	DMB1820-TS-IR-001-F15 DMB1820-TS-IR-001-F27
# \功能说明	终端配置密码
#	\用例步骤	通过遥控器菜单配置终端配置密码
#	\验证点		dmb.passwd 文件内容能够正确修改
##
_test_case_ir_config_pwd()
{	
	send_ir_key_and_wait "f3:4:ok:8:ok"
	send_ir_key_and_wait "0:ok"
	send_ir_key_and_wait "down:down:1:2:3:4:5:6:7:2:2"
	send_ir_key_and_wait "down:1:2:3:4:5:6:7:2:2"
	send_ir_key_and_wait "ok:wait3"
	send_ir_key_and_wait "esc:esc:esc"
	check_text $CONFIG_PATH/dmb.passwd  "admin:fe008700f25cb28940ca8ed91b23b354" 
	send_ir_key_and_wait "f3"
	send_ir_key_and_wait "1:2:3:4:5:6:7:2:2:ok"
	send_ir_key_and_wait "4:ok:8:ok" 
	send_ir_key_and_wait "0:ok"
	send_ir_key_and_wait "down:1:2:3:4:5:6:7:2:2"
	send_ir_key_and_wait "down:down:down:ok"
	send_ir_key_and_wait "ok:wait3"
	check_text $CONFIG_PATH/dmb.passwd  "admin:" 
	check_no_text  $CONFIG_PATH/dmb.passwd "fe008700f25cb28940ca8ed91b23b354"	
	send_ir_key_and_wait "esc:esc:esc"
}
##
#	\功能编号 	DMB1820-TS-IR-001-F15 DMB1820-TS-IR-001-F27
# \功能说明	终端登陆密码
#	\用例步骤	通过遥控器菜单配置终端登陆密码
#	\验证点		dmb_system.ini文件内容能够正确修改
##
_test_case_ir_login_pwd()
{	
	check_config_value $CONFIG_PATH/dmb_system.ini "pwd"		""	
	send_ir_key_and_wait "f3:4:ok:8:ok"
	send_ir_key_and_wait "down:ok"
	send_ir_key_and_wait "down:1:2:3:4:5:6:7:2:2"
	send_ir_key_and_wait "down:1:2:3:4:5:6:7:2:2"
	send_ir_key_and_wait "ok:wait3"
	send_ir_key_and_wait "esc:esc:esc"
	check_config_value $CONFIG_PATH/dmb_system.ini "pwd"		"fe008700f25cb28940ca8ed91b23b354"	
	send_ir_key_and_wait "f3:4:ok:8:ok"
	send_ir_key_and_wait "1:ok"
	send_ir_key_and_wait "down:down:down:ok:wait3"
	check_config_value $CONFIG_PATH/dmb_system.ini "pwd"		""	
	send_ir_key_and_wait "esc:esc:esc"
}
##
#	\功能编号 	（暂无）
# \功能说明	终端错误图标
#	\用例步骤	通过遥控器菜单配置终端错误图标开关
#	\验证点		dmb_system.ini文件内容能够正确修改
##
_test_case_ir_config_error_ico()
{	
	check_config_value $CONFIG_PATH/dmb_system.ini "lefttop_show"		"0"	
  send_ir_key_and_wait "f3:4:ok:9:down:down:ok"
	send_ir_key_and_wait "right:ok:wait3"	
	check_config_value $CONFIG_PATH/dmb_system.ini "lefttop_show"		"1"	
	send_ir_key_and_wait "ok:right:ok:wait3"	
	check_config_value $CONFIG_PATH/dmb_system.ini "lefttop_show"		"0"	
}
##
#	\功能编号 	DMB1820-TS-IR-001-F16
# \功能说明	终端系统时间
#	\用例步骤	通过遥控器菜单配置终端系统时间
#	\验证点		终端时间能够正确修改
##
_test_case_ir_config_date()
{	
	MONTH=`date -I | awk -F- '{print $2}'`
	DAY=`date -R | awk  '{print $2}'`
	HOUR=`date  | awk  '{print $4}' | awk -F: '{print $1}'`
	MINUTE=`date  | awk  '{print $4}' | awk -F: '{print $2}'`
	YEAR=`date | awk '{print $6}'`
	
  send_ir_key_and_wait "f3:4:ok:9:ok"
	send_ir_key_and_wait "del:del:del:del:2:0:0:1:down"
	send_ir_key_and_wait "del:del:1:down"
	send_ir_key_and_wait "del:del:1:down"
	send_ir_key_and_wait "del:del:0:down"
	send_ir_key_and_wait "del:del:0:down"
	send_ir_key_and_wait "del:del:0"
	send_ir_key_and_wait "ok:wait3"
	
	debug "`date`"
	if [ ! -z "`date -I  | grep "2001-01-01" `" ] ;
	then
		if [ ! -z "`date  | awk  '{print $4}' | awk -F: '  $1~/00/ && $2~/00/ ' `" ] ;
		then
			debug "set date success"
		else
			debug "now: `date`"
			debug "set date fault"
			TEST_RESULT=0; 	
		fi	
	else
		debug "now: date"
		debug "set date  fault"
		TEST_RESULT=0; 	
	fi
}
##
#	\功能编号 	DMB1820-TS-IR-001-F21
# \功能说明	终端音量
#	\用例步骤	通过遥控器菜单配置终端音量（遍历）
#	\验证点		终端音量能够正确修改
##
_test_case_ir_config_volume()
{
	check_config_value $CONFIG_PATH/dmb_system.ini "volume"		"20"	
	send_key_and_wait  "vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown:vdown"
	sleep 3
	check_config_value $CONFIG_PATH/dmb_system.ini "volume"		"0"	
	
	for i in $(seq 24); do  
		send_key_and_wait "vup"
		sleep 3
		check_config_value $CONFIG_PATH/dmb_system.ini "volume"		$i
 	done
	
	send_key_and_wait  "vdown:vdown:vdown:vdown"
	sleep 3
	check_config_value $CONFIG_PATH/dmb_system.ini "volume"		"20"	
}

