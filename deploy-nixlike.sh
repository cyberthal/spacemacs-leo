#!/bin/bash

SCRIPT_DIR="$(cd "$( dirname "${BASH_SOURCE[0]}")" && pwd )"

LINK_NAME=${SCRIPT_DIR##*/}
link_name=$(echo "$LINK_NAME" | tr '[:upper:]' '[:lower:]')

ln -sf $SCRIPT_DIR/.spacemacs ~/

rm ~/.emacs.d/private/$link_name
# without the rm, the ln will inexplicably link at SCRIPT_DIR if target already exists.
ln -sf $SCRIPT_DIR/ ~/.emacs.d/private/$link_name
