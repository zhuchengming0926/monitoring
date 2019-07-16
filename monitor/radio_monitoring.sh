#!/bin/bash

now=`date +%s`
last_storagetime=`mysql -hros-user.mysql.rds.aliyuncs.com -uradio_info -pE9h6vJ2wxWqdSDJw -e "set names utf8;select * from service_radio.radio_info order by storagetime desc limit 1\G;"|grep storagetime|awk '{print $2}'|cut -b 1-10`

if [ $(($now-$last_storagetime)) -gt $((3*3600)) ];then
   echo 0 > ./radio_status
   exit 1;
else
   echo 1 > ./radio_status
fi
