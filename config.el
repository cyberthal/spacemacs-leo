;; * config.el of private/personal layer
;; * top
;; ** ergonomics
;; *** visual
;; **** nyan-mode

                                        ; (spaceline-toggle-nyan-cat-on)

;; **** removes annoying left fringe arrow for wrapped lines.
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


;; *** restore previous desktop

(add-hook 'spacemacs-post-user-config-hook
          (lambda ()
            (desktop-save-mode)
            (desktop-read)))

;; *** dired sorting by directories first

(setq dired-listing-switches "-alGh --group-directories-first")

(add-hook
 'dired-before-readin-hook
 (lambda ()
   (when (file-remote-p default-directory)
     (setq dired-actual-switches "-al"))))

;; *** outshine

(add-hook 'ahk-mode-hook 'outline-minor-mode)



;; ** org-mode
(with-eval-after-load 'org 
;; *** make org start with wrapped lines.  works.
(setq org-startup-truncated nil)
(setq line-move-visual nil)

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

;; *** org priorities 0-9

(setq org-highest-priority ?0)
(setq org-lowest-priority ?9)
(setq org-default-priority ?5)
;; *** load org agenda files recursively

;; http://stackoverflow.com/questions/17215868/recursively-adding-org-files-in-a-top-level-directory-for-org-agenda-files-take

;; Collect all .org from my Org directory and subdirs

;; **** setup the search function

(setq org-agenda-file-regexp "\\`[^.].*\\.org\\'") ; default value
(setq org-agenda-files nil)
(defun load-org-agenda-files-recursively (dir) "Find all directories in DIR."
    (unless (file-directory-p dir) (error "Not a directory `%s'" dir))
    (unless (equal (directory-files dir nil org-agenda-file-regexp t) nil)
      (add-to-list 'org-agenda-files dir)
    )
    (dolist (file (directory-files dir nil nil t))
        (unless (member file '("." ".."))
            (let ((file (concat dir file "/")))
                (when (file-directory-p file)
                    (load-org-agenda-files-recursively file)
                )
            )
        )
    )
)

;; **** set the search locations

; add every dir but topical
; cuz it's too big.  and because I need a place to pseudo-archive surplus TODO/DONE entries 

(load-org-agenda-files-recursively "~/1-mansort/1-main-text/1-human/0-inbox/" )
(load-org-agenda-files-recursively "~/1-mansort/1-main-text/1-human/1-time/" )
(load-org-agenda-files-recursively "~/1-mansort/1-main-text/1-human/2-people/" )
(load-org-agenda-files-recursively "~/1-mansort/1-main-text/1-human/3-todo/" )
(load-org-agenda-files-recursively "~/1-mansort/1-main-text/1-human/5-scratch/" )

;; *** end org-mode block

) 

