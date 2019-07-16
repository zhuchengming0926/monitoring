#!/bin/bash
curl -XGET "http://storm01:9200/news/newsdata/_search?pretty" -d "
{
  "\"sort"\": {
     "\"storagetime"\": {
       "\"order"\": "\"desc"\"
     }
   }
}" |head -n 50 > ./news.txt

now=`date +%s`
storagetime=`cat news.txt |grep storagetime|awk '{print $3}'|cut -b 1-10`

if [ $(($now-$storagetime)) -gt $((24*3600)) ];then
   echo 0 > ./news_status
   exit 1;
else
   echo 1 > ./news_status
fi
