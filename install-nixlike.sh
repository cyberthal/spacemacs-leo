#!/bin/bash

# * offset

# ** download dired+

# download dired+ to spacemacs dir. clunky temporary workaround. [2019-07-11]
mkdir -p ~/.emacs.d/private/local/dired-plus
wget -m https://www.emacswiki.org/emacs/download/dired%2b.el -O ~/.emacs.d/private/local/dired-plus/dired+.el

# ** symlinks

# find path to repo
SCRIPT_DIR="$(cd "$( dirname "${BASH_SOURCE[0]}")" && pwd )"

# symlink init.el
mkdir -p ~/.spacemacs.d/layers
rm -f ~/.spacemacs.d/init.el
ln -s $SCRIPT_DIR/init.el ~/.spacemacs.d/

# symlink personal directory
rm -f ~/.emacs.d/private/personal
ln -s $SCRIPT_DIR/ ~/.emacs.d/private/personal

# symlink persp-mode Textmind layout
rm -f ~/.emacs.d/.cache/layouts/Textmind-main
ln -s $SCRIPT_DIR/persp-mode/Textmind-main ~/.emacs.d/.cache/layouts/
