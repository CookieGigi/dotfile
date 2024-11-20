This config is only tested on Ubuntu 22.04

# List

## Stow

Use [Stow](https://www.gnu.org/software/stow/) to store this files in "dotfile" directory instead directly in home directory in middle of the other file.

```console
stow .
```

## Alacritty

Use [Alacritty](https://alacritty.org/) as terminal emulator

## TMUX

Use [TMUX](https://github.com/tmux/tmux/wiki) as terminal multiplexer

## NeoVim 

Use [NeoVim](https://neovim.io/) as IDE

# Setup

Ubuntu 22.04 :
```console
# update
sudo apt update && sudo apt upgrade

# useful stuff
sudo apt install git

# stow
sudo apt install stow

# alacritty
sudo apt install alacritty

# tmux
sudo apt install tmux

# neovim (/!\ Problem can occur depending of which version is available on official repo)
sudo apt install neovim 

# luarocks (use by neovim)
sudo apt install luarocks

# Rust-analzrer
Install Rust toolchain

# lua-language-server
Install via homebrew
```
