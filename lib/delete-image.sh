#!/bin/bash

# Delete image related functions

# Not exported functions

delete_image() {

  if ask "Delete image ${IMAGE_NAME}?" Y; then
    $0 container stop
    $0 container delete

    # TODO: detect if image exists before executing the command
    docker rmi ${IMAGE_NAME} 
  fi
}

delete_image_help() {
  echo "$(basename "$0") image delete"
  echo 
  echo "This command will delete the image of this project. It will also delete the"
  echo "container if it was created with the current image."
  echo 
}

# End of not exported functions

# Exported functions

prepare_delete_image() {
  case $1 in
    "")
      delete_image
      ;;
    *|-h|--help)
      delete_image_help
      ;;
  esac
}

export -f prepare_delete_image

# End of exported functions
