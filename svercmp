#!/usr/bin/env bash

# Simple version comparison. Doesn't work with alphabetic versions
# currently.

function vercmp_recursive {
  typeset sep
  typeset -a ver1=() ver2=()
  sep=$1; shift
  ver1=("${@:1:sep}")
  ver2=("${@:sep+1}")

  if ((ver1 > ver2)); then
    echo  1; return 0
  elif ((ver2 > ver1)); then
    echo -1; return 0
  fi

  if ((sep <= 1)); then
    echo 0; return 0
  fi

  vercmp_recursive $((sep-1)) "${ver1[@]:1}" "${ver2[@]:1}"
}

vercmp() {
  typeset -a ver1 ver2

  IFS=. read -ra ver1 <<< "$1"
  IFS=. read -ra ver2 <<< "$2"

  vercmp_recursive "${#ver1[@]}" "${ver1[@]}" "${ver2[@]}"
}

vercmp "$1" "$2"
