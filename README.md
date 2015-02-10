>adb logcat -t 10000 > /tmp/logcat.log && adb shell ps > /tmp/ps.log  && cat /tmp/logcat.log  | awk -F"(" '{print $2}' | awk -F")" '{print $1}' >/tmp/logcat_filter.log&& echo "" > /tmp/filter.log&& for i in `cat /tmp/logcat_filter.log`; { cat /tmp/ps.log | grep -E "\\b$i\\b" >> /tmp/filter.log; } && cat /tmp/filter.log | awk -F" " '{print $9}' | sort | uniq -c | sort -k 1

