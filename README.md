# mongoose's configure file

- keep it simple, 确保每一项都是我懂得，并且用的上的
- 使用shell脚本来安装，而不是ansible或者其他的类似makefile的工具
- 使用git来管理，subtree而不是submodule来管理vender
- 尽量做到zsh和bash的通用设置


# dependences

- python，autojump 需要用
- bash, 我尽量使用通用的shell而不是bash脚本来管理
- wget/curl，这是为了安装中文的vim手册, 以及 fzf
- tmux，强烈建议安装，但是也不是强制的

# features

## vim/nvim

- manager vim plugins with vim-plug

## zsh/bash
