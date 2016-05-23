#!/bin/bash

# Status container related functions

# Not exported functions

status_container_help() {
  echo "$(basename "$0") container status"
  echo
  echo "This command shows the status of the current container."
  echo
}

# End of not exported functions

# Exported functions

status_container() {
  docker ps | if grep -w --silent ${CONTAINER_NAME}; then
    # Container is running
    echo
    return 1
  else
    docker ps -a | if grep -w --silent ${CONTAINER_NAME}; then
      # Container exists but is not running
      return 2
    else
      # Container doesn't exist
      return 0
    fi
  fi
}

show_status_container() {
  status_container
  case $? in
    0)
      echo "Container ${CONTAINER_NAME} does not exist"
      ;;
    1)
      echo "Container ${CONTAINER_NAME} runnning"
      ;;
    2)
      echo "Container ${CONTAINER_NAME} not running"
      ;;
  esac
}

prepare_status_container() {
  case $1 in
    "")
      show_status_container
      ;;
    *|-h|--help)
      stauts_container_help
      ;;
  esac
}

export -f prepare_status_container status_container

# End of exported functions
