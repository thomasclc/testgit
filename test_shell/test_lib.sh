##
#  \file       test_lib.sh
#  \brief      测试脚本通用方法提供脚本
#
#   Copyright (C) 2004-2011 福建星网视易信息系统有限公司
#   All rights reserved by 福建星网视易信息系统有限公司
#
#  \changelog  ：
#   2013年2月3日  创建
##
#!/bin/sh
#调试信息打印的同时记录到当前脚本日志中
debug()
{
	echo "$1"
	test_log_path="`cat $TEST_LOG_PATH/test.info | awk -F= '$1~/logs_path/  {print $2}'`"
	echo "$1" >>$test_log_path".result"
}

#对比值，错误时影响结果标志
cmp_vale()
{
	if [ "$1" = "$2" ]
	then 
			debug 'test :---same' 
	else
			debug 'test :------ERROR :'"$1 != $2"
			TEST_RESULT=0 ;
	fi
}



file_md5_compare()
{
###check params
	if [ ! $1 ];then
		debug "$1 is not passed!"
		TEST_RESULT=0;
		return 1
	fi
	if [ ! $2 ];then
		debug "$2 is not passed!"
		TEST_RESULT=0;
		return 1
	fi
####check files
	if [ ! -f $1 ];then
		debug "$1 is no exited!"
		TEST_RESULT=0
		return 1
	fi
	if [ ! -f $2 ];then
		debug "$2 is no exited!"
		TEST_RESULT=0
		return 1
	fi
	f_md5=`md5sum $1 | awk '{print $1}'`
	s_md5=`md5sum $2 | awk '{print $1}'`
#echo $f_md5 $s_md5
	if [ $f_md5 = $s_md5 ];then
		debug "---md5 same :"
		debug "$1"
		debug "$2"
	else
		debug "------------ERROR : md5 diff"
		debug "$1 : $f_md5" 
		debug "$2 : $s_md5"
		TEST_RESULT=0
	fi
}

check_log_text(){   
	test_string=$1
	if [ -z "`cat $TEST_LOG_PATH/$TEST_DMB_LOG  | grep "$test_string" `" ];
	then 
		debug 'test:------------ERROR : log file $TEST_DMB_LOG  miss text :'"$test_string"
		TEST_RESULT=0;
	else 
		debug 'test:check text success : '"$test_string"
	fi
}
##$1=text file name     $2=check string
check_text(){
	if [ -z "` cat "$1" | grep "$2" `" ];
	then 
		debug "------------ERROR : file $1 miss text $2" 
		TEST_RESULT=0;
	else 
		debug "---check text success : $2"
	fi
}
delete_config()
{
	test_config_name="$1"
	test_config_file_path="$2"
	
	cat $test_config_file_path  | awk -F=  -v key=$test_config_name '$1 != $key { print }' > $test_config_file_path.tmp
	mv  $test_config_file_path.tmp $test_config_file_path
}

##$1=text file name     $2=check string
check_no_text()
{
	if [ ! -z "` cat "$1" | grep "$2" `" ];
	then 
		debug "------------ERROR : file  $1 have text $2"
#		debug "`cat $1`" 
		TEST_RESULT=0;
	else 
		debug "---check no text success :  $2"
	fi
}



get_config_ini_value()
{
	if [ -f $1 ];then
		awk -F= -v tmpkey="$2"  ' $1==tmpkey {print $2} '  $1  ;
	else 
		echo NULL ;
	fi
}
#$1=config file $2=value name $3=value
check_config_value()
{
	config_value=`get_config_ini_value "$1" "$2"`
	debug "get config $2 = $config_value (file:$1)"
	cmp_vale "$config_value" "$3"	
}
#$1=file path   $2=md5 value
check_file_md5()
{
	debug "file:$1"
	f_md5=`md5sum $1 | awk '{print $1}'`
	cmp_vale $f_md5  $2
}

#$1= dir path
check_dir_exist()
{
	if [ -d $1 ] ;
	then
		debug "---dir exist : $1"
	else
		debug "------ERROR :dir no exist : $1"
		TEST_RESULT=0
	fi
}

check_file_exist()
{
	if [ -f $1 ] ;
	then
		debug "---file exist : $1"
	else
		debug "------ERROR :file no exist : $1"
		TEST_RESULT=0
	fi
}

get_cgi_value()
{
	if [ -f $1 ];then
		cat $1 | sed 's/,/\n/g' |  awk -F: -v tmpkey="$2"  ' $1==tmpkey {print $2} ' |  sed 's/"//g' ;
	else
		echo NULL ;
	fi
}

