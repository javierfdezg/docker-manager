#!/bin/bash

# Status related functions

# Not exported functions

get_status() {
  echo $FUNCNAME

  #Retrieve the container status
  #return 0 -> stopped
  #return 1 -> running
}

show_status() {
  # Get status
  # Params: ask for confirmation
  echo "$FUNCNAME"
  # Get container name from config file
  # Stop container if its running
  # execute docker command to delete container
}

status_help() {
  echo "$(basename "$0") status"
  echo 
  echo "This command shows the status of the current container"
  echo 
}

# End of not exported functions

# Exported functions

prepare_status() {
  case $1 in
    "")
      show_status
      ;;
    *|-h|--help)
      status_help
      ;;
  esac
}

export -f prepare_status

# End of exported functions
