##
#  \file       run.sh
#  \brief      测试脚本运行调度脚本
#
#   Copyright (C) 2004-2011 福建星网视易信息系统有限公司
#   All rights reserved by 福建星网视易信息系统有限公司
#
#  \changelog  ：
#   2013年2月3日  创建
##
#!/bin/sh

. ./test_set_env.sh
. ./test_lib.sh

echo "run test"

run_test_case()
{
	test_file=$1
	test_case=$2
	
	. $test_file	  
	
	test_name=`echo $test_file |awk -F\/ ' {print $NF} ' | sed 's/.\///g' | sed 's/\.sh//g'`
	#creat the logfile
	if [ -f $TEST_LOG_PATH/"$test_name".result ] ; then
		rm $TEST_LOG_PATH/"$test_name".result
	fi
	touch  $TEST_LOG_PATH/"$test_name".result
	
	rm  $TEST_LOG_PATH/test.info
	if [ $test_case ] ;
	then
		echo "test_name=$test_name" >  $TEST_LOG_PATH/test.info
		echo "test_path=$test_file" >> $TEST_LOG_PATH/test.info
		echo "case_name=$test_case" >> $TEST_LOG_PATH/test.info
		echo "logs_path=$TEST_LOG_PATH/"$test_name >> $TEST_LOG_PATH/test.info
		debug "--- do case: $test_case ---"
		before_class
		before_case
		$test_case
		after_case
		#check test result after test case
		test_check_result
		TEST_RESULT=1
		after_class
	else
		#run all of the file's test cases
		echo "test_name=$test_name" >  $TEST_LOG_PATH/test.info
		echo "test_path=$test_file" >> $TEST_LOG_PATH/test.info
		echo "all_case_name=`cat  $test_file  | grep '\<_test_' | grep '\(\)\>'`" >> $TEST_LOG_PATH/test.info				
		echo "logs_path=$TEST_LOG_PATH/"$test_name >> $TEST_LOG_PATH/test.info		
		before_class
		for fun_name in `cat  $test_file  | grep '\<_test_' | grep '\(\)\>'` ;
		do	
			case_name=`echo $fun_name | sed 's/..$//' `
			echo "test_name=$test_name" >  $TEST_LOG_PATH/test.info
			echo "test_path=$test_file" >> $TEST_LOG_PATH/test.info
			echo "case_name=$case_name" >> $TEST_LOG_PATH/test.info				
			echo "logs_path=$TEST_LOG_PATH/"$test_name >> $TEST_LOG_PATH/test.info	 
			debug "--- do case: $case_name ---"
			before_case
			$case_name
			after_case	
			#check test result after test case
			test_check_result
			TEST_RESULT=1
		done
		after_class
	fi
	#delete the test infomation
	
	
}

#shall main

if [ $# = 0 ] ; then
  echo "Usage: run.sh [-d] [-f] [-c]"
  echo "-d test dir path"
  echo "-f test class file path"
  echo "-c test case name"
	exit 1
fi


#
set -- `getopt -q d:f:c: $@`
while [ -n "$1" ]  
do  
  case "$1" in  
  -d)
	   test_dir=$2
	   test_dir=`echo "$test_dir" | sed "s/'//g"`
     echo "test_dir=$test_dir"
     shift 2;;
  -f)
	   test_file=`basename $2`
     test_dir=`dirname $2`
     test_file=`echo "$test_file" | sed "s/'//g"`
     test_dir=`echo "$test_dir" | sed "s/'//g"`
     echo "test_dir=$test_dir"
		 echo "test_file=$test_file"
     shift 2;;
  -c)
     test_case=$2
     test_case=`echo "$test_case" | sed "s/'//g"`
		 echo "test_case=$test_case"
     shift 2;;
  *)
     shift ;;
  esac
done  
#

if [ ! -d $TEST_LOG_PATH ];then
		mkdir -p $TEST_LOG_PATH
fi
TEST_RESULT=1

if [ $test_file ] && [ $test_dir ] ; then 
	. $test_dir/test_before_after.sh
	before_test
	run_test_case $test_dir/$test_file $test_case
	after_test
elif [ $test_dir ] ; then
	. $test_dir/test_before_after.sh
	before_test
	for test_case_file in `ls $test_dir/test_class*`
	do
		echo $test_case_file
		run_test_case $test_case_file
	done
	after_test
else 
	echo 'no test can be done'
fi