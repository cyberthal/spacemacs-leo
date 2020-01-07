#!/bin/bash

# * offset

# ** symlinks

# find path to repo
SCRIPT_DIR="$(cd "$( dirname "${BASH_SOURCE[0]}")" && pwd )"

# symlink init.el
mkdir -p ~/.spacemacs.d/layers
rm -f ~/.spacemacs.d/init.el
ln -s $SCRIPT_DIR/init.el ~/.spacemacs.d/

# symlink personal directory
rm -f ~/.emacs.d/private/leo
ln -s $SCRIPT_DIR/ ~/.emacs.d/private/leo

# symlink persp-mode Textmind layout
rm -f ~/.emacs.d/.cache/layouts/Textmind-main
rm -f ~/.emacs.d/.cache/layouts/Textmind-demo
mkdir -p ~/.emacs.d/.cache/layouts/
ln -s $SCRIPT_DIR/persp-mode/Textmind-main ~/.emacs.d/.cache/layouts/
ln -s $SCRIPT_DIR/persp-mode/Textmind-demo ~/.emacs.d/.cache/layouts/

# remove default .spacemacs
mv -f ~/.spacemacs ~/.spacemacs-bak
