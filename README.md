# Dotfiles

Collection of my various settings and dotfiles

## Arch Linux
Useful instructions for setting up ArchLinux via WSL.

```powershell
wsl --install archlinux
```

```bash
pacman-key --init
pacman-key --populate archlinux
pacman -Syu

useradd -m -G wheel -s /bin/bash ravi
passwd ravi
```

Give myself sudo access
```
pacman -S sudo vim
EDITOR=vim visudo
```

Uncomment the line `%wheel ALL=(ALL:ALL) NOPASSWD ALL`.
Then log out back to powershell and run
```
archlinux config --default-user ravi
```


## Zsh

## Terminal
Last known working version is 1.25.662.0. Copy the `terminal/settings.json` file to
C:\Users\Ravi\AppData\Local\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json

Replace `Ravi` with username.

##
