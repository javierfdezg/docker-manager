#!/bin/bash

variables=(
  "projectName::Project Name"
  "projectAddonsDir::Docker addons directory"
  "image.name::Image name"
  "container.name::Container name"
  "container.run.mode::Container mode"
  "container.run.hostName::Container host name"
  "docker.dockerMachineCommand::Docker Machine command"
  "host::Host"
  "ip::IP"
  "localDir::Local Directory"
  "containerDir::Container Directory"
  "name::Name"
  "localPort::Local port"
  "containerPort::Container port"
)

defaults=(
  "projectName::$(basename `pwd`)"
  "projectAddonsDir::./docker-addons"
  "image.name::$(basename `pwd`)"
  "container.name::$(basename `pwd`)"
  "container.run.mode::-d"
  "container.run.hostName::docker-container"
  "docker.dockerMachineCommand::docker-machine"
  "localDir::$(pwd)"
  "containerDir::/usr/src"
)

get_human_translation() {

  translationKey=$1
  if [ "$2" != "" ];
  then
    translationKey=$2
  fi

  for index in "${variables[@]}" ; do
    KEY="${index%%::*}"
    VALUE="${index##*::}"

    if [[ "$KEY" == "$translationKey" ]] ;
    then
      echo "$VALUE"
    fi
  done
}

get_default() {

  defaultKey=$1
  if [ "$2" != "" ];
  then
    defaultKey=$2
  fi

  defaultValue="";
  for index in "${defaults[@]}" ; do
    KEY="${index%%::*}"
    VALUE="${index##*::}"

    if [[ "$KEY" == "$defaultKey" ]] ;
    then
      defaultValue=$VALUE
    fi
  done
}

add_variable() {

  # String variables
  if [ "$2" == "string" ];
  then
    variable=$(get_human_translation $3 $4)
    get_default $3 $4

    if [[ "$defaultValue" != "" ]];
    then
      variable="$variable ($defaultValue): "
    else
      variable="$variable: "
    fi

    read -p "$variable "  value
    if [[ "$value" == "" ]];
    then
      value=$defaultValue
    fi

    cat $1 | jq ".$3=\"$value\"" | sponge $1
  fi

  # Object variables
  if [ "$2" == "object" ];
  then
    cat $1 | jq ".$3={}" | sponge $1
  fi

  # Array variables
  if [ "$2" == "array" ];
  then
    cat $1 | jq ".$3=[]" | sponge $1

    case "$3" in
      "container.run.hostsFileEntries")
        container_add_objects_to_array 'host file entries' $1 $3 $4
        ;;
      "container.run.mounts")
        container_add_objects_to_array 'mount points' $1 $3 $4
        ;;
      "container.run.components")
        container_add_objects_to_array 'components' $1 $3 $4
        ;;
    esac
  fi 
}

export -f add_variable