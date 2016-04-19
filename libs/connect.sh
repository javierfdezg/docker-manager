#!/bin/bash

# Connect to container related functions

# Not exported functions

connect() {

  echo "$FUNCNAME"
  # Get container name from config file
  # Check if container is running 
  # if running, connect to the container. 
}

connect_help() {
  echo "$(basename "$0") connect"
  echo 
  echo "This command connects to the container if its running."
  echo 
}

# End of not exported functions

# Exported functions

prepare_connect() {
  case $1 in
    "")
      connect
      ;;
    *|-h|--help)
      connect_help
      ;;
  esac
}

export -f prepare_connect

# End of exported functions
