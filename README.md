# mongoose's dotfiles 

- keep it simple, make sure I need them all
- installed by bash
- using subtree in git not submodule
- Bash/zsh supports
- Linux/Mac/windows supports

# dependences

- Bash, using to install the configurations
- coreutils, in mac, should installed by `brew install coreutils` and add `PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH` to `.bashrc` or `.zshrc`
- Lua, dependented by z.lua
- wget/curl，to install other tools
- tmux，todo: shuld Mac installed it?
- vim/nvim，need python3 support

# features

## vim/nvim

- manager vim plugins with vim-plug

## zsh/bash

- aliases
- key bindings

## quick start

## pre step

- install `lua` to use `z.lua`
- install `neovim` to have the full feature of vim config
- install `wget` and `curl` to download some thrid part software
- options: `tmux`

## install

- `git clone https://github.com/menghuu/dotfiles2.git`
- `cd dotfiles2`
- `chmod u+x install`
- `./install`
