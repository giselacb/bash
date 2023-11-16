#!/bin/bash 
colors=0
incre=1
ip=$(ifconfig)
declare -A lista
declare -A array
incre2=0
p="p"
#Este bucle lo que hace es que cuando encuentra que la primera letra es minúscula
#la reemplaza por una mayúscula y guarda todo en un array

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
		#me debe agregar a la lista el color nuevo y su equivalencia para que luego la última parte la haga bien
		read -p "El color $i no lo tengo, te va a tocar decirme el hexadecimal de $i: " hexa 
		read -p "Además dime también cómo quieres que se llame en el menú a la hora de elegirlo: " nombre
		echo "$i:$hexa:$nombre" >> listacolores.txt
		lista[$i]="$hexa"

	fi

done

echo "Esta va a ser la lista de colores que tienes para asignar: "

for i in "${lista[@]}"; do
	colors1=$(cat listacolores.txt | grep -i $i | cut -d ":" -f1,3)
	iniciales=$(cat listacolores.txt | grep -i $i | cut -d ":" -f3)
	echo "$colors1"
done

#Pregunta al usuario los colores y mete en variables la equivalencia del menú,
#si le pongo R, el grep va a buscar la R y el primer campo que va a ser rojo
#que es valor en el Array de asignación que contiene el hexadecimal

read -p "¿De qué color quieres la página?: " pc1
read -p "¿De qué color quieres el div?: " div
read -p "¿De qué color quieres el texto?: " ctext

pag=$(cat listacolores.txt | grep -i $pc1$ | cut -d ":" -f1)
div2=$(cat listacolores.txt | grep -i $div$ | cut -d ":" -f1)
ctext2=$(cat listacolores.txt | grep -i $ctext$ | cut -d ":" -f1)

#Creación de la página con los colores elegidos y el número de colores

echo -e "<head> \n <link rel=stylesheet type=""text/css"" href=""style.css""> </heah> <html> \n <body> \n <div> \n <p> \n $ip \n  \n </p> \n </div> \n </body> \n </html>" > mihtml.html
echo -e  "body { background-color:${lista[$pag]}} div { background-color:${lista[$div2]}} p { color:${lista[$ctext2]}} " > style.css
echo "El número total de colores introducidos son: $colors"
