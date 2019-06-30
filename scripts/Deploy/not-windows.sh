#!/bin/bash

SCRIPT_DIR="$(cd "$( dirname "${BASH_SOURCE[0]}")" && cd ../../ && pwd )"

LINK_NAME=${SCRIPT_DIR##*/}
# to follow Spacemacs convention, layer directories should be lowercase 

ln -sf $SCRIPT_DIR/.spacemacs ~/

rm ~/.emacs.d/private/$LINK_NAME
# without the rm, the ln will inexplicably link at SCRIPT_DIR if target already exists.
ln -sf $SCRIPT_DIR/ ~/.emacs.d/private/$LINK_NAME

cp -f $SCRIPT_DIR/scripts/maintext-toggle.el.bak $SCRIPT_DIR/maintext-toggle.el
