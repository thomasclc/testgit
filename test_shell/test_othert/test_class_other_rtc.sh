##
#  \file       test_class_other_rtc.sh
#  \brief      rtc���ܲ���
#
#   Copyright (C) 2004-2011 ��������������Ϣϵͳ���޹�˾
#   All rights reserved by ��������������Ϣϵͳ���޹�˾
#
#  \changelog  ��
#   2014��6��9��  ����
##
#!/bin/sh
before_class()
{
	
	MONTH=`date -I | awk -F- '{print $2}'`
	DAY=`date -R | awk  '{print $2}'`
	HOUR=`date  | awk  '{print $4}' | awk -F: '{print $1}'`
	MINUTE=`date  | awk  '{print $4}' | awk -F: '{print $2}'`
	YEAR=`date | awk '{print $6}'`
	
	if [ -z "`ps | grep watchdog`" ] ; then
		watchdog > /dev/null  &
	fi
}

after_class()
{
	debug "reload date `date $MONTH$DAY$HOUR$MINUTE$YEAR`"
}
before_case()
{
	echo "before_case"
}

after_case()
{
	echo "after_case"
}


##
#	\���ܱ�� 	
# \����˵��	�ն˳���rtc����ʧ�ܵ�����
#	\��������	��������rtcʱ��
#	\��֤��		ÿ�ζ�����ȷ����
##

_test_case_other_rtc_set_date()
{
	while [ 1 ] ; do
		date 020209012002
		/tmp/dmb/program/rtc R > /dev/null
		sleep 2
		/tmp/dmb/program/rtc S > ./tmp
		
		while [ "`cat ./tmp | grep 'date' `"x = x ] ; do 
			sleep 1
		done
		
		if [ ! -z "`cat ./tmp | grep 'date -u 020201012002' `" ] ;
		then
			debug "set date success"
		else
			debug "now: `cat ./tmp`"
			debug ":date -u 020201012002"
			debug "set date fault"
			TEST_RESULT=0;
			break 	
		fi
		
		date 030311012013
		/tmp/dmb/program/rtc R > /dev/null
		sleep 2
		/tmp/dmb/program/rtc S > ./tmp
		

		
		
		if [ ! -z "`cat ./tmp | grep 'date -u 030303012013' `" ] ;
		then
			debug "set date success"
		else
			debug "now: `cat ./tmp`"
			debug ":date -u 030303012002"
			debug "set date fault"
			TEST_RESULT=0;
			break 	
		fi
	done	

}
