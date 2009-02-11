# Makefile for go
# Author: Jaeho Shin <netj@sparcs.org>
# Created: 2008-03-12

PRODUCT=$(NAME)-$(VERSION).sh
NAME=go
VERSION?=0.3-$(shell date +%Y%m%d)
REQUISITES+=\
	bash		\
	readlink	\
	sed		\
	grep		\
	rsync		\
	ssh		\
	ssh-keygen	\
	#

dist/$(PRODUCT): build
	# combining into a single executable file with pojang
	mkdir -p dist
	pojang main * >$@ \
	    --exclude=Makefile --exclude=build --exclude=_darcs --exclude=dist
	chmod +x $@

.PHONY: build clean install
build:
	# checking requisites
	@for req in $(REQUISITES); do type $$req >/dev/null; done
	# tagging its version
	{ echo '#!/bin/sh'; echo 'echo "go-$(VERSION)"'; } >go-version
	# turning on executables
	chmod +x main go-* \
	    valid-peer last-peer \
	    tell xfer \
	    be-quiet msg err \
	    absolute-path normalized-path \
	    build/summarize-command-helps \
	    #
	# creating help index
	build/summarize-command-helps help >help/COMMAND.txt \
	    help version \
	    init ls friends strangers \
	    pull push trim clone \
	    get put set revert

install: dist/$(PRODUCT)
	install $< ~/bin/$(NAME)

clean:
	rm -f dist/$(PRODUCT) go-version

