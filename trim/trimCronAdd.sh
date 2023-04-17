#!/bin/bash
sed -ie '/.*trim.log/d' /var/spool/cron/root
showip=$(ifconfig | grep -E "([0-9]{1,3}\.){3}[0-9]{1,3}" | grep -v 127.0.0.1 | awk '{ print $2 }' | cut -f2 -d: | head -n 1 | sed 's/\.//g')
number=$showip

#Any given minute
RangeMinuteStart=0
RangeMinuteEnd=59

#Hours between including 1-4
RangeHourStart=0
RangeHourEnd=7

#Weekdays are including between 0-6 (0 is Sunday)
RangeWeekDayStart=0
RangeWeekDayEnd=6

RangeMinute=$((RangeMinuteEnd - RangeMinuteStart + 1))
RangeHour=$((RangeHourEnd - RangeHourStart + 1))
RangeWeekDay=$((RangeWeekDayEnd - RangeWeekDayStart + 1))

minute=$(echo $(((( number % RangeMinute )) + RangeMinuteStart )))
hour=$(echo $(((( number % RangeHour )) + RangeHourStart )))
weekday=$(echo $(((( number % RangeWeekDay )) + RangeWeekDayStart )))

coomand='/root/bash-scripts/trim.sh'
logPath='>> /root/bash-scripts/trim.log'

echo "$minute $hour * * $weekday $coomand $logPath" >> /var/spool/cron/root