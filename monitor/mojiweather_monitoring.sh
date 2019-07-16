#!/bin/env bash
now=`date +%s`
last_innerupdatedtime=`mysql -hxxxx -uros_service -xxx -e "select * from mojiweather.innercity_weather_history order by updated_at desc limit 1\G;"|grep updated_at|awk '{print $2}'`

last_outerupdatedtime=`mysql -hxxxx -uros_service -xxxx -e "select * from mojiweather.outercity_weather_history order by updated_at desc limit 1\G;"|grep updated_at|awk '{print $2}'`
if [ $(($now-$last_innerupdatedtime)) -gt $((9*3600)) ] || [ $(($now-$last_outerupdatedtime)) -gt $((9*3600)) ];then
  echo 0 > ./mojiweather_status
  exit 1;
else
  echo 1 > ./mojiweather_status
fi
