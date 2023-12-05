#!/bin/bash
#Programa que con recursividad suma numeros naturales desde 1 hasta N
acum=1
acum2=0

function suma(){
	acum=$(($acum+1))	
	acum2=$(($acum2+$acum))	
	if [ $acum2 -lt 90000 ];then
		suma
	fi
}

suma 

echo "$acum2"
