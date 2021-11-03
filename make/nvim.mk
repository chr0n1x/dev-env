packer-setup:
	nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
	nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerInstall'
	nvim --headless -c 'autocmd User COQdeps quitall'

link-configs:
	-mkdir ~/.config
	-ln -vs $(shell pwd)/neovim/config/nvim $(shell echo $$HOME)/.config/nvim

nuke:
	rm -rf \
		~/.local/share/nvim \
		neovim/config/nvim/plugin \
		~/.cache/nvim \
		~/.vimrc ~/.vimrcs

install-nvim: link-configs packer-setup
