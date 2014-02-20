.POSIX:

rootdir=../../..

include $(rootdir)/makefile.common

bin=\
		cp.cbash

all: $(bin)

clean:
	-$(rm) $(bin)

.bash.cbash:
	$(bashly) $< $@
