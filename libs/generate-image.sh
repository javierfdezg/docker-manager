#!/bin/bash

# Generate image related functions

# Not exported functions

generate_image() {

  # Params: ask for confirmation
  echo "$FUNCNAME"
  # Get repository and image name from config file
  # Stop container
  # Delete container
}

generate_image_help() {
  echo "$(basename "$0") image generate"
  echo 
  echo "This command will attempt to update an exising image from a dockerhub"
  echo "repository."
  echo 
}

# End of not exported functions

# Exported functions

prepare_generate_image() {
  case $1 in
    "")
      generate_image
      ;;
    *|-h|--help)
      generate_image_help
      ;;
  esac
}

export -f prepare_generate_image

# End of exported functions
