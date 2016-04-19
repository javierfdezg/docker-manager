#!/bin/bash

# Delete container related functions

# Not exported functions

delete_container() {

  # Params: ask for confirmation
  echo "$FUNCNAME"
  # Get container name from config file
  # Stop container if its running
  # execute docker command to delete container
}

delete_container_help() {
  echo "$(basename "$0") delete container"
  echo 
  echo "This command deletes the current container. The container will be stopped if it is"
  echo "running."
  echo 
}

# End of not exported functions

# Exported functions

prepare_delete_container() {
  case $1 in
    "")
      delete_container
      ;;
    *|-h|--help)
      delete_container_help
      ;;
  esac
}

export -f prepare_delete_container

# End of exported functions
