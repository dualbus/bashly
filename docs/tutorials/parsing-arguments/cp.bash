#!/bin/bash

: load cmdline

function show_option {
  if [[ $2 ]]; then
    printf '%s\n' "received option $1 with value ''$2''"
  else
    printf '%s\n' "received option $1"
  fi
}

function show_argument {
  printf '%s\n' "received argument $1"
}

function show_error {
  printf '%s\n' "unexpected option ''$1''"
}

function main {
  : <<EOD
EOD

  typeset type value
  typeset -a options=(
    'name=no_target_directory:short=T:long=no-target-directory'
    'name=help:short=h:long=help'
    'name=version:short=v:long=version'
  )
  typeset -a arguments

  while read -rd '' type value; do
    case $type in 
      no_target_directory|help|version)
        show_option "$type" "$value";;
      @) show_argument "$value";;
      -) show_error "$value";;
    esac
  done < <(cmdline__arguments "${options[@]}" -- "$@")
}

main "$@"
