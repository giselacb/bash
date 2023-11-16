#!/bin/bash 
clear
colors=0
incre=0
ip=$(ifconfig)
declare -A lista

for i in "$@" ; do 

	colors=$(($colors+1))
	read -p "Dime el hexadecimal de $i: " c1
	lista[$i]="$c1"
done

read -p "¿De qué color quieres la página?: " pc1
read -p "¿De qué color quieres el div?: " div
read -p "¿De qué color quieres el texto?: " ctext


echo -e "<head> \n <link rel=stylesheet type=""text/css"" href=""style.css""> </heah> <html> \n <body> \n <div> \n <p> \n $ip \n  \n </p> \n </div> \n </body> \n </html>" > mihtml.html
echo -e  "body { background-color:${lista[$pc1]}} div { background-color:${lista[$div]}} p { color:${lista[$ctext]}} " > style.css
echo "El número total de colores introducidos son: $colors"
