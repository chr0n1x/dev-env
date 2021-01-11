dev-env
=========

[![Build Status](https://travis-ci.com/chr0n1x/dev-env.svg?branch=main)](https://travis-ci.org/chr0n1x/dev-env)
[![](https://images.microbadger.com/badges/image/chr0n1x/dev-env.svg)](https://microbadger.com/images/chr0n1x/dev-env "layer-metadata")
[![](https://images.microbadger.com/badges/version/chr0n1x/dev-env.svg)](https://hub.docker.com/r/chr0n1x/dev-env/ "docker-hub")

My VIM setup, wrapped into a docker container (automated build). Also includes other common dev tools such as [the silver searcher (aka: ag)](https://github.com/ggreer/the_silver_searcher). A full list is forthcoming since I'm still in the process of adding things to this project.

I did this because I've had to switch machines WAY too many times. Another reason though is because I wanted a similar development experience between my MacOS, Linux & Windows machines so I figured that docker was the way to go.

# Aliases

I personally like to have two separate aliases, only one of which directly uses this container. The first is the `dex` alias (short for `docker exec`). I like to use this as a shortcut for:

```bash
docker run -v $(pwd):/root/workspace --workdir /root/workspace --rm -ti "$@"
```

This allows me to mount my current working directory into `/root/workspace` for any arbitrary container. So for example if I am working on a python project and I'm in that project directory, I just use `dex python:3.6` and I am automatically dropped into a shell environment that has all development tools necessary to work on that project (e.g.: python runtime, `pip`, etc).

However, because my VIM installation is a bit more involved and needs tools that may be separate from whatever language I'm working in I have the `dvim` alias (short for `docker-vim`). This alias uses `dex` in conjunction with this container.

## Bash

```bash
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
```

## Powershell

```powershell
function docker-enter-fx {
  Invoke-Expression "docker run -v $(pwd):/root/workspace --workdir /root/workspace --rm -ti $args"
}
Set-Alias dex docker-enter-fx

function docker-enter-vim {
  dex --entrypoint "vim" "chr0n1x/dev-env"
}
Set-Alias dvim docker-enter-vim
```

I would recommend using [cmder](https://github.com/cmderdev/cmder) on Windows for the sake of ease-of-use & portability.

To install you just have to copy & paste the script above into `<CMDER INSTALLATION DIR>/config/profile.d/<script-name>.ps1` and cmder will auto-load it.

If instead you want to use the [Windows Powershell](https://en.wikipedia.org/wiki/PowerShell) (can be installed via the Windows Store App), you can add the powershell script above into `C:\Users\<USERNAME>\Documents\WindowsPowerShell\profile.ps1`. Then, after opening up Powershell, you may get an error:

```
Windows PowerShell
Copyright (C) Microsoft Corporation. All rights reserved.

Try the new cross-platform PowerShell https://aka.ms/pscore6

. : File C:\Users\<USERNAME>\Documents\WindowsPowerShell\profile.ps1 cannot be loaded because running scripts is disabled
on this system. For more information, see about_Execution_Policies at https:/go.microsoft.com/fwlink/?LinkID=135170.
At line:1 char:3
+ . 'C:\Users\<USERNAME>\Documents\WindowsPowerShell\profile.ps1'
+   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : SecurityError: (:) [], PSSecurityException
    + FullyQualifiedErrorId : UnauthorizedAccess
```

Kind of makes sense - Windows is blocking the arbitrary autoloading of scripts in your profile. To allow the autoloading of scripts for your account, you could run the following command (sourced from [this StackOverflow answer](https://stackoverflow.com/a/26955050/158584) - read to know what it's doing):

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

# Notes

I recommend using this setup with your native docker settings maxed for memory (on MacOS the memory/cpu allowance for docker is only a fraction of what your system is capable of). I max out both CPU + Memory so that vim runs @ near-native speeds.

**DISCLAIMER**: `autocmd` spam and other VIM plugins like gitgutter severely slow this setup down just due to the file mount & virtualization overhead.
