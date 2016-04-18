#!/bin/bash

. libs/utils.sh

configFile='config.json'

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

    erase ${configFile};

    add_variable ${configFile} "string" "projectName"
    add_variable ${configFile} "string" "projectAddonsDir"
    add_variable ${configFile} "object" "image"
    add_variable ${configFile} "object" "container"
    add_variable ${configFile} "array"  "container.components"

  fi
}

export -f init
