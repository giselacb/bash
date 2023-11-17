#!/bin/bash
function eu (){
	pri=$1
	se=$2

	if [ $pri -gt $se ]; then
		pri=$(($pri-$se)
		echo "$pri $se"
		eu $pri $se
	elif [ $se -gt $pri ]; then
		se=$(($se-$pri))
		echo "$pri $se"
		eu $pri $se

	else
		echo "el máximo común divisor $se"
	fi 

}


echo "$1 $2"
eu $1 $2

