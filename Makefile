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


link-vimrcs:
	ln -vs $(shell pwd)/.vimrcs $(shell echo $$HOME)
	ln -vs $(shell pwd)/.vimrc $(shell echo $$HOME)/.vimrc


dein-base-setup:
	vim --not-a-term -n -u ~/.vimrcs/install-bootstrap.vim \
      -c "silent! call dein#install()|q"
	vim --not-a-term -n -u ~/.vimrc -c "silent! call dein#update()|q"


install: install-dein link-vimrcs dein-base-setup


copy-vimrcs:
	cp -R .vimrcs ~/.
	cp .vimrc ~/.


hard-install: install-dein copy-vimrcs dein-base-setup
	rm -f ~/.vimrcs/install-bootstrap.vim
