#!/bin/bash

# Run container related functions

# Not exported functions

run() {

  echo "$FUNCNAME"
  # Get container name from config file
  # Check if container is running
  # If running warn the user
  # else run the container
}

run_help() {
  echo "$(basename $0) run"
  echo 
  echo "This command runs the container defined in the config file (if the container"
  echo "doesn't exists, $(basename $0) run will create it."
  echo 
  echo "Depending on the mode you chose to run your container, your terminal will show"
  echo "the container output or you will be given the control of the terminal back."
  echo
  echo "Use subcommands stop and connect to interact with your running container."
  echo
}


# End of not exported functions

# Exported functions

prepare_run() {
  case $1 in
    "")
      run
      ;;
    *|-h|--help)
      run_help
      ;;
  esac
}

export -f prepare_run

# End of exported functions
