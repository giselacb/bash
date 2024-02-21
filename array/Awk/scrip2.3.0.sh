#!/bin/bash
#Realizar un script que nos automatice la inicialización del docker (servicios). 
#Toda la información irá a un fichero .log. El pid de los ficheros se conseguirán mediante el uso de awk. 

declare -A array

declare -A array2

lineas=$(($(docker ps -a | awk '{print $1}' | wc -l)))

lineas2=1

sudo service docker start 

while [ $lineas -gt $lineas2 ]; do

	pid=$(docker ps -a | awk '{print $1}' | tail -n$lineas2 | head -n1)
	images=$(docker ps -a | awk '{print $2}' | tail -n$lineas2 | head -n1)
	array[images]="$images"
	array[pid]="$pid"
	array2[$lineas2,images]=${array[images]}
	array2[$lineas2,pid]=${array[pid]}
	lineas2=$(($lineas2+1))
done

lineas2=1

ultima2=""

echo "Estás son todas las imágenes y su número: "

while [ $lineas -gt $lineas2 ]; do

	if [[ "$ultima2" == "${array2[$lineas2,images]}" ]]; then
		echo ""
	else
		echo "${array2[$lineas2,images]} $lineas2"

	fi

	ultima2=${array2[$lineas2,images]}
	lineas2=$(($lineas2+1))

done

lineas2=1 

read -p "Elige que contenedor asociado a qué imagen quieres levantar, dime el número: " num

ultima="${array2[$num,images]}"

acum=0

while [ $lineas -gt $lineas2 ]; do
	if [[ "$ultima" == "${array2[$lineas2,images]}" ]]; then
		acum=$(($acum+1))
		if [ $acum -gt 1 ]; then 
			echo "El contenedor de ${array2[$lineas2,images]} también tiene el número $lineas2"
		fi

	fi

	lineas2=$(($lineas2+1))
done

fecha=$(date +%X-%x)

if [ $acum -gt 1 ]; then

	read -p "Vuelve a decirme el número del contenedor que quieres levantar: " num2
	sudo docker start ${array2[$num2,pid]}
	
	echo "El contenedor ${array2[$num2,pid]} que pertenece a la imagen ${array2[$num2,images]} se ha levantado;  $fecha" >> dockers.log
else
	sudo docker start ${array2[$num,pid]}

	echo "El contenedor ${array2[$num,pid]} que pertenece a la imagen ${array2[$num,images]} se ha levantado;  $fecha" >> dockers.log

fi

docker ps | awk -v hora="$fecha" 'BEGIN {print "Los contenedores en ejecución son: "} {print $1,$2} END {print hora}' >> ejecución.txt
