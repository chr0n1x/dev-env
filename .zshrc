function dex {
  if docker version &> /dev/null; then
    docker run -v $(pwd):/root/workspace --workdir /root/workspace --rm -ti "$@"
  else
    echo "Docker isn't installed or has not been started."
  fi
}

function dvim {
    dex --entrypoint "vim" chr0n1x/dev-env
}

alias dc="docker compose"

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

if [ "${SHELL}" = "/bin/zsh" ]; then
  autoload -Uz compinit && compinit
fi

if [ -z "${SHELL}" ]; then
  SHELL=bash
fi

eval "$(direnv hook ${SHELL})"
