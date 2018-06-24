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
function docker-enter-dev-env {
  Invoke-Expression "docker run -v $(pwd):/root/workspace --workdir /root/workspace --rm -ti chr0n1x/dev-env"
}

Set-Alias dev-env docker-enter-dev-env
```

I would recommend using [cmder](https://github.com/cmderdev/cmder) on Windows.
Take the script above and put it into `<CMDER INSTALLATION DIR>/config/profile.d/<script-name>.ps1` and cmder will auto-load it.
