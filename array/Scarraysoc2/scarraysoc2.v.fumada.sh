#!/bin/bash
#Array bidimensional en bash
declare -A usuarios
declare -A completo

campos=("inter" "carpeta" "grupo" "usuario")

numline=$(cat $1 | wc -l)

while [ $numline -ne 0 ]; do
incre=4
	linea=$(cat $1 | head -n$numline | tail -n1)
	nom=$( echo "$linea" | cut -d ":" -f1)
	while [ $incre -gt 0 ]; do
		for i in ${campos[@]}; do
			echo "$i"
			dato=$( echo "$linea" | cut -d ":" -f$incre)
			completo[$i]=$dato
			usuarios[$nom,$i]=${completo[$i]}
			incre=$(($incre-1))
		done 
	done
numline=$(($numline-1))
done
echo "Todo lo que hay en usuarios ${usuarios[pepe2,inter]}"
echo "carpeta ${completo[@]}"
echo "inter ${completo[inter]}"
