;; * config.el of private/personal layer
;; ** ergonomics
;; *** restore previous desktop

(desktop-save-mode 1)

;; *** removes annoying left fringe arrow for wrapped lines.
(setq-default fringe-indicator-alist '(
                                       (truncation left-arrow right-arrow)
                                       (continuation nil right-curly-arrow) ;; left-curly-arrow
                                       (overlay-arrow . right-triangle)
                                       (up . up-arrow)
                                       (down . down-arrow)
                                       (top top-left-angle top-right-angle)
                                       (bottom bottom-left-angle bottom-right-angle top-right-angle top-left-angle)
                                       (top-bottom left-bracket right-bracket top-right-angle top-left-angle)
                                       (empty-line . empty-line)
                                       (unknown . question-mark)))


;; ** org-mode
;; *** make org start with wrapped lines.  works.
(setq org-startup-truncated nil)

;; *** word wrap for org only.  works.
(add-hook 'org-mode-hook #'toggle-word-wrap)


;; *** use org UIUDs

;; Use global IDs (for unique links)
(require 'org-id)


;; *** display

(dolist (face '(org-block-begin-line 
                org-block-end-line 
                org-verbatim 
;;                org-block-background
                org-table
                ))
  (set-face-attribute face nil :inherit 'fixed-pitch)
  )

(add-hook 'org-mode-hook 'variable-pitch-mode)

