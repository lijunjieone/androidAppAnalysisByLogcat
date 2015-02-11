#analysisByLogcat.sh
#目的
从Android手机的日志中分析，有什么应用在打印日志，也能看出来那些应用在后台运行
#步骤
- 从logcat中选取10000行
- 从ps中选取当前执行进程
- 从logcat中找到pid，从ps日志中找到对应程序，根据匹配条数，产生一个报表.
#代码
```shell
adb logcat -t 10000 > /tmp/logcat.log && adb shell ps > /tmp/ps.log  && cat /tmp/logcat.log  | awk -F"(" '{print $2}' | awk -F")" '{print $1}' >/tmp/logcat_filter.log&& echo "" > /tmp/filter.log&& for i in `cat /tmp/logcat_filter.log`; { cat /tmp/ps.log | grep -E "\\b$i\\b" >> /tmp/filter.log; } && cat /tmp/filter.log | awk -F" " '{print $9}' | sort | uniq -c | sort -k 1

```

#killAppByTopCommand.sh
#目的
监控一段时间内，android后台运行的程序，将不是手动启动的进程使用强制停止命令，停止这些app
#使用
./killAppByTopCommand.sh
