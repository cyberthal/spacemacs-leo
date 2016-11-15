#!/bin/bash
rm -f ~/.spacemacs
ln -s ~/1-mansort/git-/hub/emacs/spacemacs/personal/.spacemacs ~/

rm -rf ~/.emacs.d/private/personal
ln -s ~/1-mansort/git-/hub/emacs/spacemacs/personal ~/.emacs.d/private/personal
