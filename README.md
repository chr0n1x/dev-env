dev-env
=========

Config files and stuff. Everything in a docker container so that I can dev however I want without nuking my host-local-machine thingy.

# Bash Alias

```bash
function dex {
  if docker version &> /dev/null; then
    docker run -v $(pwd):/root/workspace --workdir /root/workspace --rm -ti "$@"
  else
    echo "Docker isn't installed, man."
  fi
}

function dvim {
    dex --entrypoint "vim" chr0n1x/dev-env
}
```

# Powershell Alias

```powershell
function docker-enter-fx {
  Invoke-Expression "docker run -v $(pwd):/root/workspace --workdir /root/workspace --rm -ti $args"
}
Set-Alias dex docker-enter-fx

function docker-enter-dev-env {
  dex "chr0n1x/dev-env"
}
Set-Alias dev-env docker-enter-dev-env
```

I would recommend using [cmder](https://github.com/cmderdev/cmder) on Windows.
The script above is an example as to how you can use this. First function allowing you to load your current working directory (code and stuffs) into the appropriate docker container for all your code (so you can build dependencies, run the code, etc) and the second uses the same fx to just throw all of that code into an environment with this vim installation.

To install you just have to copy & paste it into `<CMDER INSTALLATION DIR>/config/profile.d/<script-name>.ps1` and cmder will auto-load it.

# Notes

I recommend using this setup with your native docker settings maxed for memory (on MacOS the memory/cpu allowance for docker is only a fraction of what your system is capable of). This is so that using `hjkl` doesn't stutter, and other basic functions like `Ctrl+p` don't take **forever**. I max out both CPU + Memory so that vim runs @ near-native speeds
