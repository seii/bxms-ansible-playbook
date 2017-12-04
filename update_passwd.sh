#!/bin/bash

ENV=$1

if [ -z "$ENV" ]; then
  echo "Usage: $0 <ENVIRON>" >&2
  exit 1
fi


ansible-vault --vault-password-file=vaultpw edit inventories/$ENV/group_vars/all/passwords.yml
