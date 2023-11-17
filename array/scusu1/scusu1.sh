#!/bin/bash 

num=$#
incre=1
soy=$(whoami)
canlogin=0
for usu in $@ ; do

	existe=$(cat /etc/passwd | grep -w "$usu" | wc -l)

	if [ $existe -eq 1 ]; then
		echo " $usu es usuario del sistema"
	else
		echo "$usu no es usuario del sistema"
		read -p "Pon 1 si quieres crearlo" res
		if [ $res -eq 1 ]; then
			read -p "dime su carpeta personal: " carp
			read -p "dime su grupo principal: " grupo
			existegrupo=$(cat /etc/group | grep -w $grupo | wc -l)
			if [ $existegrupo -eq 0 ];then
				sudo addgroup $grupo
			fi	
			sudo useradd -m -d /home/$carp -g $grupo $usu
		fi
	fi
	if [[ "$soy" == "$usu" ]]; then
		echo "El usuario $usu ejecuta el script"
	fi
	login=$(cat /etc/passwd | grep -w "$usu" | grep bash$ | wc -l)
	
	if [ $login -eq 1 ]; then
		canlogin=$(($canlogin+1))
	fi
done	 		
echo "$canlogin es la cantidad de usuarios que pueden hacer login"
