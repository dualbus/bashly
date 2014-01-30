#!/bin/bash

:load test-library-loader

f() {
  echo a
  echo b;
  echo c
}

m() {
  : This is a comment

  if :; then
    f
  fi
}

m "$@"
