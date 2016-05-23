#!/bin/bash

# Run container related functions

# Not exported functions

run_container() {

  status_container
  case $? in
    1)
      echo "Container ${CONTAINER_NAME} running."
      if ask "Connect to ${CONTAINER_NAME}?" Y; then
        $0 container connect
      else
        exit
      fi
      ;;
    2)
      docker start ${CONTAINER_NAME}
      exit
      ;;
    *)
      runCommand="docker run "
      runCommand="${runCommand} ${CONTAINER_RUN_MODE}"
      runCommand="${runCommand} ${CONTAINER_RUN_HOSTNAME}"
      for entry in "${CONTAINER_RUN_HOSTFILEENTRIES[@]}"; do
        runCommand="$runCommand ${entry}"
      done;
      for mountPoint in "${CONTAINER_RUN_MOUNTS[@]}"; do
        runCommand="$runCommand ${mountPoint}"
      done;
      for service in "${CONTAINER_RUN_SERVICES[@]}"; do
        runCommand="$runCommand ${service}"
      done;
      for envVar in "${CONTAINER_RUN_ENV_VARS[@]}"; do
        runCommand="$runCommand ${envVar}"
      done;
      runCommand="${runCommand} --name ${CONTAINER_NAME}"
      runCommand="${runCommand} ${IMAGE_NAME}"
      runCommand="${runCommand} ${CONTAINER_RUN_COMMAND}"

      ${runCommand}

      ;;
  esac
}

run_container_help() {
  echo "$(basename "$0") run container"
  echo
  echo "This command starts the container. If the container doesn't exists, it will"
  echo "be created."
  echo
}

# End of not exported functions

# Exported functions

prepare_run_container() {
  case $1 in
    "")
      run_container
      ;;
    *|-h|--help)
      run_container_help
      ;;
  esac
}

export -f prepare_run_container

# End of exported functions
