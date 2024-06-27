#!/usr/bin/env bash

if [ -f .env ]; then
  export $(cat .env | xargs)
fi

case "$1" in
tf)
  shift
  terraform $@
  ;;
*)
  echo $"Usage: $0 tf <commands>"
  exit 1
  ;;
esac
