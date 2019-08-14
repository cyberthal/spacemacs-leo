;; * Toggle whether maintext autoloads
;; * Set the search locations

;; ** for org-agenda

(defun trs-clear-org-agenda ()
  "Empties org-agenda-files"
  (interactive)
  (setq org-agenda-files nil)
  )

(defun trs-refresh-org-agenda ()
  "Fixes broken agenda from new, moved or moved files."
  (interactive)

  (with-eval-after-load 'org
    ;; indent two spaces or toggle script won't work
    ;; Excludes /deferred and /notes to avoid agenda lag.
    (trs-clear-org-agenda)
    (load-org-agenda-files-recursively "~/1-Mansort/1-Textmind/1-Agenda/" ) ; trailing slash required
    )

)

(trs-refresh-org-agenda)

;; ** for text searches

;; ensures that e.g. links to files in /notes can be found without resorting to grep
(setq org-agenda-text-search-extra-files
      (directory-files-recursively "~/1-Mansort/1-Textmind/2-Linked/" ".org") ; trailing slash required
      )

;; * footer

(provide 'maintext-toggle)
