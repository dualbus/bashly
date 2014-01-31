tests=\
	array \
	bytes \
	http \
	process \
	regex \
	shell

bashly=BASHLY_PATH=../lib ../bashly
bash=/bin/bash

.SUFFIXES: .bashly

all: $(tests)

.bashly:
	for t in $</*; do \
		echo running "$$t"; \
		$(bashly) "$$t" | $(bash);\
	done
