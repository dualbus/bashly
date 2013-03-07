#!/bin/bash
permute() {
  permute_r() {
    local  j=$1 i n
    shift; n=$(($# - j + 1))

    (($# > 0)) || return 1
    ((n == 1)) && { echo "$1"; }
    ((n == 2)) && {
      echo "${@:1:j-1}" "${@:j:1}"    "${@:j+1:1}"
      echo "${@:1:j-1}" "${@:j+1:1}"  "${@:j:1}"
      }
    ((n >= 3)) && {
      for ((i = j; i < n + j; i++)); do
        permute_r $((j+1)) "${@:1:j-1}" "${@:i:1}" "${@:j:i-j}" "${@:i+1}"
      done
      }
  }
  permute_r 1 "$@"
}


s=$1 n=${#s}
for ((i = 0; i < n; i++)); do
  a+=("${s:i:1}")
done
permute "${a[@]}"|tr -d ' '|awk '!a[$0]++'
