#!/bin/bash

# Stop container related functions

# Not exported functions

stop() {

  echo "$FUNCNAME"
  # Get container name from config file
  # Check if container is running 
  # if running, stop the container. 
  # else warn the user
}

stop_help() {
  echo "$(basename "$0") stop"
  echo 
  echo "This command stops the container if its running"
  echo 
}

# End of not exported functions

# Exported functions

prepare_stop() {
  case $1 in
    "")
      stop
      ;;
    *|-h|--help)
      stop_help
      ;;
  esac
}

export -f prepare_stop

# End of exported functions
