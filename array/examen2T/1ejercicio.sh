#!/bin/bash
#Realizar un script al que tendrá la sigiuiente sintaxis: script1_tunombre.sh -opcion segundos, se le pasan los siguientes parámetros (obligatorios):
function nohay(){
	if [[ "$resul" == "" ]]; then
		echo "No tienes ningún proceso con sleep ejecutándose en $terminal"

	else
		echo "$resul"
	fi
}

while getopts "f:b:v" option; do

        option=$(echo "$option" | tr '[:upper:]' '[:lower:]')

	case $option in

                f)
			fg="$OPTARG"
			sleep $fg &
			echo "Se ha hecho un sleep de $fg segundos en background el día $(date +%c)" >> procesos.log
		;;
		b)
			bg="$OPTARG"
			sleep $bg
			echo "Se ha hecho un sleep de $bg segundos en background el día $(date +%c)" >> procesos.log

		;;


		v)
			terminal="$OPTARG"

			lineas=$(ps -eo tty,command | grep -w sleep | grep "$terminal" | wc -l)
			total=$(($lineas-2))
			total=$(($lineas-1))
			existe=$(ps -eo tty,command | grep -w sleep | grep "$terminal" | grep color=auto | wc -l)
			if [ $existe -eq 1 ]; then
				resul=$(ps -eo tty,command | grep -w sleep | grep "$terminal" | head -n$total 2> /dev/null) 
				nohay
			else
				resul=$(ps -eo tty,command | grep -w sleep | grep "$terminal" | head -n$total2 2> /dev/null)
				nohay
			fi

			echo "Se ha visualizado los procesos sleep en la terminal $terminal el día $(date +%c)" >> procesos.log

		;;
		*)
			echo "Pon uno de los parámetros obligatorios \-v \-f o \-b"

	esac

done
