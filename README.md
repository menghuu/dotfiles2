# mongoose's dotfiles 

- testing on linux and mac
- testing on bash
- testing on python3.7
- include `install package` and `link dotfile`

## quick start

- `git clone https://github.com/menghuu/dotfiles2.git`
- `cd dotfiles2`
- `python3 -m pip install invoke`
- `python3 -m invoke install link patch`
- now, I want to remove invoke depedences and will using pure shell script to install packages
- and using stow to manage dotfile link

### details

see [examples](./scripts/examples.bash)
see [setup.example.sh](./setup.example.sh) to install packages instead of using pyinvoke to install packages

# dependences

- `invoke`, I will remove this depedence later

# features

## vim/nvim

- manager vim plugins with vim-plug

## zsh/bash(zsh not testing well)

- aliases
- key bindings
