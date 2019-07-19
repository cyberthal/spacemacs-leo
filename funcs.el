;; * funcs.el in private/personal layer

;; ** Insert inactive timestamp of current time

(defun ts-org-time-and-date-stamp-inactive () 
  "Insert inactive timestamp of current time"

  ;; Calls org-time-stamp-inactive with universal prefix
  (interactive)
  (org-insert-time-stamp (current-time) t t)
  )
