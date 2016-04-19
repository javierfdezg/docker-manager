#!/bin/bash

# Delete related functions

# Not exported functions

delete_help() {
  echo "$(basename "$0") delete {subcommand} [--help|-h]"
  echo 
  echo "Available subcommands:"
  echo
  echo "image\t\tDeletes the image (if exists). It will also delete the container created"
  echo "\t\twith this image."
  echo "container\tDelete the container."
  echo
}


# End of not exported functions

# Exported functions

prepare_delete() {
  case $1 in
    image)
      shift
      prepare_delete_image $@
      ;;
    container)
      shift
      prepare_delete_container $@
      ;;
    *|--help|-h)
      delete_help
      ;;
  esac
}

export -f prepare_delete

# End of exported functions
