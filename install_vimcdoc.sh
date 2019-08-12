#!/bin/bash -
#===============================================================================
#
#          FILE: install_vimcdoc.sh
#
#         USAGE: ./install_vimcdoc.sh
#
#   DESCRIPTION: 
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 08/12/19 04:07:44
#      REVISION:  ---
#===============================================================================

set -o nounset                                  # Treat unset variables as an error

vimcdoc_url="https://sourceforge.net/projects/vimcdoc/files/vimcdoc/vimcdoc-2.1.0.tar.gz/download"
tmp_dir=$(mktemp -d) && curl -L -s -o "${tmp_dir}/vimcdoc.tar.gz" ${vimcdoc_url} \
  && tar -xzf "${tmp_dir}/vimcdoc.tar.gz" -C "${tmp_dir}" \
  && (cd $(find ${tmp_dir} -maxdepth 1 -type d -name 'vimcdoc*') \
  && sh ./vimcdoc.sh -i > /dev/null) \
  && rm -fr ${tmp_dir}
