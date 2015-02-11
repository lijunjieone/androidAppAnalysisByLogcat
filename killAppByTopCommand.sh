#!/bin/bash

top_file=/tmp/top.log
bg_file=/tmp/bg.log
fg_file=/tmp/fg.log
function getProcessFromCommandTop() {
echo "get process from  command top to $top_file"
adb shell top > $top_file &
pid=$!
echo $pid
sleep_time=10
echo "collect process at $sleep_time time"
sleep $sleep_time
kill -9 $pid
#cat $top_file
}

function getBgProcess() {
echo "analysis the process at background app"
cat $top_file  | grep bg | grep u0  | grep "\\." | grep -v android | grep -v google | awk -F" " '{print $10}'  | awk -F ":" '{print $1}' | tr -d "\r"  | sort -u > $bg_file

cat $top_file  | grep fg | grep "\\."| awk -F" " '{print $10}'  | awk -F ":" '{print $1}' | tr -d "\r"  | sort -u > $fg_file
echo "$fg_file"
cat $fg_file
echo "$bg_file"
cat $bg_file
}

function forceStopProcess() {

echo "force stop the background app"
for i in `comm -13 $fg_file $bg_file`;
{
        echo $i;
        adb shell am force-stop $i
}

}
function main() {
getProcessFromCommandTop
getBgProcess
forceStopProcess
}
main


