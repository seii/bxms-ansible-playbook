#!/bin/bash

BXMSENV=$1

if [ -z "$BXMSENV" ]; then
#  echo "Usage: $0 <ENVIRON>" >&2
  echo "USAGE: $0 <ENVIRON>"
  exit 1
fi

ansible-playbook -K -i inventories/$BXMSENV/hosts --vault-password-file=vaultpw install.yml
