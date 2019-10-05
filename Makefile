SHELL := /bin/bash

help:
	@echo "make (install link update)"

all:

install:
	@./bin/install_mac.sh

link:
	@./bin/link.sh

update:
	@./bin/update.sh
