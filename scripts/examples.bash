#!/usr/bin/env bash


command -v inv 2>&1 >/dev/null || python3 -m pip install pyinvoke

# install dep packages
python3 -m inv install-dep

# install common packages, it will be very slow
python3 -m inv install-common-packages

# install all packages, also, it will be very slow
python3 -m inv install

# link dotfiles
python3 -m inv link