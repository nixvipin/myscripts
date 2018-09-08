#!/bin/bash

SVC_NAME[0]="httpd"
SVC_NAME[1]="nginx"


SVC_FILE=/tmp/services
SVC_STATUS=/tmp/svc_status

get_running_services()
{
for svc_name in ${SVC_NAME[*]}
do
if pgrep -x "$svc_name" > /dev/null
then
    echo "$svc_name" >>$SVC_FILE
fi
done
}


start_services()
{
for svc_name in `cat /tmp/services`
do
service $svc_name start

if [ $? = 0 ]
then
echo "$svc_name started successfully" >> $SVC_STATUS
else
echo "$svc_name start failed" >> $SVC_STATUS
fi

done


}

case $INPUT_STRING in
	--apply-patch-reboot)
		echo -e "`date`"
                cat $SVC_FILE >> $SVC_FILE-bak
                rm $SVC_FILE $SVC_STATUS
                
		echo "Hello yourself!"
		;;
	--service-start-file)
		echo "See you again!"
		break
		;;
	*)
		echo -e "\n--apply-patch-reboot=Patch apply and reboot\n--service-start-file=Read file and start services"
		;;
esac
