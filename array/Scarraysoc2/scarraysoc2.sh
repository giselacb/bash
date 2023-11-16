#!/bin/bash
#Programa al que le paso un fichero y me crea los usuarios y los grupos en caso de que no estén creados

lineas=$(cat $1 | wc -l)
incre=1
declare -A noexisten

#Te cuenta el numero de lineas y las va recorriendo decrementando el número de lineas, así sacamos cada usuario y lo metemos en un array los que no existen

while [ $lineas -gt 0  ]; do

lineas=$(($lineas-1))
nombreusu=$(cat $1 | head -n$incre | tail -n1 | cut -d ":" -f1)
existe=$(cat /etc/passwd | grep -w "$nombreusu" | wc -l)
usuario=$(cat $1 | head -n$incre | tail -n1 ) 


	if [ $existe -eq 1 ]; then

		echo "el usuario $nombreusu existe"
		incre=$(($incre+1))
		read -p "Pon 1 si desea borrar al usuario $nombreusu: " resu
			if [ $resu -eq 1 ]; then
				sudo deluser "$nombreusu" --remove-home --remove-all-files 
				echo "$nombreusu : El usuario se borró el día :$(date +%D":"%M:%H):" >> usuariosborrados.log 
			fi
	else

		echo "el usuario $nombreusu no existe"
		noexisten[$nombreusu]="$nombreusu"
		incre=$(($incre+1))

	fi
done

#Recorre el array de los usuarios que no existen y los crea, en caso de que no exista el grupo crea el grupo

for i in ${noexisten[@]}; do

	grupo=$(cat $1 | grep -i -w "$i" | cut -d ":" -f2)
	carper=$(cat $1 | grep -i -w "$i" | cut -d ":" -f3)
	interp=$(cat $1 | grep -i -w "$i" | cut -d ":" -f4)
	exisgrupo=$(cat /etc/group | grep -w "$grupo" | wc -l)

	if [ $exisgrupo -eq 0 ]; then

		sudo addgroup $grupo
		sudo useradd -m -d $carper -s $interp -g $grupo $i 2>> nuevos_usuarios.log
		echo "$i: este usuario se insertó el día :$(date +%D":"%M:%H): y además se creó su grupo $grupo" >> nuevos_usuarios.log

	else

		sudo useradd -m -d $carper -s $interp -g $grupo $i 2>> nuevos_usuarios.log

		echo "$i: este usuario se insertó el día :$(date +%D":"%M:%H): a un grupo ya creado llamado $grupo" >> nuevos_usuarios.log
	fi
done


