export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME="robbyrussell"

plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

autoload -Uz compinit && compinit

for script in $(ls ~/.shell-startup); do
  source "~/.shell-startup/$script"
done
