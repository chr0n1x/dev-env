install-nord:
	-git clone \
	  https://github.com/arcticicestudio/nord-dircolors.git \
	  ~/Code/arcticicestudio/nord-dircolors
	-ln -vs "~/Code/arcticicestudio/nord-dir_colors/src/dir_colors" ~/.dir_colors

# https://github.com/ohmyzsh/ohmyzsh#unattended-install
install-omzsh:
	-sh -c \
	  "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
	  "" --unattended
	-rm ~/.zshrc

link-profiles:
	if [ -f ~/.zshrc ]; then mv ~/.zshrc ~/.zshrc.BAK; fi
	-ln -vs $(shell pwd)/.zshrc $(shell echo $$HOME)/.zshrc
	mkdir -p ~/.config
	-ln -vs $(shell pwd)/zsh $(shell echo $$HOME)/.config/zsh
	@echo "Installed - you can now run the following:"
	@echo "    source ~/.zshrc"

install-zsh: install-nord install-omzsh link-profiles
