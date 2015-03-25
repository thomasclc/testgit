#!/bin/sh
##set env
export LD_LIBRARY_PATH=/tmp/dmb/lib/
export CONFIG_PATH=/tmp/config/system
export DMB_DOWNLOAD_PATH=/root/dmb/download
export MG_CFG_PATH=/tmp/flashutils/res/minigui
export DMB_RES_PATH=/tmp/dmb/res
export DMB_WEB_PATH=/tmp/dmb/boa/www/cgi-bin
export DMB_WIRELESS_WIFI_PATH=/tmp/flashutils/wireless/wifi_network
export DMB_WIRELESS_3G_PATH=/tmp/flashutils/wireless/3g_network

BOX_TYPE=sigma
if [ "`cat /tmp/flashutils/product | grep 2810`" ] ; then
	BOX_TYPE=brcm
fi
SERVER_PATH="./dmb_server_"$BOX_TYPE
SERVER_XML_SEND_PATH=$SERVER_PATH/xml/loop_xml

cp $SERVER_PATH/dmb_msg_map.ini   $CONFIG_PATH
rm $SERVER_XML_SEND_PATH/*

##funtion
send_msg_and_wiat()
{
	xml_name="$1"
	
	cp ./$xml_name  $SERVER_XML_SEND_PATH/
	while [ -f $SERVER_XML_SEND_PATH/$xml_name ] ; do
		echo "wait for sending  $SERVER_XML_SEND_PATH/$xml_name..."
		sleep	5
	done
	echo "wait 10s for comeing into effect"
	sleep 5
}

##


cd  $SERVER_PATH
./dmb_server &
cd -

send_msg_and_wiat "ftp.xml"
send_msg_and_wiat "playlist_movies.xml"

killall -9 dmb_server
