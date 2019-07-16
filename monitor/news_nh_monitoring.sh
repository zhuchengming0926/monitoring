#!/bin/bash
cd /roobo/server/monitoring
curl -XGET "http://storm01:9200/news/newsdata/_search?pretty" -d "
{
 "\"query"\": {
   "\"term"\": {
     "\"reader"\": {
       "\"value"\": "\"听闻晚高峰"\"
     }
   }
 },
 "\"sort"\": {
     "\"storagetime"\": {
       "\"order"\": "\"desc"\"
     }
   }
}"|head -n 35 > news_nh.txt

now=`date +%s`
last_storagetime=`cat news_nh.txt |grep storagetime|awk '{print $3}'|cut -b 1-10`

#新闻晚高峰监控
if [ $(($now-$last_storagetime)) -gt $((2*3600)) ];then
   echo 0 > ./news_nh_status
   exit 1;
else
   echo 1 > ./news_nh_status
fi

