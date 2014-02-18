#!/bin/bash

: load common
: load log
: load cmdline

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
  type=hex length=8 source=/dev/urandom
  while read -rd '' type_ value; do
    case $type_ in
      type) type=$value;;
      length) length=$value;;
      source) source=$value;;
      help) cmdline.help "${options[@]}";;
      *) common.die "unexpected ''$value''";;
    esac
  done < <(cmdline.arguments "${options[@]}" -- "$@")

  log.debug "type: $type"
  log.debug "length: $length"
  log.debug "source: $source"

  case $type in
    xdigit|alnum|alpha|digit) 
      printf '%s\n' \
        "$(tr -cd "[:$type:]" < "$source" | head -c "$length")"
      ;;
    *)
      common.die "wrong type ''$type''"
      ;;
  esac
}

main "$@"
