##
#  \file       global_test_boa.sh
#  \brief      boa测试脚本通用方法提供脚本
#
#   Copyright (C) 2004-2011 福建星网视易信息系统有限公司
#   All rights reserved by 福建星网视易信息系统有限公司
#
#  \changelog  ：
#   2013年12月3日  创建
##

#!/bin/sh
#. ../global.sh
CURL=$CURRENT_PATH/curl-bin/curl 
USERPW=admin:
BOAIP="`get_config_ini_value /tmp/config/system/dmb_eth0.ini "static_ip"`"
SET_OUTPUT="$TEST_LOG_PATH/$TEST_DMB_LOG".set
GET_OUTPUT="$TEST_LOG_PATH/$TEST_DMB_LOG".get
CGIPATH=cgi-bin
LOCAL_CONFIG_FILE_NAME=
LOCAL_CONFIG_FILE=$LOCAL_CONFIG_SYSTEM_PATH/$LOCAL_CONFIG_FILE_NAME
GET_URL=
SET_URL=
GET_CGI_FILE_NAME=
SET_CGI_FILE_NAME=

CURL_PAR_D=
##$1=config name  $2=curl name 
check_curl_result()
{
	cgi_value=`get_cgi_value "$GET_OUTPUT" $2`
	check_config_value $LOCAL_CONFIG_FILE $1 $cgi_value
}

test_boa_clean_env()
{
	if [ -d $TEST_LOG_PATH ];then
 	 	debug "clean $TEST_LOG_PATH/$TEST_NAME.*"
		rm $TEST_LOG_PATH/$TEST_NAME.*
	fi
}
test_boa_test_ready()
{
	echo test_boa_test_ready
	if [ -z "` ps x | grep "./boa" `" ] ;
	then
		cd $DMB_WEB_PATH/../..
		ls
		./startboa
		cd -
	fi
}
test_boa_test_reload()
{
	echo test_boa_test_reload
}

test_boa_run_process()
{
	if [ $CGIPATH ];then
		GET_URL=$BOAIP/$CGIPATH/$GET_CGI_FILE_NAME
		SET_URL=$BOAIP/$CGIPATH/$SET_CGI_FILE_NAME
	else
		GET_URL=$BOAIP/$GET_CGI_FILE_NAME
		SET_URL=$BOAIP/$SET_CGI_FILE_NAME	
	fi

	if [ $SET_CGI_FILE_NAME	 ]; then
		$CURL -u$USERPW $SET_URL -d$CURL_PAR_D -o$SET_OUTPUT 
	fi
	if [ $GET_CGI_FILE_NAME ] ; then
		$CURL -u$USERPW $GET_URL -o$GET_OUTPUT 
	fi
	if [ $CURL_PAR_D  ] ;
	then
		debug "path = -d $CURL_PAR_D"
	else 
		debug "path = NULL"
	fi	
}
test_boa_check_result()
{
	if [ $SET_CGI_FILE_NAME	 ]; then
		if [ ! -s $SET_OUTPUT ];  
		then   					
			debug "------ERROR : curl set fail !"
			TEST_RESULT=0;
		else
			if [ ! -z "`cat $SET_OUTPUT | awk '/id_configsuccess/'`" ] ;
			then
				debug "curl set success !";
			else 
				debug "------ERROR : curl set fail !"
				TEST_RESULT=0;
			fi
		fi
	fi
	if [ $GET_CGI_FILE_NAME	 ]; then
		if [ ! -s $GET_OUTPUT ];  
		then   					
			debug "------ERROR : curl get fail !"
			TEST_RESULT=0;
		else
			debug "curl get success !";
		fi
	fi	
}
#测试相同配置值则存入配置文件
test_boa_check_writer_config()
{
	test_get_config_info
#run&quite	
	if [ $CGIPATH ];then
		GET_URL=$BOAIP/$CGIPATH/$GET_CGI_FILE_NAME
		SET_URL=$BOAIP/$CGIPATH/$SET_CGI_FILE_NAME
	else
		GET_URL=$BOAIP/$GET_CGI_FILE_NAME
		SET_URL=$BOAIP/$SET_CGI_FILE_NAME	
	fi
	if [ $SET_CGI_FILE_NAME	 ]; then
		$CURL -u$USERPW $SET_URL -d$CURL_PAR_D 
	fi
	if [ $GET_CGI_FILE_NAME ] ; then
		$CURL -u$USERPW $GET_URL 
	fi
	if [ $CURL_PAR_D  ] ;
	then
		debug "path = -d $CURL_PAR_D"
	else 
		debug "path = NULL"
	fi	
#check
 	check_config_info
}