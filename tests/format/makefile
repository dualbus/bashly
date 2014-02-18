.POSIX:

rootdir=../..

include $(rootdir)/makefile.common

tests=\
	csv

all: $(tests)

.bashly:
	for t in $</*; do \
		echo running bashly "$$t"; \
		$(bashly) "$$t" | $(bash) || exit 1;\
	done
