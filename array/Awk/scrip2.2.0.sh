#!/bin/bash
#Esta versión es un intento de optimización pero no va bien
declare -A array
declare -A array2
lineas=$(($(docker ps -a | awk '{print $1}' | wc -l)))
lineas2=1
campos=("imagen" "uid")

while [ $lineas -gt $lineas2 ]; do

	for i in ${campos[@]} ; do

		pid=$(docker ps -a | awk '{print $1}' | tail -n$lineas2 | head -n1)
		images=$(docker ps -a | awk '{print $2}' | tail -n$lineas2 | head -n1)
		
		for a in "$images" "$pid" ;do
			
			array[$i]=$a
			array2[$lineas2,$i]=${array[$i]}
		done
	done
	lineas2=$(($lineas2+1))

done

lineas2=1

echo "${array2[@]}"

#docker ps -a | awk 'BEGIN {print "PID de los procesos"} {print "${array[@]}} END {print "Fin del script"}' >> 

