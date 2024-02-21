#!/bin/bash
#estas intentando de todos los argumentos quedarte con el siguiente a -D

todo=("$@")
acum=0

while [ $acum -lt $# ]; do 

	if [[ "${todo[$acum]}" == "-D" ]];then 
		acum=$(($acum+1))
		ruta="${todo[$acum]}"
	fi
acum=$(($acum+1))
done

echo $ruta
