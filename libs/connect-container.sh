#!/bin/bash

# Connect container related functions

# Not exported functions

connect_container() {

  # Params: ask for confirmation
  echo "$FUNCNAME"
  # Get container name from config file
  # Stop container if its running
  # execute docker command to start container
}

connect_container_help() {
  echo "$(basename "$0") container connect"
  echo 
  echo "Connect to the container if its running"
  echo 
}

# End of not exported functions

# Exported functions

prepare_connect_container() {
  case $1 in
    "")
      connect_container
      ;;
    *|-h|--help)
      connect_container_help
      ;;
  esac
}

export -f prepare_connect_container

# End of exported functions
