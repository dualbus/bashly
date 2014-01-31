bin=\
		my.paste.dpaste.cbash

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

