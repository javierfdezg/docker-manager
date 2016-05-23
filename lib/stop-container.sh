#!/bin/bash

# Stop container related functions

# Not exported functions

stop_container() {
  status_container
  if [ $? == 1 ]; then
    echo "Stopping container ${CONTAINER_NAME}. This can take a few seconds"
    docker stop ${CONTAINER_NAME}
  fi
}

stop_container_help() {
  echo "$(basename "$0") container stop"
  echo
  echo "This command stops the current container if its running."
  echo
}

# End of not exported functions

# Exported functions

prepare_stop_container() {
  case $1 in
    "")
      stop_container
      ;;
    *|-h|--help)
      stop_container_help
      ;;
  esac
}

export -f prepare_stop_container

# End of exported functions
