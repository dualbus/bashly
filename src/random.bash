#!/bin/bash

: load cmdline
: load common
: load log

function main {
  typeset type_ value
  typeset type length source
  typeset -a options=(
  'name=type:short=t:long=type:arguments=1' # alnum alpha digit ...
  'name=length:short=n:long=length:arguments=1'
  'name=source:short=s:long=source:arguments=1'
  'name=help:short=h:long=help'
  )

  # defaults
  type=xdigit length=8 source=/dev/urandom
  while read -rd '' type_ value; do
    case $type_ in
      type) type=$value;;
      length) length=$value;;
      source) source=$value;;
      help) cmdline__help "${options[@]}"; return 0;;
      *) common__die "unexpected ''$value''";;
    esac
  done < <(cmdline__arguments "${options[@]}" -- "$@")

  case $type in
    xdigit|alnum|alpha|digit) 
      printf '%s\n' \
        "$(tr -cd "[:$type:]" < "$source" | head -c "$length")"
      ;;
    *)
      common__die "wrong type ''$type''"
      ;;
  esac
}

main "$@"
