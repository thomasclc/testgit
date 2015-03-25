##
#  \file       test_set_env.sh
#  \brief      环境变量，测试变量设置脚本
#
#   Copyright (C) 2004-2011 福建星网视易信息系统有限公司
#   All rights reserved by 福建星网视易信息系统有限公司
#
#  \changelog  ：
#   2013年2月3日  创建
##
#!/bin/sh 
export LD_LIBRARY_PATH=/tmp/dmb/lib/             
export CONFIG_PATH=/tmp/config/system
export DMB_DOWNLOAD_PATH=/root/dmb/download
export MG_CFG_PATH=/tmp/flashutils/res/minigui
export DMB_RES_PATH=/tmp/dmb/res
export DMB_WEB_PATH=/tmp/dmb/boa/www/cgi-bin
export DMB_WIRELESS_WIFI_PATH=/tmp/flashutils/wireless/wifi_network
export DMB_WIRELESS_3G_PATH=/tmp/flashutils/wireless/3g_network

TEST_LOCAL_IP="`ifconfig | grep "inet addr:" | grep -v  127.0.0.1 | awk -F: '{print $2}' | awk '{print $1}'`"

WAIT_TIME=30
WAIT_QUIT_TIME=5
PID_LIST= 
KILL_PAR=-USR1

DMB_PATH=/tmp/dmb/program/  
DMB_NAME=dmb_main
DMB_PID=
DMB_LOG_PATH=/root/dmb/log
LOG_NAME=dmb_log

SERVER_PATH=$DMB_PATH/dmb_server
SERVER_MSG_PATH=$SERVER_PATH/msg
SERVER_XML_PATH=$SERVER_PATH/xml
SERVER_NAME=dmb_server
SERVER_PID=
#TEST_DATETIME=`(date   +%Y%m%d)2>&1`  
TEST_XML_DIR=./test_net_msg/test_xml
TEST_PLAYLIST_DIR=./test_play/test_playlist_xml
TEST_DATETIME=test_log
TEST_DIR=$TEST_DATETIME/
TEST_LOG_PATH=./log
TEST_ERROR_LOG_PATH=./error_log
TEST_DMB_LOG=$TEST_NAME.log
TEST_LOG_OUT=$TEST_NAME.about
TEST_LOG_ERR=$TEST_NAME.error
TEST_LOG_RES=$TEST_NAME.result

TEST_INFO_FILE_PATH=$CURRENT_PATH/config_file_info

##TEST_RESULT( 1=success : 0=fail )
TEST_RESULT=1  
TEST_RESULT_LOG=./test_result


NEED_CHECK_PATH=
LOG_CONFIG=$DMB_PATH/log4crc
LOCAL_CONFIG_PATH=/tmp/config/
LOCAL_CONFIG_SYSTEM_PATH=$LOCAL_CONFIG_PATH/system
LOCAL_LIB_PATH=/tmp/dmb/lib/
LOCAL_3G_DB_FILE_PATH=/

LOCAL_CURL_PATH=/tmp/dmb/program/curl-bin/curl
TEST_BOA_PWD="admin:"
TEST_KEY_PATH=$DMB_PATH/test_ir_key

if [ "`cat /tmp/flashutils/product | grep 1320`" ] ; then
	#TEST_PRODUCT=1320
	TEST_PRODUCT=1820
elif [ "`cat /tmp/flashutils/product | grep 1620`" ] ; then
	#TEST_PRODUCT=1620
	TEST_PRODUCT=1820
elif [ "`cat /tmp/flashutils/product | grep 1820`" ] ; then
	TEST_PRODUCT=1820
elif [ "`cat /tmp/flashutils/product | grep 2810`" ] ; then
	TEST_PRODUCT=2810
fi

TEST_IR_KEY_FILE_NAME="key_value_"$TEST_PRODUCT".ini"