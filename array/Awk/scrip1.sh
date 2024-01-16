#!/bin/bash

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
