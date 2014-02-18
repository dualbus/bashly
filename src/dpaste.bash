#!/bin/bash

: load http

function main {
  typeset content=$(http__form_url_encode "$(cat "${1:-/dev/stdin}")")
  typeset query_string=$(http__query_string_encode content "$content")
  typeset key value
  {
      read
      while IFS=$' \t\r' read -r key value _; do
        if [[ $key = Location: ]]; then
            printf '%s\n' "$value"

            return 0
        fi
      done
  } < <(http__post 'http://dpaste.com/api/v1/' "$query_string")

  return 1
}

main "$@"
