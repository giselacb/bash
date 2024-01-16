#!/bin/bash
#Programa que me saca la secuencia (2, 18, 192, 2500, 38.880...)
pos=1
aumen=0
resul=0

while [ $resul -lt 9999800 ]; do
	pos2=$(($pos+1))
	aumen=1
	resul=$(($pos2**$pos))
	resul2=$(($pos*$resul))
	pos=$(($pos+1))
	echo "$resul2"

done

