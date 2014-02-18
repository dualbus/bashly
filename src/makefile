.POSIX:

bin=\
	dpaste.cbash \
	echo.cbash \
	gcat.cbash \
	random.cbash \
	url.cbash

bindir=../bin

rm=rm -f
bashly=BASHLY_PATH=../lib ../bashly

.SUFFIXES: .bash .cbash

all: $(bin)

clean:
	-$(rm) $(bin)
	-$(rm) $(bindir)/*


.bash.cbash:
	echo '#!/usr/bin/env bash' > $@
	$(bashly) $< >> $@
	cat $@ > $(bindir)/$*
	chmod +x $@ $(bindir)/$*

