##
#  \file       test_class_ir.sh
#  \brief      ң��������Խű�����ҪΪf3�˵�����
#
#   Copyright (C) 2004-2011 ��������������Ϣϵͳ���޹�˾
#   All rights reserved by ��������������Ϣϵͳ���޹�˾
#
#  \changelog  ��
#   2013��2��3��  ����
##
#!/bin/sh
before_class()
{
	killall -9 dmb_main
	rm $DMB_LOG_PATH/*
	rm /root/dmb/playlist/*
	
#����ΪĬ������
	rm -rf  /tmp/system.bak
	cp -rf  /tmp/config/system  /tmp/system.bak
	cp defaule_config/* /tmp/config/system/
	chmod 777 /tmp/config/system/*	
	sync

#�������Գ���	
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
#	\���ܱ�� 	
# \����˵��	�ն˷�������ʱ��(1825�汾)
#	\��������	ͨ��ң�����˵��������޸�����
#	\��֤��		ÿ�ζ����޸ĳɹ�
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
