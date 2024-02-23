#!/bin/bash
#Realizar un script al que tendrá la sigiuiente sintaxis: script1_tunombre.sh -opcion segundos, se le pasan los siguientes parámetros (obligatorios):

function nohay(){
	if [[ "$resul" == "" ]]; then
		echo "No tienes ningún proceso con sleep ejecutándose en $terminal"

	else
		echo "$resul"
	fi
}
function captura(){
	read -p "¿Quieres terminar con el proceso [S/n]: " respu
	if [[ "$respu" == "" ]] || [[ "$respu" == "s" ]] || [[ "$respu" == "S" ]]; then
		pid=$(ps -eo pid,command | grep $0 | awk '{print $1}')
		for id in ${pid[@]}; do
			sudo kill -9 $id
		done
		echo "El usuario $USER ha parado el script mientras se ejecutaba, el día $(date +%c)" >> procesos.log
	fi
}

trap captura sigint sigterm

while getopts "f:b:v:" option 2> /dev/null; do

        option=$(echo "$option" | tr '[:upper:]' '[:lower:]')

	case $option in

                f)
			fg="$OPTARG"
			sleep $fg 
			echo "Se ha hecho un sleep de $fg segundos en background el día $(date +%c)" >> procesos.log
		;;
		b)
			bg="$OPTARG"
			sleep $bg &
			echo "Se ha hecho un sleep de $bg segundos en background el día $(date +%c)" >> procesos.log

		;;


		v)
			terminal="$OPTARG"
			lineas=$(ps -eo tty,command | grep -w sleep | grep -w "$terminal" | wc -l)
			total=$(($lineas-2))
			total2=$(($lineas-1))
			existe=$(ps -eo tty,command | grep -w sleep | grep -w "$terminal" | grep color=auto | wc -l)
			if [ $existe -eq 1 ]; then
				resul=$(ps -eo tty,command | grep -w sleep | grep -w "$terminal" | head -n$total 2> /dev/null)

				nohay
			else
				resul=$(ps -eo tty,command | grep -w sleep | grep -w "$terminal" | head -n$total2 2> /dev/null)

				nohay
			fi

			echo "Se ha visualizado los procesos sleep en la terminal $terminal el día $(date +%c)" >> procesos.log

		;;
		*)
			echo "Pon uno de los parámetros obligatorios -v, -f o -b"

	esac

done