set_config_ini_value(){
	if [ -f $1 ];then
		old_v=`cat $1 | awk -F= -v val="$2" '$1==val {print}'`
	if [ ! -z $old_v ];then
		sed -i "s/$old_v/$2=$3/g" $1 
		debug "set $1:$2=$3"
	else
		debug "can not find $2 in $1"
	fi
	else 
		debug "can not find $1 "
	fi
}

test_check_result()
{
	TEST_NAME="`cat $TEST_LOG_PATH/test.info | awk -F= '$1~/test_name/  {print $2}'`"
	TEST_CASE_NAME="`cat $TEST_LOG_PATH/test.info | awk -F= '$1~/case_name/  {print $2}'`"
	if [ $TEST_RESULT = 1 ] ;
	then
			debug "test : $TEST_NAME $TEST_CASE_NAME success"
			echo  "test : $TEST_NAME $TEST_CASE_NAME -vvv-success" >> $TEST_RESULT_LOG 
	else
			debug "test : $TEST_NAME $TEST_CASE_NAME fail"		
			echo  "test : $TEST_NAME $TEST_CASE_NAME -xxx-fail" >> $TEST_RESULT_LOG 
			test_log_path="`cat $TEST_LOG_PATH/test.info | awk -F= '$1~/logs_path/  {print $2}'`"
	#		cp test_log_path $TEST_ERROR_LOG_PATH_`date`
	fi
}

