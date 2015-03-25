##
#  \file       test_ready.sh
#  \brief      测试环境搭建用脚本
#
#   Copyright (C) 2004-2011 福建星网视易信息系统有限公司
#   All rights reserved by 福建星网视易信息系统有限公司
#
#  \changelog  ：
#   2013年12月3日  创建
##

#!/bin/sh
if [ "`cat /tmp/flashutils/product | grep 1320`" ] ; then
	TEST_PRODUCT=1820
elif [ "`cat /tmp/flashutils/product | grep 1620`" ] ; then
	TEST_PRODUCT=1820
elif [ "`cat /tmp/flashutils/product | grep 1820`" ] ; then
	TEST_PRODUCT=1820
elif [ "`cat /tmp/flashutils/product | grep 2810`" ] ; then
	TEST_PRODUCT=2810
fi


if [  "$TEST_PRODUCT" != "2810" ] && [  "$TEST_PRODUCT" != "1820" ] ; then 
	echo 'error type!!'
	exit
fi

. ./test_set_env.sh
rm  -rf ./test_ready_file
cp  -rf ./test_ready_file_$TEST_PRODUCT  ./test_ready_file

echo "copy dmb_server" 
if [ ! -d $SERVER_PATH ] ; then 
	mkdir -p $SERVER_PATH
fi
cp -rf ./test_ready_file/dmb_server/*  $SERVER_PATH/
cp $SERVER_PATH/dmb_msg_map.ini   $LOCAL_CONFIG_SYSTEM_PATH

echo "copy curl lib"
cp -rf  ./test_ready_file/curl-lib/*  $LD_LIBRARY_PATH/ 

cp -rf  ./test_ready_file/curl-bin $DMB_PATH

cp -rf ./test_ready_file/log4crc   $DMB_PATH
cp -rf ./test_ready_file/rundmb		 $DMB_PATH

if [  "$TEST_PRODUCT" = "1820" ]  ; then 
	cp -rf ./test_ready_file/dmb_load_drv   $DMB_PATH
fi

sync