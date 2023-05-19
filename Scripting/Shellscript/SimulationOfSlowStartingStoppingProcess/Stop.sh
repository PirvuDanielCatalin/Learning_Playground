sleep 15

pid=$(ps -ef | grep -v grep | grep Loop | awk '{print $2}')

kill -9 $pid

