#!/bin/bash
function eu (){
	pri=$1
	se=$2

	if [ $pri -gt $se ]; then
		pri=$(($pri-$se))
		eu $pri $se
	elif [ $se -gt $pri ]; then
		se=$(($se-$pri))
		eu $pri $se
	else
		echo "el mínimo común múltiplo $se"
	fi 

}

eu $1 $2

