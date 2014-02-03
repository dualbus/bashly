.POSIX:

tests=\
	csv

bashly=BASHLY_PATH=../../lib ../../bashly
bash=/bin/bash

.SUFFIXES: .bashly

all: $(tests)

.bashly:
	for t in $</*; do \
		echo running bashly "$$t"; \
		$(bashly) "$$t" | $(bash) || exit 1;\
	done
