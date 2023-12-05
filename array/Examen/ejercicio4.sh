#!/bin/bash
function crearusu() {
	echo "Crea usuarios hasta que pongas "fin""
	nombres=()
	read -p "Dame el nombre del trabajador: " nombre
	read -p "Dame la edad: " edad
	read -p "Dame el teléfono: " tele
	read -p "Dame el email: " email

	sudo useradd -m -c "$edad,$email,$tele" $nombre
	pos=0

	nombres[$pos]="$nombre"

	while [[ "$nombre" != "fin" ]]; do

		read -p "Dame el nombre del trabajador: " nombre
		if [[ "$nombre" == "fin" ]]; then
			break;
		fi
		read -p "Dame la edad: " edad
		read -p "Dame el teléfono: " tele
		read -p "Dame el email: " email
		pos=$(($pos+1))
		nombres[$pos]="$nombre"
		sudo useradd -m -c "$edad,$email,$tele" $nombre
	done
}

function recur(){
	edadmayor=0
	read -p "Dime qué información deseas buscar del usuario: nombre (n), teléfono (t), mayor de edad (m), meter otro usuario (new), modificar (modi), listar todos los usuarios (lis) o salir (ex): " respu

	if [[ $respu != "ex" ]]; then

		case $respu in
			n)
				clear
				read -p "dame el nombre del usuario del que deseas que te dé la información: " nomusu
				info=$(cat /etc/passwd | grep -w $nomusu | cut -d ":" -f5)
				incre=1
				for i in "edad" "email" "teléfono" ; do
					for a in $incre ;do
						info2=$(echo $info | cut -d "," -f$a)
						echo "De $nomusu su $i es $info2"
						incre=$(($incre+1))
					done
				done
				recur
			;;
			t)
				clear
				read -p "Dime el número y te digo su usuario: " teleuser
				infotele=$(cat /etc/passwd | grep -w $teleuser | cut -d ":" -f1)
				echo "El usuario al que pertenece el teléfono $teluser es $infotele"
				recur
			;;
			m)

				clear
				for i in ${nombres[@]}; do

					infomayor=$(cat /etc/passwd | grep -w $i | cut -d ":" -f5 | cut -d "," -f1)

					if [ $infomayor -gt $edadmayor ]; then

						nombremayor="$i"
						edadmayor=$infomayor
					fi
				done
				echo "El usuario $nombremayor es el mayor con $edadmayor años"
				recur
			;;
			new)

				clear
				crearusu
				recur
			;;
			modi) 
				clear
				read -p "dime el nombre de usuario al que deseas modificar la edad, teléfono o email" nomcambio 
				read -p "Si quieres cambiar su edad pon la edad nueva, sino dale a enter" edadnew 
				read -p "Si quieres cambiar su email pon el email nuevo, sino dale a enter" emailnew 
				read -p "Si quieres cambiar su teléfono pon su teléfono nuevo, sino dale a enter" telenew
				usermod -c "$edadnew,$emailnew,$telenew" $nomcambio
				recur
			;;
			lis)
				clear
				for n in ${nombres[@]}; do
					usu=$(cat /etc/passwd | grep -w "$n")
					echo "$usu"
				done
				recur
			esac
	else
		break
	fi
}

crearusu
recur

for p in ${nombres[@]}; do
	usu=$(cat /etc/passwd | grep -w "$p")
	echo "$usu" >> ficherousu.txt
done