test_get_config_info()
{	
	#clean
	if [ ! -d $TEST_INFO_FILE_PATH ] ; then 
		mkdir -p 	$TEST_INFO_FILE_PATH
	else
		rm $TEST_INFO_FILE_PATH/*.now
		rm $TEST_INFO_FILE_PATH/*.old
	fi
#ready	
	ls -l /tmp/config/system  >> $TEST_INFO_FILE_PATH/system_info.old
	ls -l /tmp/config/terminal  >> $TEST_INFO_FILE_PATH/terminal_info.old
	ls -l /tmp/config/systembak  >> $TEST_INFO_FILE_PATH/systembak_info.old
}

check_config_info()
{
#check result	
	test_flag=$TEST_RESULT
	TEST_RESULT=1
	ls -l /tmp/config/system  >> $TEST_INFO_FILE_PATH/system_info.now
	file_md5_compare $TEST_INFO_FILE_PATH/system_info.now $TEST_INFO_FILE_PATH/system_info.old
	if [ $TEST_RESULT = 0 ] ; then 
		debug "$TEST_INFO_FILE_PATH/system_info.old"
		debug "`cat $TEST_INFO_FILE_PATH/system_info.old`"
		debug "$TEST_INFO_FILE_PATH/system_info.now"
		debug "`cat $TEST_INFO_FILE_PATH/system_info.now`"		
		test_flag=0
		TEST_RESULT=1
	fi
	ls -l /tmp/config/terminal  >> $TEST_INFO_FILE_PATH/terminal_info.now
	file_md5_compare $TEST_INFO_FILE_PATH/terminal_info.now $TEST_INFO_FILE_PATH/terminal_info.old
	if [ $TEST_RESULT = 0 ] ; then 
		debug "$TEST_INFO_FILE_PATH/terminal_info.old"
		debug "`cat $TEST_INFO_FILE_PATH/terminal_info.old`"
		debug "$TEST_INFO_FILE_PATH/terminal_info.now"
		debug "`cat $TEST_INFO_FILE_PATH/terminal_info.now`"		
		test_flag=0
		TEST_RESULT=1
	fi
	ls -l /tmp/config/systembak  >> $TEST_INFO_FILE_PATH/systembak_info.now
	file_md5_compare $TEST_INFO_FILE_PATH/systembak_info.now $TEST_INFO_FILE_PATH/systembak_info.old
	if [ $TEST_RESULT = 0 ] ; then 
		debug "$TEST_INFO_FILE_PATH/systembak_info.old"
		debug "`cat $TEST_INFO_FILE_PATH/systembak_info.old`"
		debug "$TEST_INFO_FILE_PATH/systembak_info.now"
		debug "`cat $TEST_INFO_FILE_PATH/systembak_info.now`"		
		test_flag=0
		TEST_RESULT=1
	fi
	TEST_RESULT=$test_flag
#clean
	rm  -rf $TEST_INFO_FILE_PATH
}

send_msg_and_wiat()
{
	xml_name="$1"
	
	cp $TEST_XML_DIR/$xml_name  $SERVER_XML_PATH/loop_xml/
	while [ -f $SERVER_XML_PATH/loop_xml/$xml_name ] ; do
		debug "wait for sending $SERVER_XML_PATH/loop_xml/$xml_name..."
		sleep	10
	done
	debug "wait 10s for comeing into effect"
	sleep 10
}


curl_get()
{
	cgi_file_name=$1
	test_log_path="`cat $TEST_LOG_PATH/test.info | awk -F= '$1~/logs_path/  {print $2}'`"_"`cat $TEST_LOG_PATH/test.info | awk -F= '$1~/case_name/  {print $2}'`"

	rm $test_log_path.get
	$LOCAL_CURL_PATH  -u$TEST_BOA_PWD  $TEST_LOCAL_IP/cgi-bin/$cgi_file_name -o$test_log_path".get"

	if [ ! -z "`cat $test_log_path".get" | grep '404 Not Found'`" ]  ; then		
		debug '------ERROR : curl get fail !'
		TEST_RESULT=0
	else 
		debug 'curl get success !'
	fi

}

curl_set()
{
	cgi_file_name=$1
	curl_par_d=$2
	test_log_path="`cat $TEST_LOG_PATH/test.info | awk -F= '$1~/logs_path/  {print $2}'`"_"`cat $TEST_LOG_PATH/test.info | awk -F= '$1~/case_name/  {print $2}'`"

	rm $test_log_path.set
	$LOCAL_CURL_PATH  -u$TEST_BOA_PWD  $TEST_LOCAL_IP/cgi-bin/$cgi_file_name  -d$curl_par_d -o$test_log_path".set"

	if [ ! -z "`cat $test_log_path".set" | grep 'id_configsuccess'`" ] ; then
		debug 'curl set success !'
	else 
		debug '------ERROR : curl set fail !'
		TEST_RESULT=0
	fi
}

check_curl_get_result()
{
	config_file_name=$1
	config_name=$2
	curl_value_name=$3
	test_log_path="`cat $TEST_LOG_PATH/test.info | awk -F= '$1~/logs_path/  {print $2}'`"_"`cat $TEST_LOG_PATH/test.info | awk -F= '$1~/case_name/  {print $2}'`"
	cgi_value="`cat $test_log_path".get" | sed 's/,/\n/g' |  awk -F: -v tmpkey="$3"  ' $1==tmpkey {print $2} ' |  sed 's/"//g'`"
	debug "curl get result : $2=$cgi_value"
	check_config_value $1 $2 $cgi_value
}

send_key_and_wait()
{
	key_value=$1
	debug "test_key=$key_value"
	echo "$key_value" > $TEST_KEY_PATH
	while [ -f $TEST_KEY_PATH ] ; do
		debug "wait for doing key..."
		sleep 10
	done
	debug "finish"
}

send_ir_key_and_wait()
{
	key_name=$1
	key_value=`get_config_ini_value ./test_ir/$TEST_IR_KEY_FILE_NAME $key_name`
	
	if [ "x$key name" = "x" ] ;then
		debug "can not find the key value of $key name"
	else
		debug "$key name : $key_value"
		send_key_and_wait $key_value
	fi
}

send_playlist()
{
	playlist_name="$1"
	
	cp $TEST_PLAYLIST_DIR/$playlist_name  $SERVER_XML_PATH/loop_xml/
	while [ -f $SERVER_XML_PATH/loop_xml/$playlist_name ] ; do
		debug "wait for sending $SERVER_XML_PATH/loop_xml/$playlist_name..."
		sleep	10
	done
}


wait_for_dmb_log()
{
	log_string=$1
	
	while [ -z "`awk -F^ -v val=$log_string ' $2 ~val { print   }' $DMB_LOG_PATH/$LOG_NAME.*`"  ] ;    
	do
    debug "wait for $log_string"
    sleep 10 
  done
}

check_net_msg_report()
{
	net_msg_name="$1"
	check_text_value="$2"
	if [ x"`awk '{{printf"%s",$0}}'  $SERVER_MSG_PATH/"$net_msg_name".xml | grep "$2"`" = x ] ; then 
		debug "can not find report text:$2"
		TEST_RESULT=0
	else
		debug "check net massage success:$2"
	fi
}

check_date_text()
{
	test_text=$1
	debug "`date`"
	if [ ! -z "`date +%Y%m%d%H%M%S  | grep "$test_text" `" ] ;
	then
		debug "set date success"
	else
		debug "now: ""`date`"
		debug "set date  fault"
		TEST_RESULT=0; 	
	fi
}


