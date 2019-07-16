#!/bin/bash
#auto backup mysql db
#by author zcm 201907

#define backup path
BAK_DIR=./`date +%Y%m%d`
MYSQLDB=bjpowernode
MYSQLUSR=root
MYSQLPW=
MYSQLCMD=/usr/local/bin/mysqldump

#判断是否是root用户
if [ $UID -ne 0 ];then
  echo "this is not root user, UID is $UID"
fi

if [ ! -d $BAK_DIR ];then
	mkdir -p $BAK_DIR
	echo "\033[32mthe $BAK_DIR Create successfully!"
else
	echo "this $BAK_DIR is exists...."
fi

/usr/bin/expect <<-EOF #在shell中插入expect脚本
set timeout 30
spawn $MYSQLCMD -u$MYSQLUSR -p$MYSQLPW $MYSQLDB -r$BAK_DIR/$MYSQLDB.sql
expect {
  "*assword:"
  {
    send "\n"
  }
}
expect eof
EOF

if [ $? -eq 0 ];then
	echo "\033[32mthe mysql backup $MYSQLDB successfully!\033[0m"
else
	echo "\033[32mthe mysql backup $MYSQLDB failed, please check.\033[0m"
fi

