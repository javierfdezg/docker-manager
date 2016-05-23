#!/bin/bash

# Push image related functions

# Not exported functions

push_image() {

  # Params: ask for confirmation
  echo "$FUNCNAME not available yet"
  # Get repository and image name from config file
  # Stop container
  # Delete container
}

push_image_help() {
  echo "$(basename "$0") image push"
  echo
  echo "This command will attempt to push an exising image to a dockerhub"
  echo "repository."
  echo
}

# End of not exported functions

# Exported functions

prepare_push_image() {
  case $1 in
    "")
      push_image
      ;;
    *|-h|--help)
      push_image_help
      ;;
  esac
}

export -f prepare_push_image

# End of exported functions
