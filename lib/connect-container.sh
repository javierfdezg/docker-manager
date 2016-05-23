#!/bin/bash

# Connect container related functions

# Not exported functions

connect_container() {

  status_container
  case $? in
    0)
      prepare_status_container
      ;;
    1)
      docker exec -i -t ${CONTAINER_NAME} bash
      ;;
    2)
      prepare_status_container
      ;;
  esac
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
