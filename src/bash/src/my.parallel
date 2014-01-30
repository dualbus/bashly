#!/bin/bash

#-------------------------------------------------------------------------------
set -m
_jobs=() _n=0
enqueue() { printf -v '_jobs[++_n]' '%q ' "$@"; }
dequeue() { eval "${_jobs[_n]}" & unset '_jobs[_n--]'; }
sigchld() { ((_n>0)) && dequeue; }
trap sigchld CHLD
#-------------------------------------------------------------------------------

# Main
# ----

(($# >= 3)) || exit 1

count=$1
workers=$2
shift 2

# Add jobs to the queue
for ((i = 0; i < count; i++)); do enqueue "$@"; done

# Remove $workers jobs from the queue. After one exits, another one will automatically
# take its place.
for ((i = 0; i < workers; i++)); do dequeue; done

# Wait until all children are done.
wait
