#!/bin/bash

declare -A array

lineas=$(($(docker ps -a | awk '{print $1}' | wc -l)))
lineas2=1


while [ $lineas -gt $lineas2 ]; do

	pid=$(docker ps -a | awk '{print $1}' | tail -n$lineas2 | head -n1)	
	array[$lineas2]="$pid"
	lineas2=$(($lineas2+1))

done

lineas2=1


docker ps -a | awk 'BEGIN {print "PID de los procesos"} {print "${array[@]}} END {print "Fin del script"}' >> 

