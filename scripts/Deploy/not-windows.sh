#!/bin/bash

SCRIPT_DIR="$(cd "$( dirname "${BASH_SOURCE[0]}")" && cd ../../ && pwd )"

LINK_NAME=${SCRIPT_DIR##*/}
link_name=$(echo "$LINK_NAME" | tr '[:upper:]' '[:lower:]')

ln -sf $SCRIPT_DIR/.spacemacs ~/

ln -sf $SCRIPT_DIR/ ~/.emacs.d/private/$link_name

cp -f $SCRIPT_DIR/scripts/maintext-toggle.el.bak $SCRIPT_DIR/maintext-toggle.el
