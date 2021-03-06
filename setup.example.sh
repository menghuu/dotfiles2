#!/usr/bin/env sh

# should run manually, copy/paste and run some specify sections

# install pyenv
#if `command -v pyenv 2>&1 >/dev/null`; then {
    #curl https://pyenv.run | bash
    #git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
#} else {
    #pyenv update
#}
#fi


# create global python env
#pyenv install anaconda3-latest
#pyenv global anaconda3-latest
# using mirror: https://mirrors.tuna.tsinghua.edu.cn/help/anaconda/
# for neovim
conda install pynvim -c conda-forge
conda install tensorflow-mkl attrs flask
conda install pytorch -c pytorch ignite torchtext
command -v tmux 2>&1 >/dev/null || conda install tmux -c conda-forge


# using pip in global env to install packages
command -v pipx 2>&1 >/dev/null || pip install --user pipx
command -v pipx 2>&1 >/dev/null && pipx ensurepath
# using pipx install packages
command -v ranger 2>&1 >/dev/null || pipx install ranger-fm
#command -v poetry 2>&1 >/dev/null || pipx install poetry
#command -v dvc 2>&1 >/dev/null || pipx install dvc[all]


# install brew and using brew install some packages
command -v brew 2>&1 >/dev/null || {
  case `uname` in
    Darwin )
      /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
      HOMEBREW_NO_AUTO_UPDATE=1
      brew install coreutils
      brew install bash-completion
      ;;
    Linux )
      conda install ruby
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
      ;;
  esac

  command -v nvim 2>&1 >/dev/null || brew install neovim
  command -v trash-put 2>&1 >/dev/null || brew install trash-cli
  command -v wget 2>&1 >/dev/null || brew install wget
  command -v curl 2>&1 >/dev/null || brew install curl
  command -v fzf 2>&1 >/dev/null || brew install fzf
  command -v stow 2>&1 >/dev/null || brew install stow
  command -v npm 2>&1 >/dev/null || brew install nodejs
  command -v ctags 2?&1 >/dev/null || brew install --HEAD universal-ctags/universal-ctags/universal-ctags
}

# install tpm
mkdir -p ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm


# install direnv (currently support macos and linux amd64)
direnv_url="https://github.com/direnv/direnv/releases/latest/download/direnv.`uname`-amd64"
direnv_save_path=${HOME}/.local/bin/direnv
[ -e ${direnv_save_path} ] || wget $direnv_url -O $direnv_save_path and chmod u+x $direnv_save_path



# install vim chinese language documents

[ -e ~/.vim/doc/map.cnx ] || (
    vimcdoc_url='https://sourceforge.net/projects/vimcdoc/files/vimcdoc/vimcdoc-2.1.0.tar.gz/download'
    tmp_dir=`mktemp -d`
    curl -L -s -o $tmp_dir/vimcdoc.tar.gz ${vimcdoc_url}
    tar -xzf $tmp_dir/vimcdoc.tar.gz -C $tmp_dir \
        && cd $(find $tmp_dir -maxdepth 1 -type d -name "vimcdoc*") \
        && sh ./vimcdoc.sh -i && cd $HOME && \rm -fr $tmp_dir
)


# install vim-plug
[ -e ./dotfiles/.vim/autoload/plug.vim ] \
    || curl -fLo ./dotfiles/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim



# make sure the stow link work better
# it will make sure the other config in .config will not influce the .config in git repo
mkdir -p ~/.config
# actually, if those files are link, it will just remove the link not the origin files/dirs
# if thoese files exists, stow will link the files under those dir, it is not I wish
trash-put -rf ~/.config/nvim
trash-put -rf ~/.config/shell
trash-put -rf ~/.vim
trash-put -rf ~/.tmux

git clone https://github.com/skywind3000/z.lua.git ~/apps/z.lua
git clone --depth 1 https://github.com/junegunn/fzf.git ~/apps/fzf

~/apps/fzf/install --all

stow -t $HOME dotfiles

echo 'source ~/.config/shell/rc.commons' >> ~/.bashrc

python3 -m venv ~/.config/nvim/env
source ~/.config/nvim/env/bin/activate
pip install pynvim jedi psutil setproctitle yapf black flake8 flake8-bugbear python-language-server[all]
deactivate
