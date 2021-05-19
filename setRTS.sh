echo ----------------
echo setRTS started
echo ----------------
echo

if (( $# == 1))
then
  if (( $1 > 0 ))
  then
    echo $1 > /proc/sys/kernel/sched_rr_timeslice_ms
  fi
else
  echo '---------------------------------------'
  echo '   !!! Error !!!'
  echo '   use a parameter between 1 and 100'
  echo '---------------------------------------'
fi

echo
echo sched_rr_timeslice_ms is set to $(cat /proc/sys/kernel/sched_rr_timeslice_ms) ms
echo 2000000 > /proc/sys/kernel/sched_rt_period_us
echo sched_rt_period_us is set to .... $(cat /proc/sys/kernel/sched_rt_period_us) usec
sleep 0.1
echo 1000000 > /proc/sys/kernel/sched_rt_runtime_us
echo sched_rt_runtime_us is set to ... $(cat /proc/sys/kernel/sched_rt_runtime_us) usec
echo
echo ----------------
echo setRTS completed
echo ----------------
