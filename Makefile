include common.mk

all:
	$(MKDIR) bin
	$(MAKE) -C test
	$(MAKE) -C sample

test:
	$(MAKE) -C test test

sample:
	$(MAKE) -C sample test

clean:
#	$(MAKE) -C src clean
	$(MAKE) -C test clean
	$(MAKE) -C sample clean

.PHONY: sample

