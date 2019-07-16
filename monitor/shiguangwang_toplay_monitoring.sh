#!/bin/bash
curl -XGET 'http://storm01:9200/shiguangwang_index/shiguangwang_toplay_type/_search?pretty'|head -n 25 > ./shiguangwang_toplay.txt
today=`date "+%Y-%m-%d"`
yesterday=`date -d -1day "+%Y-%m-%d"`
date=`cat shiguangwang_toplay.txt |grep date|awk -F '\"' '{print $4}'`

if [ $today == $date ] || [ $yesterday == $date ];then
    echo 1 > ./shiguangwang_toplay_status
else
    echo 0 > ./shiguangwang_toplay_status
    exit 1
fi
