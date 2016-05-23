#!/bin/bash

# Container related functions

# Start of not exported functions

add_object_to_array() {

	IFS=':' read -r -a array <<< $3

	length=$(cat $1 | jq ".$2 | length")
	for element in ${array[@]}
	do
		add_variable $1 "string" $2[$length].$element $element
	done

}

container_help() {
  echo "$(basename "$0") container {subcommand} [--help|-h]"
  echo
  echo "Available subcommands:"
  echo
  echo "run"
  echo "stop"
  echo "delete"
  echo "status"
  echo
}

populate_container_name() {
    containerSearchVar="container.name"
    get_variable ${configFile} ${containerSearchVar}
    if [[ "$requested_var" == "" ]]; then
      echo "Container name not found in config file! Exiting"
      exit
    else
      CONTAINER_NAME="${requested_var}"
    fi
}

populate_container_run_hostname() {
    containerSearchVar="container.run.hostName"
    get_variable ${configFile} ${containerSearchVar}
    if [[ "$requested_var" == "" ]]; then
      echo "Container hostName not found in config file! Exiting"
      exit
    else
      CONTAINER_RUN_HOSTNAME="-h ${requested_var}"
    fi
}

populate_container_run_mode() {
    containerSearchVar="container.run.mode"
    get_variable ${configFile} ${containerSearchVar}
    if [[ "$requested_var" == "" ]]; then
      echo "Container run mode not found in config file! Exiting"
      exit
    else
      CONTAINER_RUN_MODE="${requested_var}"
    fi
}

populate_container_run_command() {
    containerSearchVar="container.run.command"
    get_variable ${configFile} ${containerSearchVar}
    if [[ "$requested_var" == "" ]]; then
      CONTAINER_RUN_COMMAND=""
    else
      CONTAINER_RUN_COMMAND="${requested_var}"
    fi
}

populate_container_run_hostfile_entries() {
    containerSearchVar="container.run.hostsFileEntries"
    get_variable ${configFile} ${containerSearchVar}
    if [[ "$requested_var" == "" ]]; then
      CONTAINER_RUN_HOSTFILEENTRIES=()
    else
      local hostFilesEntryLen=$(echo $requested_var | jq 'length')
      if [[ $hostFilesEntryLen == 0 ]]; then
        CONTAINER_RUN_HOSTFILEENTRIES=()
      else
        for i in $(seq 0 $(($hostFilesEntryLen-1))); do
          local IP=$(echo $requested_var | jq ".[$i] | .ip" | tr -d '"')
          local HOST=$(echo $requested_var | jq ".[$i] | .host" | tr -d '"')

          if [[ "$IP" == "" || "$HOST" == "" ]]; then
            echo "Malformed host file entry with IP: $IP and host: $HOST"
            exit
          fi

          CONTAINER_RUN_HOSTFILEENTRIES+=" --add-host ${HOST}:${IP} "
        done
      fi
    fi
}

populate_container_run_mounts() {
    local containerSearchVar="container.run.mounts"
    get_variable ${configFile} ${containerSearchVar}
    if [[ "$requested_var" == "" ]]; then
      CONTAINER_RUN_MOUNTS=()
    else
      local mountsLen=$(echo $requested_var | jq 'length')
      if [[ $mountsLen == 0 ]]; then
        CONTAINER_RUN_MOUNTS=()
      else
        for i in $(seq 0 $(($mountsLen-1))); do
          local localDir=$(echo $requested_var | jq ".[$i] | .localDir" | tr -d '"')
          local containerDir=$(echo $requested_var | jq ".[$i] | .containerDir" | tr -d '"')

          if [[ "$localDir" == "" || "$containerDir" == "" ]]; then
            echo "Malformed mount entry with localDir: $localDir and containerDir: $containerDir"
            exit
          fi

          CONTAINER_RUN_MOUNTS+=" -v ${localDir}:${containerDir} "
        done
      fi
    fi
}

populate_container_run_services() {
    local containerSearchVar="container.run.services"
    get_variable ${configFile} ${containerSearchVar}
    if [[ "$requested_var" == "" ]]; then
      CONTAINER_RUN_SERVICES=()
    else
      local servicesLen=$(echo $requested_var | jq 'length')
      if [[ $servicesLen == 0 ]]; then
        CONTAINER_RUN_SERVICES=()
      else
        for i in $(seq 0 $(($servicesLen-1))); do
          local localPort=$(echo $requested_var | jq ".[$i] | .localPort" | tr -d '"')
          local containerPort=$(echo $requested_var | jq ".[$i] | .containerPort" | tr -d '"')

          if [[ "$localPort" == "" || "$containerPort" == "" ]]; then
            echo "Malformed mount entry with localPort: $localPort and containerPort: $containerPort"
            exit
          fi

          CONTAINER_RUN_SERVICES+=" -p ${localPort}:${containerPort} "
        done
      fi
    fi
}

populate_container_env_vars() {
    local containerSearchVar="container.run.environmentVariables"
    get_variable ${configFile} ${containerSearchVar}
    if [[ "$requested_var" == "" ]]; then
      CONTAINER_RUN_ENV_VARS=()
    else
      local envVarsLen=$(echo $requested_var | jq 'length')
      if [[ $envVarsLen == 0 ]]; then
        CONTAINER_RUN_ENV_VARS=()
      else
        for i in $(seq 0 $(($envVarsLen-1))); do
          local varName=$(echo $requested_var | jq ".[$i] | .varName" | tr -d '"')
          local varValue=$(echo $requested_var | jq ".[$i] | .varValue" | tr -d '"')

          if [[ "$varName" == "" || "$varValue" == "" ]]; then
            echo "Malformed variable with name: $varName and value: $varValue"
            exit
          fi

          CONTAINER_RUN_ENV_VARS+=" -e ${varName}=${varValue} "
        done
      fi
    fi
}
# End of not exported functions

# Start of exported functions

populate_container_vars() {
  populate_container_name
  populate_container_run_hostname
  populate_container_run_mode
  populate_container_run_command
  populate_container_run_hostfile_entries
  populate_container_run_mounts
  populate_container_run_services
  populate_container_env_vars
}

container_add_objects_to_array() {
	if ask "Add $1?" N; then
		add_object_to_array $2 $3 $4
		while ask "Add more $1?" N; do
			add_object_to_array $2 $3 $4
		done
	fi
}

prepare_container() {
  case $1 in
    run)
      shift
      prepare_run_container $@
      ;;
    connect)
      shift
      prepare_connect_container $@
      ;;
    stop)
      shift
      prepare_stop_container $@
      ;;
    delete)
      shift
      prepare_delete_container $@
      ;;
    status)
      shift
      prepare_status_container $@
      ;;
    *|--help|-h)
      container_help
      ;;
  esac
}

# End of exported functions

export -f container_add_objects_to_array prepare_container populate_container_vars
