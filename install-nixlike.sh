#!/bin/bash

# * offset

# ** download dired+

# download dired+ to spacemacs dir. clunky temporary workaround. [2019-07-11]
mkdir -p ~/.emacs.d/private/local/dired-plus
wget -m https://www.emacswiki.org/emacs/download/dired%2b.el -O ~/.emacs.d/private/local/dired-plus/dired+.el

# ** symlinks

# find path to repo
SCRIPT_DIR="$(cd "$( dirname "${BASH_SOURCE[0]}")" && pwd )"

# link init.el
mkdir ~/Spacemacs/
rm -f ~/Spacemacs/init.el
ln -s $SCRIPT_DIR/init.el ~/Spacemacs/

# link personal directory
LINK_NAME="personal"
rm -f ~/Spacemacs/$LINK_NAME
ln -s $SCRIPT_DIR/ ~/Spacemacs/$LINK_NAME
