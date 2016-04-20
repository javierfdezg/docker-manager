#!/bin/bash

# Image related functions

# Not exported functions

image_help() {
  echo "$(basename "$0") image {subcommand} [--help|-h]"
  echo 
  echo "Available subcommands:"
  echo
  echo "generate"
  echo "pull"
  echo "push"
  echo "delete"
  echo
}

# End of not exported functions

# Exported functions

populate_image_name() {

    get_variable ${configFile} "docker.repository"
    if [[ "$requested_var" == "" ]]; then
      repository=""
    else
      repository="$requested_var/"
    fi

    imageSearchVar="image.name"
    get_variable ${configFile} ${imageSearchVar}
    if [[ "$requested_var" == "" ]]; then
      imageName=""
      echo "Image name not found in config file! Exiting"
      exit
    else
      imageName="$requested_var"
    fi

    IMAGE_NAME="${repository}${imageName}"
}

prepare_image() {
  case $1 in
    delete)
      shift
      prepare_delete_image $@
      ;;
    generate)
      shift
      prepare_generate_image $@
      ;;
    push)
      shift
      prepare_push_image $@
      ;;
    pull)
      shift
      prepare_pull_image $@
      ;;
    *|--help|-h)
      image_help
      ;;
  esac
}

# Populate the image name for all the scripts
populate_image_name 

export -f prepare_image populate_image_name

# End of exported functions
