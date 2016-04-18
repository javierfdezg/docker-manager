#!/bin/bash

add_object_to_array() {

	IFS=':' read -r -a array <<< $3

	length=$(cat $1 | jq ".$2 | length")
	for element in ${array[@]}
	do
		add_variable $1 "string" $2[$length].$element $element
	done

}

container_add_objects_to_array() {
	if ask "Add $1?" N; then
		add_object_to_array $2 $3 $4
		while ask "Add more $1?" N; do
			add_object_to_array $2 $3 $4
		done
	fi
}

export -f container_add_objects_to_array
