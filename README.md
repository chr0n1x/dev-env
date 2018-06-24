dev-env
=========

Config files and stuff. Everything in a docker container so that I can dev however I want without nuking my host-local-machine thingy.

# Bash Alias

```bash
function dev-env {
  if docker version; then
    docker run -v $(pwd):/root/workspace --workdir /root/workspace --rm -ti chr0n1x/dev-env
  else
    echo "Docker isn't installed, man."
  fi
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
