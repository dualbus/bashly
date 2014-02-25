#!/bin/bash

: load cmdline

function main {
  : <<EOD
  I tried hard to duplicate the brain-dead argument parsing of the
  echo builtin, but it's still not an accurate clone. It parses
  arguments even after arguments.
EOD

  typeset separator no_trailing_newline interpret_backslashes
  typeset type value argument
  typeset -a options=(
    'name:no_trailing_newline;short:n'
    'name:interpret_backslashes;short:e'
    'name:no_interpret_backslashes;short:E'
  )
  typeset -a arguments

  errors_not_fatal=y dashdash_not_special=y \
    cmdline__arguments "${options[@]}" -- "$@" | {
      while IFS=: read -rd '' type value; do
        case $type in 
          @|-)
            arguments+=("$separator$value"); separator=' '
            ;;

          no_trailing_newline)
            no_trailing_newline=y
            ;;

          interpret_backslashes)
            interpret_backslashes=y
            ;;

          no_interpret_backslashes)
            interpret_backslashes=
            ;;
        esac
      done

      for argument in "${arguments[@]}"; do
        if [[ $interpret_backslashes ]]; then
          printf %b "$argument"
        else
          printf %s "$argument"
        fi
      done

      if [[ ! $no_trailing_newline ]]; then
        printf \\n
      fi
    }
}

main "$@"
