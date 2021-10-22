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
	vim --not-a-term -n -u ~/.vimrcs/install-bootstrap.vim \
      -c "silent! call dein#install()|q"
	vim --not-a-term -n -u ~/.vimrc -c "silent! call dein#update()|q"

install-nord:
	git clone https://github.com/arcticicestudio/nord-dircolors.git ~/Code/arcticicestudio/nord-dircolors
	ln -vsr "~/Code/arcticicestudio/nord-dir_colors/src/dir_colors" ~/.dir_colors

install-zsh:
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

link-vimrcs:
	ln -vs $(shell pwd)/.vimrcs $(shell echo $$HOME)
	ln -vs $(shell pwd)/.vimrc $(shell echo $$HOME)/.vimrc

link-profiles:
	if [ -f ~/.zshrc ]; then mv ~/.zshrc ~/.zshrc.BAK; fi
	ln -vs $(shell pwd)/.zshrc $(shell echo $$HOME)/.zshrc

install: install-dein link-vimrcs dein-base-setup install-nord install-zsh link-profiles
