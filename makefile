.POSIX:

rootdir=.

include $(rootdir)/makefile.common

.PHONY: compile tests clean

all: compile

compile:
	(cd $(srcdir)  && $(MAKE))

tests:
	(cd $(testsdir) && $(MAKE))

clean:
	(cd $(srcdir)  && $(MAKE) clean)
