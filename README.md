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
sudo pacman -S fzf eza zoxide fd ripgrep bat git-delta tldr yazi
sudo pacman -S npm python3
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

Log out and log back in to enter into zsh. Run `miniplug install` the first time you open it.

## Git Delta
Add the following to ~/.gitconfig

```
[core]
    pager = delta

[interactive]
    diffFilter = delta --color-only

[delta]
    navigate = true  # use n and N to move between diff sections
    dark = true      # or light = true, or omit for auto-detection

[merge]
    conflictStyle = zdiff3
```

## Terminal
Last known working version is 1.25.662.0. Copy the `terminal/settings.json` file to
C:\Users\Ravi\AppData\Local\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json

Replace `Ravi` with username.

## Neovim
Clone and use neovim
```
git clone https://github.com/drakari7/nvim.git
```

Most of the lsp servers require npm for Mason to install them.

## Windows Registry Changes
Change keystroke repeat delay to values I like in the windows registry
```
[HKEY_CURRENT_USER\Control Panel\Accessibility\Keyboard Response]
AutoRepeatDelay = 250
AutoRepeatRate = 13
BounceTime = 0
DelayBeforeAcceptance = 0
Flags = 59
```

Remember to log out and log back in for these changes to take place.

## Power Toys
Dont remember what these mappings were in power toys for, but here they are
Win + Ctrl + Alt + Shift (Hyper) + h -> Win + Ctrl + left
Hyper + l -> Win + Ctrl + right
