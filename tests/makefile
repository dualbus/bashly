.POSIX:

rootdir=..

include $(rootdir)/makefile.common

tests=\
	array \
	bytes \
	cmdline \
	date \
	http \
	ipv4 \
	process \
	regex \
	shell \
	template

packages=\
	format

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
