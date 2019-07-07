#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

rm -f ~/.spacemacs
cp $SCRIPT_DIR/../../../.spacemacs ~/

cp $SCRIPT_DIR/../../maintext-toggle.el.bak $SCRIPT_DIR/../../../maintext-toggle.el

rm -rf ~/.emacs.d/private/personal
cp $SCRIPT_DIR/../../../ ~/.emacs.d/private/personal
