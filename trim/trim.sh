#!/bin/bash
start=`date +%s`
/sbin/fstrim -av
end=`date +%s`
echo Execution time was `expr $end - $start` seconds.
