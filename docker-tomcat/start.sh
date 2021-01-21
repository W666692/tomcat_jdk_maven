#!/bin/bash

# start 1
nginx -g "daemon off;"  > /var/log/start1.log 2>&1 &
# start 2
/usr/local/tomcat8/bin/catalina.sh run  > /var/log/start2.log 2>&1 &
# start 3
/usr/sbin/sshd -D  > /var/log/start3.log 2>&1 &
# just keep this script running
while [[ true ]]; do
    sleep 1
done
