.POSIX:

testdir=tests
srcdir=src

all: compile

compile:
	(cd $(srcdir)  && $(MAKE))

test:
	(cd $(testdir) && $(MAKE))

clean:
	(cd $(srcdir)  && $(MAKE) clean)
