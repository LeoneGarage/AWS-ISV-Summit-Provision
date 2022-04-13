#!/bin/bash

set -e

DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

. $DIR/utils.sh

WORKSPACE_NAME=
PLAN=
IMPORT=
VARFILE=secrets.tfvars
USERS_PATH=users.csv

POSITIONAL=()
while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    -plan)
      PLAN=true
      shift # past argument
      ;;
    -import)
      IMPORT=true
      shift # past argument
      ;;
    -w|--workspace)
      WORKSPACE_NAME="$2"
      shift # past argument
      shift # past value
      ;;
    -u|--users)
      USERS_PATH="$2"
      shift # past argument
      shift # past value
      ;;
    *)    # unknown option
      POSITIONAL+=("$1") # save it in an array for later
      shift # past argument
      ;;
  esac
done

set -- "${POSITIONAL[@]}" # restore positional parameters

if [ -n "$VARFILE" ]; then
  VARFILE="$(cd "$(dirname "$VARFILE")"; pwd)/$(basename "$VARFILE")"
fi

if [ -n "$USERS_PATH" ]; then
  USERS_PATH="$(cd "$(dirname "$USERS_PATH")"; pwd)/$(basename "$USERS_PATH")"
fi

terraform -chdir=$DIR/workspace init
workspace_create_if_not_exists $DIR/workspace $ACCOUNT_NAME $WORKSPACE_NAME
workspace_select "$DIR/workspace" $ACCOUNT_NAME $WORKSPACE_NAME
if [ -n "$PLAN" ] && [ "$PLAN" = "true" ]; then
  terraform -chdir=$DIR/workspace plan -var="workspace=$ACCOUNT_NAME-$WORKSPACE_NAME" -var="users_filepath=$USERS_PATH" -var-file=$VARFILE $@
else
  if [ -n "$IMPORT" ] && [ "$IMPORT" = "true" ]; then
    terraform -chdir=$DIR/workspace import -var="workspace=$ACCOUNT_NAME-$WORKSPACE_NAME" -var="users_filepath=$USERS_PATH" -var-file=$VARFILE $@
  else
    terraform -chdir=$DIR/workspace apply -parallelism=50 -auto-approve -var="workspace=$ACCOUNT_NAME-$WORKSPACE_NAME" -var="users_filepath=$USERS_PATH" -var-file=$VARFILE $@
  fi
fi
