#!/bin/bash
#Array bidimensional en bash
function mifuncion() {
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

			dato=$( echo "$linea" | cut -d ":" -f$incre)
			completo[$i]=$dato
			usuarios[$nom,$i]=${completo[$i]}
			incre=$(($incre-1))
		done 
	done
numline=$(($numline-1))
done
}

read -p "Si tiene un fichero ya creado con los usuarios pásemelo sino escriba 1" creafiche

if [ $creafiche -ne 1 ]; then
	increcrea=0
	read -p "¿Cuantos usuarios deseas ingresar: " numusu
	while [ $numusu -gt $increcrea ]; do
		read -p "Dime el nombre del usuario: " nomusu
		read -p "Dime el grupo al que va a pertenecer el usuario: " grupousu
		read -p "Dime su carpeta personal: " carpetausu
		read -p "Dime su interprete: " interusu
		echo "$nomusu:$grupousu:$carpetausu:$interusu" >> fiche.txt
	increcrea=$(($increcrea+1))
	done
	creafiche=fiche.txt
	mifuncion $creafiche
else
	mifuncion $creafiche
fi

read -p "Dime que deseas hacer con los usuarios, Crear (c), Borrar (b), Cambiar contraseña (cc), Información sobre ese usuario (info), añadirlo a un grupo (ag)" respu

respu_minus=$(echo "$respu" | tr '[:upper:]' '[:lower:]')

case $respu_minus in

	c)

		aume=1
		lineasfiche=$(cat $crearfiche | wc -l)
		while [ $aume -ne $lineasfiche ]; do
			usunom=$(cat $creafiche | head -n$aume | tail -n1 | cut -d ":" -f1)
			grupousu=${usuarios[$usunom,grupo]}
			existegru=$(cat /etc/groups | grep -w $grupousu | wc -l)
			if [ $existegru -ge 1 ]; then

				sudo useradd -m -d ${usuarios[$usunom,carpeta]} -g ${usuarios[$usunom,grupo]} -s ${usuarios[$usunom,inter]} $usunom
			else
				sudo addgroup $grupousu
				sudo useradd -m -d ${usuarios[$usunom,carpeta]} -g ${usuarios[$usunom,grupo]} -s ${usuarios[$usunom,inter]} $usunom
			fi
			aume=$(($aume+1))
		done
	;;

	b)
		
			for i in ${usuarios[@,usuario]}; do

				sudo deluser $i --remove-all-files --remove-home 

			done


	;;

	cc)

	;;

	info)

	;;

	ag)

	;;


