#!/bin/bash

: load http

#recode() {
#    local -a args=()
#    if      type -P recode  >/dev/null 2>&1; then
#        command recode "$@"
#    elif    type -P iconv   >/dev/null 2>&1; then
#        IFS=. read -r from _ to <<< "$1"
#        args=()
#        [[ $from ]] && args+=(-f "$from")
#        [[ $to ]]   && args+=(-t "$to")
#        iconv "${args[@]}"
#    else
#        die 'dependency: recode | iconv'
#    fi
#}
#
#html2txt() {
#    local url=$1
#
#    if      type -P elinks  >/dev/null 2>&1; then
#        elinks -no-numbering -no-references -dump "$url" | awk '
#        {sub(/^[[:space:]]*/,"")}
#        NR==1,!/^[[:space:]]*$/{b=$0;next}
#        b{print b; b=""}
#        1'
#    elif    type -P lynx    >/dev/null 2>&1; then
#        lynx -nolist -dump "$url" | recode ISO-8859-1.. | awk '
#        {sub(/^[[:space:]]*/,"")}
#        NR==1,!/^[[:space:]]*$/{b=$0;next}
#        b{print b; b=""}
#        1'
#    elif    type -P w3m     >/dev/null 2>&1; then
#        w3m -O ISO-8859-1 -dump "$url" | recode ISO-8859-1.. | awk '
#        {sub(/^[[:space:]]*/,"")}
#        NR==1,!/^[[:space:]]*$/{b=$0;next}
#        b{print b; b=""}
#        d++{print c}{c=$0}'
#    elif    type -P links  >/dev/null 2>&1; then
#        links -codepage iso-8859-1 -dump "$url" | recode ISO-8859-1.. | awk '
#        {sub(/^[[:space:]]*/,"")}
#        NR==1,!/^[[:space:]]*$/{b=$0;next}
#        b{print b; b=""}
#        1'
#    else
#        die 'dependency: elinks | lynx | w3m | links'
#    fi
#}

## Dependencies
## ------------
#recode      </dev/null >/dev/null
#html2txt .  </dev/null >/dev/null


function main {
  typeset base_url='http://lema.rae.es/drae/srv/search?val=%s'
  typeset term=$(http__form_url_encode "$1")

  #printf -v url "$base_url" "$(printf %s "$term" | fuenc | recode ..ISO-8859-1)"

  printf -v url "$base_url" "$term"

  echo "$url"
}

main "$@"
