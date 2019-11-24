;; * keybindings.el in private/personal layer
;; * code

;; ** enable hyper and super keys

;; make PC keyboard's Win key or other to type Super or Hyper, for emacs running on Windows.
(setq w32-pass-lwindow-to-system nil)
(setq w32-lwindow-modifier 'super) ; Left Windows key

(setq w32-pass-apps-to-system nil)
(setq w32-apps-modifier 'hyper) ; Menu/App key

;; on a mac: make the appkey on my external windows keyboard
;; that has switched the appkey to Fn using karabiner
;; function as super modifier
(setq ns-function-modifier 'hyper)

;; ** Treefactor

(global-set-key (kbd "H-f") 'leo-refile)
(global-set-key (kbd "H-g") 'leo-refile-up)
(global-set-key (kbd "C-c k") 'leo-delete-this-buffer-and-file)
(global-set-key (kbd "s-n") 'leo-pipify-word-list)
(global-set-key (kbd "C-c l") 'leo-org-store-link-fold-drawer)

;; ** org-mode

(with-eval-after-load 'org

  (global-set-key (kbd "H-t") 'org-todo)

  (global-set-key (kbd "H-SPC") 'leo-org-time-and-date-stamp-inactive)
  (global-set-key (kbd "s-SPC") 'org-time-stamp)
  )

;; ** navigation

;; *** outline

;; **** switching windows/frames

;; switch to other window = H-a
(global-set-key (kbd "H-a") 'other-window)

;; switch to other frame = s-;
(global-set-key (kbd "s-;") 'other-frame)

;; **** indirect buffers

;; make an indirect buffer with narrowed tree for outshine
(global-set-key (kbd "H-c H-x b") 'outline-next-visible-heading)

;; make an indirect buffer other window
(global-set-key (kbd "H-b") 'clone-indirect-buffer-other-window)

;; **** heading movement

;; bind H-w to move up headline
(global-set-key (kbd "H-w") 'outline-up-heading)

;; go to previous heading = bind H-e
(global-set-key (kbd "H-e") 'outline-previous-visible-heading)

;; go to next heading = H-r
(global-set-key (kbd "H-r") 'outline-next-visible-heading)

;; **** narrow/widen visible region

(with-eval-after-load 'org
;; bind org-narrow-to-subtree to H-d
(global-set-key (kbd "H-d") 'org-narrow-to-subtree)
)
;; bind widen to H-s
(global-set-key (kbd "H-s") 'widen)

;; *** misc

;; bind H-z switch buffer
(global-set-key (kbd "H-z") 'ido-switch-buffer)

;; bind forward and backward sentence to Super home row
(global-set-key (kbd "s-j") 'backward-sentence)
(global-set-key (kbd "s-k") 'forward-sentence)

;; ** window layout

;; delete other windows = H-1
(global-set-key (kbd "H-1") 'spacemacs/toggle-maximize-buffer)

;; delete current window = H-2
(global-set-key (kbd "H-2") 'delete-window)

;; split window vertically
(global-set-key (kbd "H-3") 'split-window-right)

;; projectile prefix key
(with-eval-after-load 'projectile
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  )
;; ** save & vc

(global-set-key (kbd "s-s") 'save-some-buffers)

;; disable annoying s-w kill-frame keybind
;; and replace it with useful magit-status shortcut
(global-set-key (kbd "s-w") 'magit-status)

;; ** dired

(global-set-key (kbd "s-i") 'spacemacs/helm-find-files)
