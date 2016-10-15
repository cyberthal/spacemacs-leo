;; * funcs.el in private/personal layer

;; ** C-c k QUICK KILL

;; faster scratch file deletion - defining the function
(defun delete-this-buffer-and-file ()
  "Removes file connected to current buffer and kills buffer."
  (interactive)
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (when (yes-or-no-p "Are you sure you want to remove this file? ")
        (delete-file filename)
        (kill-buffer buffer)
        (message "File '%s' successfully removed" filename)))))

;; bound function to C-c k
(global-set-key (kbd "C-c k") 'delete-this-buffer-and-file) 



