#!/bin/bash

# Container related functions

# Start of not exported functions

add_object_to_array() {

	IFS=':' read -r -a array <<< $3

	length=$(cat $1 | jq ".$2 | length")
	for element in ${array[@]}
	do
		add_variable $1 "string" $2[$length].$element $element
	done

}

container_help() {
  echo "$(basename "$0") container {subcommand} [--help|-h]"
  echo 
  echo "Available subcommands:"
  echo
  echo "create"
  echo "start"
  echo "stop"
  echo "delete"
  echo
}

# End of not exported functions

# Start of exported functions

container_add_objects_to_array() {
	if ask "Add $1?" N; then
		add_object_to_array $2 $3 $4
		while ask "Add more $1?" N; do
			add_object_to_array $2 $3 $4
		done
	fi
}

prepare_container() {
  case $1 in
    delete)
      shift
      prepare_delete_container $@
      ;;
    create)
      shift
      # TODO
      prepare_create_container $@
      ;;
    start)
      shift
      # TODO
      prepare_start_container $@
      ;;
    stop)
      shift
      # TODO
      prepare_stop_container $@
      ;;
    *|--help|-h)
      image_help
      ;;
  esac
}

# End of exported functions

export -f container_add_objects_to_array prepare_container
