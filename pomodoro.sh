#!/bin/bash
while getopts d:t: flag
do
    case "${flag}" in
        d) duration=${OPTARG};;
        t) task=${OPTARG};;
    esac
done

if [ -z "$duration" ]
  then
    duration="25"
fi

if [ -z "$duration" ]
  then
    duration="unknown"
fi

start_date=`date`
echo "Starting Pomodoro timer of $duration minutes at $start_date"
for i in $(seq 1 $duration);
do
    sleep 60
    echo $i minutes have passed
done

end_date=`date`
echo "Finished Pomodoro at $end_date"
afplay ./elevator_ping.mp3

# Write on log file

file_path="/var/log/pomodoro/logs"
# Check if file exists
if [ ! -e "$file_path" ]; then
    # If file doesn't exist, create it
    mkdir "/var/log/pomodoro"
    echo "Log file doesn't exist creating."
    touch "$file_path"
    echo "duration,task,start_date,end_date" >> "$file_path"
    echo "Log file created at $file_path."
fi

echo "Writting on log file"
echo "$duration,$task,$start_date,$end_date," >> "$file_path"