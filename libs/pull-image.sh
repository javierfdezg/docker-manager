#!/bin/bash

# Pull image related functions

# Not exported functions

pull_image() {
  # Params: ask for confirmation
  echo "$FUNCNAME not available yet" 
  # Get repository and image name from config file
  # Stop container
  # Delete container
}

pull_image_help() {
  echo "$(basename "$0") image pull"
  echo 
  echo "This command will attempt to update an exising image from a dockerhub"
  echo "repository."
  echo 
}

# End of not exported functions

# Exported functions

prepare_pull_image() {
  case $1 in
    "")
      pull_image
      ;;
    *|-h|--help)
      pull_image_help
      ;;
  esac
}

export -f prepare_pull_image

# End of exported functions
