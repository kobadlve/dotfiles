SHELL := /bin/bash
.PHONY: help all install update

help:
	@echo "make (install link update)"

all: update install link

install:
	@./bin/install.sh

link:
	@./bin/link.sh

update:
	@./bin/update.sh
