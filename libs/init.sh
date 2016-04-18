#!/bin/bash

configFile='.dmconfig'

declare -a supportedComponents=(db webserver)

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
    # TODO: create parent objects dynamically
    
    echo "Project config"
    add_variable ${configFile} "string" "projectName"
    add_variable ${configFile} "string" "projectAddonsDir"
    echo 
    echo "Docker generic config"
    add_variable ${configFile} "object" "docker"
    add_variable ${configFile} "string" "docker.dockerMachineCommand"
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
    add_variable ${configFile} "array"  "container.run.hostsFileEntries" "ip:host"
    add_variable ${configFile} "array"  "container.run.mounts"  "localDir:containerDir"
    add_variable ${configFile} "array"  "container.run.components" "name:localPort:containerPort"
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

export -f init
