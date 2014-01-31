#!/bin/bash

:load http

function main {
  typeset content=$(http.form-url-encode "$(cat "${1:-/dev/stdin}")")
  typeset query_string=$(http.query-string-encode content "$content")
  typeset key value
  {
      read
      while IFS=$' \t\r' read -r key value _; do
        if [[ $key = Location: ]]; then
            printf '%s\n' "$value"

            return 0
        fi
      done
  } < <(http.post 'http://dpaste.com/api/v1/' "$query_string")

  return 1
}

main "$@"
