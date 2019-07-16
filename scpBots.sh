#!/bin/bash
tar -zcvf bots.gz --exclude=/Users/roobo/go/src/roobo.com/bots/.git /Users/roobo/go/src/roobo.com/bots
/usr/bin/expect <<-EOF
set timeout -1
spawn ssh zhuchengming@192.168.1.41 "cd /home/zhuchengming/Go/src/roobo.com/bots;rm -rf *"
expect {
    "*assword:"
    {
        send "roobo123zcm\n"
    }
}
expect eof

spawn scp bots.gz zhuchengming@192.168.1.41:/home/zhuchengming/Go/src/roobo.com/bots/
expect {
    "*assword:"
    {
        send "roobo123zcm\n"
    }
}
expect 100%
expect eof

spawn ssh zhuchengming@192.168.1.41 "cd /home/zhuchengming/Go/src/roobo.com/bots;
tar zxvf bots.gz;
mv Users/roobo/go/src/roobo.com/bots/* .;
export GOPATH=/home/zhuchengming/Go
export PATH=/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/roobo/server/php/bin:/roobo/server/php/sbin:/usr/local/go/bin:/home/zhuchengming/bin:/home/zhuchengming/Go/bin:PATH
rm -rf Users/;
rm bots.gz;"

expect {
    "*assword:"
    {
        send "roobo123zcm\n"
    }
}
expect eof

EOF
rm bots.gz
