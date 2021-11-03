default: install-zsh install-nvim

tag := chr0n1x/dev-env:latest

build:
	docker build --tag $(tag) .

check-deps:
	# silver surfer optional for host systems...?
	# which ag
	which curl
	which direnv
	which git
	which nvim
	which z
	which zsh

dev:
	@echo "Building container for local dev if DNE"
	@docker inspect $(tag) || $(MAKE) build
	docker run --rm -ti \
	  -v $(shell pwd):/workspace \
	  -w /workspace \
	  --entrypoint zsh $(tag)

include make/*.mk


host-install: check-deps install-zsh install-nvim

macos-install:
	which brew /dev/null || /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew install ag direnv git gh nvim z zsh
