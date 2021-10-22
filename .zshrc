export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME="robbyrussell"

plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

autoload -Uz compinit && compinit

# TODO: figure out why autoload didn't work here even w/ fpath
for script in $(ls ~/.config/zsh/scripts); do
  source ~/.config/zsh/scripts/$script
done
