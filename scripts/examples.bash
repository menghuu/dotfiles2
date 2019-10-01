#!/usr/bin/env bash


command -v inv 2>&1 >/dev/null || python3 -m pip install pyinvoke

# install dep packages
# python3 -m invoke install-dep

# install common packages, it will be very slow
# python3 -m invoke install-common-packages

# install all packages, also, it will be very slow
python3 -m invoke install

# link dotfiles
python3 -m invoke link