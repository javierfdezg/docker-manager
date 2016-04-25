#!/bin/bash

# Delete container related functions

# Not exported functions

delete_container() {

  status_container
  case $? in 
    0)
      echo "No container ${CONTAINER_NAME} found. Doing nothing."
      exit
      ;;
    1)
      $0 container stop
      ;;
  esac

  echo "Deleting container ${CONTAINER_NAME}"
  docker rm ${CONTAINER_NAME}
}

delete_container_help() {
  echo "$(basename "$0") container delete"
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
