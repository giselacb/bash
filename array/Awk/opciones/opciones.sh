#!/bin/bash

#Esta función está en cada una de las opciones del case, comprueba si el usuario ha pasado la carpeta con .tar, y si sólo pasó el nombre le añade .tar
function tar_exten() {

	conca=".tar"
	exten=$(echo "$carpeta" | grep ".tar" | wc -l)

	if [ $solu -eq 0 ]; then
		carpeta=$carpeta$tar
	fi

}

ruta=$PWD
todo=("$@")
acum=0

while [ $acum -lt $# ]; do

        if [[ "${todo[$acum]}" == "-D" ]];then

	       acum=$(($acum+1))
	       ruta="${todo[$acum]}"

	fi

acum=$(($acum+1))

done


while getopts "x:a:c:v" option; do

	option=$(echo "$option" | tr '[:upper:]' '[:lower:]')
	case $option in

		x)
			#Descomprime el .tar $ruta2 en $ruta

			carpeta="$OPTARG"
			tar_exten 
			ruta2=$(find / -name "$carpeta")
			tar -xvf $ruta2 -C $ruta
		       ;;
		a)
			#Busca todos los .txt y los mete en $carpeta
			carpeta="$OPTARG"
			tar_exten
			find / -name "*.txt" -exec tar -rvf $carpeta {} \;
		       ;;
		c)

			#Crea un tar llamado $carpeta de la carpeta HOME
			carpeta="$OPTARG"
			tar_exten
			tar -cvf $carpeta $HOME
		       ;;
		v)

			#Visualiza el contenido del fichero tar que le pasemos, si pones sólo el nombre de la carpeta y está en otro sitio, la busca
			carpeta="$OPTARG"
			tar_exten
			ruta2=$(find / -name "$carpeta")
			tar -tfv $ruta2

		       ;;
		*)
			echo "No has introducido una opción válida"
	               ;;
	  esac
done
