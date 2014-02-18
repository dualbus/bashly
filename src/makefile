.POSIX:

rootdir=..

include $(rootdir)/makefile.common

bin=\
	dpaste.cbash \
	echo.cbash \
	gcat.cbash \
	random.cbash \
	url.cbash

all: $(bin)

clean:
	-$(rm) $(bin)
	-$(rm) $(bindir)/*

.bash.cbash:
	$(bashly) $< $@
	cp $@ $(bindir)/$*
