#!/bin/bash

# download dired+ to spacemacs dir. clunky temporary workaround. [2019-07-11]
mkdir -p ~/.emacs.d/private/local/dired-plus
wget -m https://www.emacswiki.org/emacs/download/dired%2b.el -O ~/.emacs.d/private/local/dired-plus/dired+.el

SCRIPT_DIR="$(cd "$( dirname "${BASH_SOURCE[0]}")" && pwd )"

LINK_NAME=${SCRIPT_DIR##*/}
link_name=$(echo "$LINK_NAME" | tr '[:upper:]' '[:lower:]')

ln -sf $SCRIPT_DIR/.spacemacs ~/

rm ~/.emacs.d/private/$link_name
# without the rm, the ln will inexplicably link at SCRIPT_DIR if target already exists.
ln -sf $SCRIPT_DIR/ ~/.emacs.d/private/$link_name
