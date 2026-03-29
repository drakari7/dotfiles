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

Uncomment the line `%wheel ALL=(ALL:ALL) NOPASSWD: ALL`.
Then log out back to powershell and run
```
wsl --manage archlinux --set-default-user ravi
```

WSL is all set.

## Pacman packages
You probably want to install most of these packages in varying levels of priority.
```
sudo pacman -S base-devel git curl unzip zip man-db man-pages htop openssh
```

## Zsh 
Install and use zsh
```
sudo pacman -S zsh starship
```

Copy the `zsh` folder to `~/.config/zsh`. Export ZDOTDIR value in your ~/.zshenv
```
echo 'export ZDOTDIR="$HOME/.config/zsh"' >> ~/.zshenv
chsh -s /bin/zsh
```

## Terminal
Last known working version is 1.25.662.0. Copy the `terminal/settings.json` file to
C:\Users\Ravi\AppData\Local\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json

Replace `Ravi` with username.

##
