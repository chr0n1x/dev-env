default: install-zsh install-nvim

build:
	docker build --tag chr0n1x/dev-env:latest .

check-deps:
	# silver surfer optional for host systems...?
	# which ag
	which curl
	which direnv
	which git
	which nvim
	which z
	which zsh

include make/*.mk

host-install: check-deps install-zsh install-nvim
