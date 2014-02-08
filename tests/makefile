.POSIX:

tests=\
	array \
	bytes \
	cmdline \
	date \
	http \
	process \
	regex \
	shell \
	template

packages=\
	format

bashly=BASHLY_PATH=../lib ../bashly
bash=/bin/bash

.SUFFIXES: .bashly

all: $(tests) packages

.bashly:
	for t in $</*; do \
		echo running bashly "$$t"; \
		$(bashly) "$$t" | $(bash) || exit 1;\
	done

packages:
	for p in $(packages); do \
		echo running package "$$p"; \
		(cd "$$p" && $(MAKE)); \
	done
