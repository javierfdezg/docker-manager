#!/bin/bash

# Init related functions

# Changing this value will brake the system. Use this variable for developing
# purposes only. You've been warned ;)
configFile='dmconfig.json'

# Start of not exported functions

init_help() {
  echo "$(basename "$0") init"
  echo 
  echo "This command creates a docker-managed directory - basically a configuration file"
  echo "that tells $(basename "$0") that this directory is being docker-managed."
  echo 
  echo "If you execute $(basename "$0") init, you will be asked if you want to initialize"
  echo "this directory (or reinitialize it if you did it before). This will launch a "
  echo "wizard that will generate a JSON configuration file and prompt for the config"
  echo "values." 
  echo
}

init() {
  if ask "Initialize project?" Y; then
    if [ -f "${configFile}" ]; then
      if ask "Config file (${configFile}) is going to be overwritten. Continue?" N; then
        echo
      else
        exit
      fi
    fi

    initialize ${configFile};

    # Objects/Arrays must be created before inserting new attributes
    # TODO: Issue #3: Adding a variable to a path should create parent objects
    
    echo "Project config"
    add_variable ${configFile} "string" "projectName"
    add_variable ${configFile} "string" "projectAddonsDir"
    echo 
    echo "Docker generic config"
    add_variable ${configFile} "object" "docker"
    add_variable ${configFile} "string" "docker.dockerMachineCommand"
    add_variable ${configFile} "string" "docker.repository"
    echo
    echo "Docker image config"
    add_variable ${configFile} "object" "image"
    add_variable ${configFile} "string" "image.name"
    echo
    echo "Docker container config"
    add_variable ${configFile} "object" "container"
    add_variable ${configFile} "string" "container.name" 
    echo
    echo "Docker run config"
    add_variable ${configFile} "object" "container.run"
    add_variable ${configFile} "string" "container.run.hostName"
    add_variable ${configFile} "string" "container.run.mode"
    add_variable ${configFile} "string" "container.run.command"
    add_variable ${configFile} "array"  "container.run.hostsFileEntries" "ip:host"
    add_variable ${configFile} "array"  "container.run.mounts"  "localDir:containerDir"
    add_variable ${configFile} "array"  "container.run.services" "name:localPort:containerPort"

    echo

    if ask "Done! You might want to add your ${configFile} file to .gitignore. Do you want me to do it now?" Y; then
      if [ ! -f .gitignore ]; then
        touch .gitignore
      fi

      cat .gitignore | if grep --silent ${configFile}; then
        echo "${configFile} already defined in .gitignore. Doing nothing."
      else
        echo "${configFile}" >> .gitignore
        echo "Added ${configFile} to .gitignore"
      fi

    fi
  fi
}

# End of not exported functions

# Start of exported functions

prepare_init() {
  case $1 in
    "")
      init
      ;;
    *|-h|--help)
      help "init"
      ;;
  esac
}

# End of exported functions

export -f prepare_init
