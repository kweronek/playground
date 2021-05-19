#!/bin/bash

if [[ $1 == "" ]]
then
  echo Please run like ./chrt.sh 5000000
fi

# compile the source code
gcc job.c -o job1.x

# create copies of executable with different names. This can help to identify them in top.
cp job1.x job2.x
cp job1.x job3.x

# just to make the parameter verbose. Use a value that slice is around 50-100 micro-seconds
export LOAD=$1

# launch all programs in parallel. Without the '&' they would be executed sequentially.
# chrt --rr 50 ./job1.x 1 10 15 $LOAD & >> chrt.log
# chrt --rr 50 ./job2.x 2 10 15 $LOAD & >> chrt.log 
# chrt --rr 50 ./job3.x 3 10 15 $LOAD >> chrt.log
chrt -r 50 ./job1.x 1 10 15 ${LOAD} &
sleep 0.005
chrt -r 95 ./job2.x 2 10 15 ${LOAD} &
sleep 0.005
chrt -r 90 ./job3.x 3 10 15 ${LOAD}

# note that the standard priority (15) is irrelevant here since
# the change of the standard prio has no effect
# for programs running in real-time mode (chrt --rr).   
