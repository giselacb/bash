#!/bin/bash
#Realizar un script que cada 5 segundos guarda la hora en un fichero. 
#Deberemos detenerlo (no cancelarlo), pasarlo a Background, al 
#Foreground, ... y finalmente "matarlo". "Estudia" los resultados 
#del fichero generado e indica qué hace en cada momento el script.

function zeta() {
	echo "Se ha detenido el fichero" >> hora.txt
}
function matar() {
	echo "Se ha matado al proceso" >> hora.txt
}
trap matar sigint sigterm
trap zeta sigint sigterm


while true ; do

	sleep 5 
	echo $(date +%H:%M) >> hora.txt

done
