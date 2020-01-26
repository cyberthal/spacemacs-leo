;; * funcs.el in private/leo layer
;; * offset
;; ** set fonts

(defun leo-set-fonts ()
  (interactive)

  (cond ((member "Palatino" (font-family-list)) (set-face-font 'variable-pitch "Palatino"))
        ((member "Garamond" (font-family-list)) (set-face-font 'variable-pitch "Garamond"))
        ((member "Georgia" (font-family-list)) (set-face-font 'variable-pitch "Georgia"))
        ((member "aakar" (font-family-list)) (set-face-font 'variable-pitch "aakar"))
        ((member "Times New Roman" (font-family-list)) (set-face-font 'variable-pitch "Times New Roman"))))
;; ** Linux xmodmap trigger

(defun leo-xmodmap ()
  (interactive)
  (start-process-shell-command "xmodmap" nil "xmodmap" "~/.Xmodmap")
  )

(when (eq system-type 'gnu/linux)
  (global-set-key (kbd "<menu>") 'leo-xmodmap)
  )

;; ** Textmind startup

(defun leo-textmind-startup ()
  (interactive)

  (leo-set-fonts)
  (spacemacs/toggle-fullscreen-frame)
  (make-frame)
  (spacemacs/toggle-fullscreen-frame)

  (if (string-equal user-full-name "demo")
      (persp-load-state-from-file "Textmind-demo")
    (persp-load-state-from-file "Textmind-main"))

  )

;; ** proc sprinted
;; *** Textmind checklist funcs
;; **** create new sprinting

(defun leo-create-new-sprinting ()
    "Make new sprinting heading in '1sprinting.org"
    (interactive)

  (set-buffer "'1sprinting.org")
  (widen)
  (goto-char (point-max))
  (insert "Created new sprinting heading via leo-create-new-sprinting\n")
  (insert (concat "\n\n* Sprinting " (leo-org-timestamp-now-inactive) "\n\n** proc sprinted\n\n*** deletion pass from bottom up\n\n"))
  (save-buffer))

;; **** double-file prior sprinting log

;; ***** cut

(defun leo-cut-prior-sprinting ()
  "File prior sprinting heading twice to '2sprinted.org"

  (set-buffer "'1sprinting.org")
  (widen)
  (goto-char (point-min))
  (if (org-at-heading-p)
      ()
    (org-next-visible-heading 1))
  (assert (string-equal "* "
           (buffer-substring (point) (+ (point) 2)))
          nil "Buffer should begin with a one-star headline")

  (org-narrow-to-subtree)
  (org-global-cycle)
  (org-demote-subtree)
  (org-demote-subtree)
  (org-demote-subtree)
  (trs-snort-visible)

  ;; is this necessary?
  (goto-char (point-max))
  )

;; ***** paste

(defun leo-double-file-prior-sprinting ()
  "File prior sprinting heading twice to '2sprinted.org"

    (leo-cut-prior-sprinting)

    (assert (file-exists-p "~/1-Mansort/1-Textmind/2-Linked/8-Hud/'2sprinted.org"))
    (find-file "~/1-Mansort/1-Textmind/2-Linked/8-Hud/'2sprinted.org")

    (goto-char (point-min))
    (word-search-forward "Log")
    (org-show-all '(headings))
    (org-cycle)
    (org-cycle)
    (org-forward-heading-same-level 1)
    (insert "\n")
    (backward-char)
    (insert trs-object-text)
    (insert "\n")
    (save-buffer)
    (let ((trs-searched-file-path (concat default-directory "../Inbox.org")))
      (trs-create-inbox-org)
        )
    (trs-insert-to-end-of-buffer)
    (save-buffer)
    (switch-to-buffer "'Meta.org")
  )
;; **** deletion pass

(defun leo-proc-sprinted-deletion-pass ()
    "Setup other frame to begin deletion pass for proc sprinted checklist."

  (other-frame 1)
  (delete-other-windows)
  (assert (file-exists-p "~/1-Mansort/1-Textmind/2-Linked/Inbox.org"))
  (find-file "~/1-Mansort/1-Textmind/2-Linked/Inbox.org")
  (org-show-all)
  (goto-char (point-max))
  )
