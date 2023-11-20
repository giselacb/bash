#!/bin/bash
#Programa al que le pasas argumentos, los mete en un array y te lo ordena de menor a mayor
clear
incre=0
incre2=1
aume=0
aume2=$#

for i in $@ ; do
	array[$aume]=$i
	aume=$(($aume+1))
done


total=${#array[@]}
total2=$(($total-1))


while [ $incre -lt $total ]; do

	uno=${array[$incre]}
	dos=${array[$incre2]}

	if [ $dos -lt $uno ];then
		array[$incre]=$dos
		array[$incre2]=$uno
	fi
	incre2=$(($incre2+1))

	if [ $incre2 -ge $total ]; then
		incre=$(($incre+1))
		incre2=$(($incre+1))
	fi

done 

echo "${array[@]}"
