#!/bin/bash

#echo "Hello world"

declare -a map=(["44"]="192.168.1.44" ["137"]="10.45.137.137" ["51"]="192.168.1.51")
insideIp="rd@10.172.155.182:/storage"
outsideIp="rd@60.205.90.134:/storage/"

echo "map中所有的key："
echo ${!map[@]}

echo "map中所有的value："
echo ${map[@]}

echo "先从内网机器scp到跳板机上："
scp -P10099  rd@10.172.155.182:/storage

if [ $? != 0 ];then
  echo "从内网机器"$1"scp到跳板机失败"
  exit 2

echo "再从跳板机上scp到目标机器："
scp -P10099 ${outsideIp} localhost
