#!/bin/bash
cd /roobo/server/monitoring

#elasticsearch存活监控
/roobo/server/jdk1.8.0_131/bin/jps | grep Elasticsearch > /dev/null 2>&1
if [ $? -eq 0 ];then
   echo 1 > ./running_status
   echo `date "+%Y-%m-%d %H:%M:%S"`" es is running" >> ./monitoring_running.log
else
   echo 0 > ./running_status
   echo `date "+%Y-%m-%d %H:%M:%S"`" es is not running" >> ./error.log
   exit 1
fi

#storm nimbus存活监控
/roobo/server/jdk1.8.0_131/bin/jps | grep nimbus > /dev/null 2>&1
if [ $? -eq 0 ];then
   echo 1 > ./running_status
   echo `date "+%Y-%m-%d %H:%M:%S"`" storm nimbus is running" >> ./monitoring_running.log
else
   echo 0 > ./running_status
   echo `date "+%Y-%m-%d %H:%M:%S"`" storm nimbus is not running" >> ./error.log
   exit 1
fi

#storm supervisor存活监控
/roobo/server/jdk1.8.0_131/bin/jps | grep supervisor > /dev/null 2>&1
if [ $? -eq 0 ];then
   echo 1 > ./running_status
   echo `date "+%Y-%m-%d %H:%M:%S"`" storm supervisor is running" >> ./monitoring_running.log
else
   echo 0 > ./running_status
   echo `date "+%Y-%m-%d %H:%M:%S"`" supervisor is not running" >> ./error.log
   exit 1
fi

#zookeeper存活监控
/roobo/server/jdk1.8.0_131/bin/jps | grep QuorumPeerMain > /dev/null 2>&1
if [ $? -eq 0 ];then
   echo 1 > ./running_status
   echo `date "+%Y-%m-%d %H:%M:%S"`" zookeeper is running" >> ./monitoring_running.log
else
   echo 0 > ./running_status
   echo `date "+%Y-%m-%d %H:%M:%S"`" zookeeper is not running" >> ./error.log
   exit 1
fi

#kafka存活监控
/roobo/server/jdk1.8.0_131/bin/jps | grep Kafka > /dev/null 2>&1
if [ $? -eq 0 ];then
   echo 1 > ./running_status
   echo `date "+%Y-%m-%d %H:%M:%S"`" kafka is running" >> ./monitoring_running.log
else
   echo 0 > ./running_status
   echo `date "+%Y-%m-%d %H:%M:%S"`" kafka is not running" >> ./error.log
   exit 1
fi

#新闻数据更新监控
sh ./news_monitoring.sh
news_status=`cat news_status` 
if [ $news_status -eq 0 ];then
   echo 0 > ./running_status
   echo `date "+%Y-%m-%d %H:%M:%S"`" news data is not updata" >> ./error.log
   exit 1;
else
   echo 1 > ./running_status
   echo `date "+%Y-%m-%d %H:%M:%S"`" news data is updata" >> ./monitoring_running.log
fi

#新闻晚高峰数据更新监控
news_nh_status=`cat news_nh_status`
if [ $news_nh_status -eq 0 ];then
   echo 0 > ./running_status
   echo `date "+%Y-%m-%d %H:%M:%S"`" news night higth data is not updata" >> ./error.log
   exit 1;
else
   echo 1 > ./running_status
   echo `date "+%Y-%m-%d %H:%M:%S"`" news night data monitoring is running" >> ./monitoring_running.log
fi

#shiguangwang_toplay数据更新监控
sh ./shiguangwang_toplay_monitoring.sh
shiguangwang_toplay_status=`cat shiguangwang_toplay_status` 
if [ $shiguangwang_toplay_status -eq 0 ];then
   echo 0 > ./running_status
   echo `date "+%Y-%m-%d %H:%M:%S"`" shiguangwang_toplay data is not updata" >> ./error.log
   exit 1;
else
   echo 1 > ./running_status
   echo `date "+%Y-%m-%d %H:%M:%S"`" shiguangwang_toplay data is updata" >> ./monitoring_running.log
fi

#radio数据更新监控
sh ./radio_monitoring.sh
radio_status=`cat radio_status` 
if [ $radio_status -eq 0 ];then
   echo 0 > ./running_status
   echo `date "+%Y-%m-%d %H:%M:%S"`" radio data is not updata" >> ./error.log
   exit 1;
else
   echo 1 > ./running_status
   echo `date "+%Y-%m-%d %H:%M:%S"`" radio data is updata" >> ./monitoring_running.log
fi

#mojiweather数据更新监控
sh ./mojiweather_monitoring.sh
mojiweather_status=`cat mojiweather_status`
if [ $mojiweather_status -eq 0 ];then
   echo 0 > ./running_status
   echo `date "+%Y-%m-%d %H:%M:%S"`" mojiweather data is not updata" >> ./error.log
   exit 1;
else
   echo 1 > ./running_status
   echo `date "+%Y-%m-%d %H:%M:%S"`" mojiweather data is updata" >> ./monitoring_running.log
fi







