#!/bin/bash
#Programa que me pide un número decimal y lo pasa a binario

function recur() {

	n1=$(($n1/2))
	bina=$(($n1%2))
	array[$n1]=$bina

	if [ $n1 -ne 1 ]; then
		recur $n1
	fi
}

read -p "Dame el decimal: " n1

recur $n1


par=$(($n1%2))

if [ $par -eq 0 ]; then

	echo "${array[@]} 1"
else
	echo "${array[@]} 0"
fi
	


