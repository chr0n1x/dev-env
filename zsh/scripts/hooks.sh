# brew installs tab autocompletion scripts for awscli, git, hub, etc
# this loops through and loads those scripts
# WARNING: this may be insecure so use this ONLY if you know exactly what
#          you've installed on your system! If you're not sure, you can still
#          source each of the files individually/explicitly
if command -v brew >/dev/null 2>&1; then
  brew_prefix="$(brew --prefix)"
  for i in $(ls "$brew_prefix/etc/profile.d/"); do
    source "${brew_prefix}/etc/profile.d/$i"
  done
fi

if [ -f ~/.dir_colors ]; then
  test -r ~/.dir_colors && eval $(dircolors ~/.dir_colors)
fi

if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook ${SHELL})"
fi

# ohmyzsh sets up an alias...
if command -v z >/dev/null 2>&1; then
  if command -v _z > /dev/null 2>&1; then
    which _z | zsh
  else
    source $(which z)
  fi
fi
