;; * config.el of private/leo layer
;; * offset
;; ** ergonomics
;; *** visual
;; **** golden ratio mode on

(with-eval-after-load 'org
  (spacemacs/toggle-golden-ratio-on))

;; *** dired
;; **** omit by default

;; no other way to set this as default
(add-hook 'dired-mode-hook (lambda () (dired-omit-mode)))

;; **** dired sorting switches, by OS

(setq dired-listing-switches
      (cond
       ((equal system-type 'darwin) "-ADhlv --group-directories-first")
       ((equal system-type 'gnu/linux) "-alGhv --group-directories-first")
       (t "-al")))

;; remote?
(add-hook
 'dired-before-readin-hook
 (lambda ()
   (when (file-remote-p default-directory)
     (setq dired-actual-switches "-al"))))

;; *** outshine in .ahk

(add-hook 'ahk-mode-hook 'outline-minor-mode)

;; ** Org mode
(with-eval-after-load 'org

  ;; prose with markup needs more line spacing
  (defun leo-space-lines ()
    (setq line-spacing 0.175))
  (add-hook 'org-mode-hook 'leo-space-lines)

  ;; Use UUIDs
  (require 'org-id))

;; ** by OS
;; *** CentOS git path

;; set magit executable for CentOS
(when (eq system-type 'gnu/linux)
  (when (file-exists-p "/opt/rh/rh-git29/root/usr/bin/git")
    (setq magit-git-executable "/opt/rh/rh-git29/root/usr/bin/git")))

;; ** gif-screencast

(with-eval-after-load 'gif-screencast
  (define-key gif-screencast-mode-map (kbd "<f8>") 'gif-screencast-toggle-pause)
  (define-key gif-screencast-mode-map (kbd "<f9>") 'gif-screencast-stop)

  (when (eq 'darwin system-type)
    (setq gif-screencast-args '("-x")) ;; To shut up the shutter sound of `screencapture' (see `gif-screencast-command').
    (setq gif-screencast-cropping-program "mogrify") ;; Optional: Used to crop the capture to the Emacs frame.
    (setq gif-screencast-capture-format "ppm") ;; Optional: Required to crop captured images.
    ))
