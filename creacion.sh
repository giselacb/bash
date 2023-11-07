#!/bin/bash

#Programa que evalua si el usuario quiere comprobar la existencia de los ficheros o crearlos

read -p "Para comprobar si un fichero existe pon existe, para crearlo pon crear: " compro
acum=0
case $compro in 
	existe)
		read -p "Ponme los ficheros que quieres comprobar si existen: " lista
		num=${#lista[@]}
		palabra=${lista[$acum]}
		while [ $acum -lt $num ]; do 	
			if [ -e $palabra ];then
				echo "$palabra existe"
			else
				echo "$palabra no existe"
			fi
		acum=$(($acum+1))
		done	
	;;
	crear)
		
esac
		
		
