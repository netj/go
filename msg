#!/usr/bin/env bash
# msg -- show verbose message
level=$1; shift
be-quiet $level || echo "$@" >&3
