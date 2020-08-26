default: build

build:
	docker build --tag chr0n1x/dev-env:latest .

# TODO: lock to a version. master has a bugfix as of writing this
install-dein:
	curl \
      https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh \
      > ~/installer.sh && \
    sh ~/installer.sh ~/.cache/dein && \
    rm ~/installer.sh


install-vimrcs:
	cp -R .vimrcs ~/.
	cp .vimrc ~/.


install: install-dein
install: install-vimrcs
	vim --not-a-term -n -u ~/.vimrcs/install-bootstrap.vim \
      -c "silent! call dein#install()|q"
	vim --not-a-term -n -u ~/.vimrc -c "silent! call dein#update()|q"
	rm -f ~/.vimrcs/install-bootstrap.vim
