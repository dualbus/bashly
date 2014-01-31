tests=\
	bytes \
	http

bashly=BASHLY_PATH=../lib ../bashly
bash=/bin/bash

.SUFFIXES: .bashly

all: $(tests)

.bashly:
	for t in $</*; do \
		$(bashly) "$$t" | $(bash);\
	done
