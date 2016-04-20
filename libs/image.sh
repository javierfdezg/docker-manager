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

export -f prepare_image

# End of exported functions
