#!/bin/bash

# Generate image related functions

# Not exported functions

generate_image() {

  # Params: ask for confirmation
  if ask "Generate image?" Y; then
    if [ ! -f ./Dockerfile ]; then
      echo "Dockerfile not detected in the current directory. Exiting."
      exit
    fi

    # TODO: delete image if exists
    # TODO: stop container if its running
    # TODO: delete container if exist

    echo "Generating image with name ${IMAGE_NAME}"
    echo
    docker build -t ${IMAGE_NAME} .
  else
    exit
  fi
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
