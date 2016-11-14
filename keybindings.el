;; * keybindings.el in private/personal layer
;; * code

;; ** enable hyper and super keys

;; make PC keyboard's Win key or other to type Super or Hyper, for emacs running on Windows.
(setq w32-pass-lwindow-to-system nil)
(setq w32-lwindow-modifier 'super) ; Left Windows key

(setq w32-pass-apps-to-system nil)
(setq w32-apps-modifier 'hyper) ; Menu/App key

;; ** cb-

;; bind cb-throw to H-f
(global-set-key (kbd "H-f") 'cb-throw)

;; bind cb-dthrow to H-g
(global-set-key (kbd "H-g") 'cb-dthrow)
;; ** org-mode
(with-eval-after-load 'org 

;; bind org-todo to H-t
(global-set-key (kbd "H-t") 'org-todo)

) ; end org section
;; ** navigation

;; *** outline

;; switch to other window = H-a
(global-set-key (kbd "H-a") 'other-window)

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

;; ** timestamps

(global-set-key (kbd "H-SPC") 'cb-org-time-and-date-stamp-inactive)
======= end

