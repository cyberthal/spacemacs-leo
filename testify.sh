#!/bin/bash

# perl -pi.bak -e 's/\n\(load-org-agenda-files-recursively/\n;\(load-org-agenda-files-recursively/g' config.el

perl -pi.bak -e 's/^\(load-org-agenda-files-recursively/;\(load-org-agenda-files-recursively/g' config.el
