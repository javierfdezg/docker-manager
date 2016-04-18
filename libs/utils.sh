#!/bin/bash

variables=(
  "projectName::Project Name"
  "projectAddonsDir::Docker addons directory"
)

defaults=(
  "projectName::$(basename `pwd`)"
  "projectAddonsDir::$(pwd)/docker-addons"
)

get_human_translation() {
  for index in "${variables[@]}" ; do
    KEY="${index%%::*}"
    VALUE="${index##*::}"

    if [[ "$KEY" == "$1" ]] ;
    then
      echo "$VALUE"
    fi
  done
}

get_default() {
  defaultValue="";
  for index in "${defaults[@]}" ; do
    KEY="${index%%::*}"
    VALUE="${index##*::}"

    if [[ "$KEY" == "$1" ]] ;
    then
      defaultValue=$VALUE
    fi
  done
}

add_variable() {

  # String variables
  if [ "$2" == "string" ];
  then
    variable=$(get_human_translation $3)
    get_default $3

    if [[ "$defaultValue" != "" ]];
    then
      variable="$variable ($defaultValue): "
    else
      variable="$variable: "
    fi

    read -p "$variable "  value
    if [[ "$value" == "" ]];
    then
      value=$default
    fi

    cat $1 | jq ".$3=\"$value\"" | sponge $1
  fi

}

erase() {
  jq -n '{}' > $1
}

ask() {
    # http://djm.me/ask
    while true; do

        if [ "${2:-}" = "Y" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2:-}" = "N" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
        fi

        # Ask the question - use /dev/tty in case stdin is redirected from somewhere else
        read -p "$1 [$prompt] " REPLY </dev/tty

        # Default?
        if [ -z "$REPLY" ]; then
            REPLY=$default
        fi

        # Check if the reply is valid
        case "$REPLY" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac

    done
}

export -f ask erase add_variable

