#! /usr/bin/env bash
#
# pre_install.sh
# Copyright (C) 2019 humeng <humeng@dl-3>
#
# Distributed under terms of the MIT license.
#
# 安装必要的依赖

set -o errexit

# install conda to install ruby
if ! command -v conda 2>&1 >/dev/null; then
  ( python -m pip install conda ) || pip install conda || echo "cannot install codna"&&  exit 1
fi

# install ruby to install brew
if ! command -v ruby 2>&1 >/dev/null; then
  ( conda install ruby >/dev/null ) || { echo "未能成功安装ruby, 这是为了安装 linuxbrew/homebrew" ; exit 1; }
fi

# install brew to manager packages
if ! command -v brew 2>&1 >/dev/null; then
  if [[ `uname` =~ 'Linux' ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
  elif [[ `uname` =~ 'Darwin' ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    echo "不支持这个操作系统:"$(uname)
    exit 1
  fi
fi

# install mackup to manager dotfiles
if ! command -v mackup 2>&1 >/dev/null; then
  echo "install mackup to manager dotfiles links"
  ( python -m pip install mackup ) || pip install mackup || brew install mackup || { echo "cannot install mackup"; exit 1; }
fi

cat <<EOF
使用 brew 安装 mackup 会消耗很多的时间, 因为需要编译
但是对于工具类的 python 包建议使用 brew 来安装
所以建议当执行完这段程序之后, 使用下面的命令来安装 python 以确保 python 被 brew 安装了

brew install python

EOF
