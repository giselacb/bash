#!/bin/bash 

clear

#Programa que le pide al usuario n número de colores por parámetros, le da un menú 

function comprobando(){
	compro=0
	numero=$((${#array[@]}+1))

	#Función que sirve para hacer la comprobación de que el usuario ha elegido las letras correctas del menú
	#en caso de que no, se lo vuelve a pedir.

	#El letramayus lo uso para ponerlo en mayúscula en caso de que el usuario no lo haya hecho
	#porque sino el if me lo va hacer mal al comparar exactamente

	for i in "${iniarray[@]}" ;do

		letramayus=$(cat listacolores.txt | grep -i -w "$1" | cut -d ":" -f3)

		if [[ "$i" == "$letramayus" ]]; then

			compro=$(($compro+1)) 

		fi

		done
		if [ $compro -eq 0 ] && [[ "$2" == "pc1" ]];then 

			echo "No era tan difícil poner la segunda columna, otra oportunidad"
			read -p "¿De qué color quieres la página?: " pc1

		fi

		if [ $compro -eq 0 ] && [[ "$2" == "div" ]];then 

			echo "No era tan difícil poner la segunda columna, otra oportunidad"	
			read -p "¿De qué color quieres el div?: " div

		fi
		if [ $compro -eq 0 ] && [[ "$2" == "ctext" ]];then 
			echo "No era tan difícil poner la segunda columna, otra oportunidad"
			read -p "¿De qué color quieres el texto?: " ctext
		fi
}

colors=0
incre=1
ip=$(ifconfig)
declare -A lista
declare -A array
incre2=0
p="p"

#Este bucle lo que hace es que cuando encuentra que la primera letra es minúscula
#la reemplaza por una mayúscula y guarda todo en un array, listaletra es una lista de
#las letras en mayúscula y en minúscula

for i in "$@" ; do

	firstletr=${i:0:1}

	minus=$(cat listaletra.txt | grep -w $firstletr | cut -d ":" -f1)
	mayus=$(cat listaletra.txt | grep -w $firstletr | cut -d ":" -f2)

	if [[ "$firstletr" == "$minus" ]]; then

		i="${i/$minus/$mayus}"
		array[$incre2]="$i"

	else

		array[$incre2]="$i"

	fi

	incre2=$(($incre2+1))

done

#Le pasa al for el array anterior, hace un array con el color y su equivalencia en
#hexadecimal, en caso de que no esté en la lista el color se lo pide al usuario
#lo guarda en un array de asignación llamado lista

for i in "${array[@]}" ; do

	colors=$(($colors+1))
	hexa=$(cat listacolores.txt | grep -i -w $i | cut -d ":" -f2)

	if [[ "$hexa" != "" ]]; then

		lista[$i]="$hexa"

	else
		#me debe agregar a la listacolores el color nuevo y su equivalencia para que luego la última parte la haga bien
		read -p "El color $i no lo tengo, te va a tocar decirme el hexadecimal de $i: " hexa 
		read -p "Además dime también cómo quieres que se llame en el menú a la hora de elegirlo: " nombre
		echo "$i:$hexa:$nombre" >> listacolores.txt
		lista[$i]="$hexa"

	fi

done

echo "Esta va a ser la lista de colores que tienes para asignar: "
incre3=0

#Este for te saca la lista de colores y la muestra por pantalla, además guarda en un array las iniciales equivalentes
#a los colores que insertó el usuario

for i in "${lista[@]}"; do

	colors1=$(cat listacolores.txt | grep -i $i | cut -d ":" -f1,3)
	iniciales=$(cat listacolores.txt | grep -i $i | cut -d ":" -f3)
	iniarray[$incre3]="$iniciales"
	incre3=$(($incre3+1))
	echo "$colors1"

done

#Pregunta al usuario los colores y mete en variables (pag,div2,ctext2) la equivalencia del menú.
#Si le pongo R, el grep va a buscar la R y el primer campo que va a ser rojo
#que es valor de la posición en el Array de asignación que contiene el hexadecimal

read -p "¿De qué color quieres la página?: " pc1
read -p "¿De qué color quieres el div?: " div
read -p "¿De qué color quieres el texto?: " ctext

##aqui pensé en hacer un for para no llamarlo 3 veces pero lo descarté por algún motivo

comprobando "$pc1" "pc1"
comprobando "$div" "div"
comprobando "$ctext" "ctext"

#Esto hace que cuando el usuario meta R vaya a buscar su equivalencia de nombre de R y esa es la equivalencia 
#en hexadecimal del array de asignación

pag=$(cat listacolores.txt | grep -i $pc1$ | cut -d ":" -f1)
div2=$(cat listacolores.txt | grep -i $div$ | cut -d ":" -f1)
ctext2=$(cat listacolores.txt | grep -i $ctext$ | cut -d ":" -f1)

#Creación de la página con los colores elegidos y el número de colores

echo -e "<head> \n <link rel=stylesheet type=""text/css"" href=""style.css""> </heah> <html> \n <body> \n <div> \n <p> \n $ip \n  \n </p> \n </div> \n </body> \n </html>" > mihtml.html
echo -e  "body { background-color:${lista[$pag]}} div { background-color:${lista[$div2]}} p { color:${lista[$ctext2]}} " > style.css
echo "El número total de colores introducidos son: $colors"
