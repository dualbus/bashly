#!/bin/bash

: load http
: load cmdline

function main {
  typeset IFS 
  typeset -a commands arguments

  typeset -a options=(
  'name=encode:short=e:long=encode:arguments=1'
  'name=decode:short=d:long=decode:arguments=1'
  )

  while read -rd '' type value; do
    case $type in
      @)
        echo bad "$value"; exit 1
        ;;
      -)
        echo bad "$value"; exit 1
        ;;
      encode)
        command=http.form-url-encode argument=$value; break
        ;;
      decode)
        command=http.form-url-decode argument=$value; break
        ;;
    esac
  done < <(cmdline.arguments "${options[@]}" -- "$@")
  
  "$command" "$argument"
}

main "$@"
