default: install

build:
	docker build --tag chr0n1x/dev-env:latest .

# TODO: lock to a version. master has a bugfix as of writing this
install-dein:
	curl \
      https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh \
      > ~/installer.sh && \
    sh ~/installer.sh ~/.cache/dein && \
    rm ~/installer.sh

dein-base-setup:
	nvim --headless -n -u ~/.vimrcs/install-bootstrap.vim \
      -c "call dein#install()|q"
	nvim --headless -n -u ~/.config/nvim/init.vim -c "call dein#update()|q"
	nvim --headless -n -u ~/.config/nvim/init.vim -c "UpdateRemotePlugins|q"

link-vimrcs:
	mkdir -p ~/.config/nvim
	ln -vs $(shell pwd)/.vimrcs $(shell echo $$HOME)
	ln -vs $(shell pwd)/.vimrc $(shell echo $$HOME)/.config/nvim/init.vim

install-nord:
	git clone https://github.com/arcticicestudio/nord-dircolors.git ~/Code/arcticicestudio/nord-dircolors
	ln -vs "~/Code/arcticicestudio/nord-dir_colors/src/dir_colors" ~/.dir_colors

# https://github.com/ohmyzsh/ohmyzsh#unattended-install
install-zsh:
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
	rm ~/.zshrc

link-profiles:
	if [ -f ~/.zshrc ]; then mv ~/.zshrc ~/.zshrc.BAK; fi
	ln -vs $(shell pwd)/.zshrc $(shell echo $$HOME)/.zshrc

install: install-dein link-vimrcs install-nord install-zsh link-profiles dein-base-setup
