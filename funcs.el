;; * funcs.el in private/personal layer
;; * offset
;; ** Insert inactive timestamp of current time

(defun leo-org-time-and-date-stamp-inactive ()
  "Insert inactive timestamp of current time"

  ;; Calls org-time-stamp-inactive with universal prefix
  (interactive)
  (org-insert-time-stamp (current-time) t t)
  )

;; ** leo-checklist-to-not-done

(defun leo-checklist-to-not-done
    ()
  "Replaces all checklist X with SPACE"
  (interactive)

  (save-excursion
    (while (search-forward "[X]" nil t)
      (replace-match "[ ]" nil t))
    )
  )

;; Org-Mode: "boxes" Advance down org-mode checklist with C-S-n
(fset 'boxes
      (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("" 0 "%d")) arg)))
;; binding it to a handy key, since as a command it won't macro repeat
(global-set-key (kbd "C-S-n") 'boxes)

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

  (if (eq user-full-name "demo")
      (persp-load-state-from-file "Textmind-demo")
    (persp-load-state-from-file "Textmind-main"))

  )

;; ** proc sprinted
;; *** pipify word list

(defun leo-pipify-word-list (arg)
  "Converts multi-line word list into one line separated by pipes."
  (interactive "p")

  (dotimes (number arg)
    (end-of-line)
    (insert " | ")
    (delete-char 1)
    (end-of-line)
    )
  )

;; *** Textmind checklist funcs DONE
;; **** create new sprinting DONE

(defun leo-create-new-sprinting ()
    "Make new sprinting heading in '1sprinting.org"
    (interactive)

  (set-buffer "'1sprinting.org")
  (widen)
  (goto-char (point-max))
  (insert "Created new sprinting heading via leo-create-new-sprinting\n")
  (insert (concat "\n\n* Sprinting " (leo-org-time-and-date-stamp-inactive) "\n\n** proc sprinted\n\n*** deletion pass from bottom up\n\n"))
  (save-buffer))

;; **** double-file prior sprinting log DONE

;; ***** cut DONE

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

;; ***** paste DONE

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
;; **** deletion pass DONE

(defun leo-proc-sprinted-deletion-pass ()
    "Setup other frame to begin deletion pass for proc sprinted checklist."

  (other-frame 1)
  (delete-other-windows)
  (assert (file-exists-p "~/1-Mansort/1-Textmind/2-Linked/Inbox.org"))
  (find-file "~/1-Mansort/1-Textmind/2-Linked/Inbox.org")
  (org-show-all)
  (goto-char (point-max))
  )
;; **** headingfy DONE

(defun leo-headingfy ()
  "Create a heading and advance 2 paragraphs."
  (interactive)

  (org-open-line 2)
  (org-insert-heading)
  (insert "?")
  (org-forward-paragraph)
  (org-forward-paragraph)
  (recenter-top-bottom 10)
  )
;; **** lazy-title DONE

(defun leo-lazy-title ()
  "Advance to next heading while lazy-titling proc sprinted."
  (interactive)

  (org-narrow-to-subtree)
  (org-previous-visible-heading 1)
  (widen)
  (org-cycle)
  (org-next-visible-heading 1)
  (org-narrow-to-subtree)
  (goto-char (line-end-position))
  )
