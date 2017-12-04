#!/bin/bash

BXMSENV=$1

if [ -z "$BXMSENV" ]; then
  echo "Usage: $0 <ENVIRON>" >&2
  exit 1
fi

ansible-playbook -K \
  -i inventories/$BXMSENV/hosts \
  --vault-password-file=vaultpw \
  business_central.yml
