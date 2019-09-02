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

;; ** Textmind startup

(defun leo-textmind-startup ()
    (interactive)

  (spacemacs/toggle-fullscreen-frame)
  (make-frame)
  (spacemacs/toggle-fullscreen-frame)
  (persp-load-state-from-file "Textmind-main"))
;; ** proc sprinted DONE
;; *** pipify word list DONE

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
;; *** decompose a heading, after saving a mummy of it DONE

(defun leo-decomposing-mummy ()
  "From a single-window frame in org-mode, do setup to decompose a heading."
  (interactive)

  (cond ((unless (string-equal major-mode 'org-mode) t) (user-error "%s" "Error, must be in org-mode"))
        ((unless (eq 1 (length (window-list))) t) (user-error "%s" "Error, must have only one window open in frame"))
        ((unless (progn
                   (org-narrow-to-subtree)
                   (outline-previous-visible-heading 1)
                   (org-at-heading-p)) t) (user-error "%s" "Error, point must be inside a heading"))
        (t (progn

             ;; ensure region ends with two newlines
             (goto-char (point-max))
             (if (bolp)
                 (org-N-empty-lines-before-current 1)
               (insert "\n\n")
               )

             ;; duplicate the heading
             (goto-char (point-max))
             (insert (buffer-substring (point-min) (point-max)))

             ;; title mummy heading
             (goto-char (point-min))
             (org-show-all '(headings))
             (goto-char (line-end-position))
             (insert " | MUMMY")
             (org-cycle)

             ;; create scratch heading
             (org-global-cycle)
             (org-next-visible-heading 1)
             (org-insert-heading '(4))
             (insert "CANOPIC")

             ;; prep CANOPIC heading
             (org-tree-to-indirect-buffer)
             (select-window (next-window))
             (goto-char (point-max))
             (org-insert-heading)
             (org-demote)
             (insert "?")

             ;; prep decomposing heading
             (other-window -1) ; ensures that golden-ratio enlarges home window
             (org-previous-visible-heading 1)
             (org-cycle)
             (org-narrow-to-subtree)
             (org-show-all '(headings))
             (org-cycle-hide-drawers 1)
             )
           )
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
  (leo-snort-visible)

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
    (insert leo-object-text)
    (insert "\n")
    (save-buffer)
    (let ((leo-searched-file-path (concat default-directory "../Inbox.org")))
      (leo-create-inbox-org)
        )
    (leo-insert-to-end-of-buffer)
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
