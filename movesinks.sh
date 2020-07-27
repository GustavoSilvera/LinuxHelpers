#!/bin/bash 
SINK=$((((pacmd list-sinks | grep index) | cut -f2 -d':') | cut -f2 -d' ') | sed -n $1p)
echo "Setting default sink to: $SINK";
pacmd set-default-sink $SINK
pacmd list-sink-inputs | grep index | while read line
do
echo "Moving input: ";
echo $line | cut -f2 -d' ';
echo "to sink: $SINK";
pacmd move-sink-input `echo $line | cut -f2 -d' '` $SINK

done
