# TODO: lock to a version. master has a bugfix as of writing this
install-dein:
	curl \
      https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh \
      > /tmp/installer.sh && \
    sh /tmp/installer.sh ~/.cache/dein && \
    rm /tmp/installer.sh

dein-setup:
	-nvim --headless -n -u ~/.config/nvim/init.vim -c "call dein#install()|q"
	-nvim --headless -n -u ~/.config/nvim/init.vim -c "call dein#update()|q"
	-nvim --headless -n -u ~/.config/nvim/init.vim -c "UpdateRemotePlugins|q"

link-vimrcs:
	-mkdir -p ~/.config/nvim
	-ln -vs $(shell pwd)/.vimrcs $(shell echo $$HOME)
	-ln -vs $(shell pwd)/.vimrc $(shell echo $$HOME)/.config/nvim/init.vim

install-nvim: install-dein link-vimrcs dein-setup
