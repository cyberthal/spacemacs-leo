#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

rm -f ~/.spacemacs
ln -s $SCRIPT_DIR/../../.spacemacs ~/

rm -rf ~/.emacs.d/private/personal
ln -s $SCRIPT_DIR/../../ ~/.emacs.d/private/personal

cp $SCRIPT_DIR/../maintext-toggle.el.bak $SCRIPT_DIR/../../maintext-toggle.el
