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

;; ** org-mode & bbcodeize
(with-eval-after-load 'org

  ;; variable pitch for prose
  (add-hook 'org-mode-hook 'variable-pitch-mode)
  ;; fixed pitch for code
  (dolist (face '(org-block-begin-line
                  org-block-end-line
                  org-verbatim
                  ;;                org-block-background
                  org-table))
    (set-face-attribute face nil :inherit 'fixed-pitch))

  ;; prose with markup needs more line spacing
  (defun leo-space-lines ()
    (setq line-spacing 0.175))
  (add-hook 'org-mode-hook 'leo-space-lines)

  ;; Use UUIDs
  (require 'org-id))

;; ** by OS
;; *** Windows path & exec-path

;; adapted from Xah's code here:
;; http://ergoemacs.org/emacs/emacs_env_var_paths.html

(when (string-equal system-type "windows-nt")
  (let (
        (leo-NT-extra-paths
          '(
            "C:/cygwin/usr/local/bin"
            "C:/cygwin/usr/bin"
            "C:/cygwin/bin"

            ;;"C:/Program Files (x86)/ErgoEmacs/msys/bin"
            )
         )
        )

    (setenv "PATH"
            (concat
             (getenv "PATH")
             ";"
             (mapconcat 'identity leo-NT-extra-paths ";")
             )
            )
    (setq exec-path
          (append exec-path leo-NT-extra-paths)
          )
        )
  (setq magit-git-executable "c:/Program Files (x86)/Git/bin/git.exe")
  )

;; snippets handy for testing purposes
;; (setenv "PATH" "C:\\msys32\\mingw32\\bin;C:\\msys32\\usr\\local\\bin;C:\\msys32\\usr\\bin;C:\\msys32\\usr\\bin;C:\\Windows\\System32;C:\\Windows;C:\\Windows\\System32\\Wbem;C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\;C:\\msys32\\usr\\bin\\site_perl;C:\\msys32\\usr\\bin\\vendor_perl;C:\\msys32\\usr\\bin\\core_perl")
;; (setq exec-path '("c:/msys32/mingw32/bin" "C:/msys32/usr/local/bin" "C:/msys32/usr/bin" "C:/msys32/usr/bin" "C:/Windows/System32" "C:/Windows" "C:/Windows/System32/Wbem" "C:/Windows/System32/WindowsPowerShell/v1.0/" "C:/msys32/usr/bin/site_perl" "C:/msys32/usr/bin/vendor_perl" "C:/msys32/usr/bin/core_perl" "c:/msys32/mingw32/libexec/emacs/25.1/i686-w64-mingw32"))
;; (getenv "PATH")
;; (insert exec-path)

;; *** CentOS git path

;; set magit executable for CentOS
(when (eq system-type 'gnu/linux)
  (when (file-exists-p "/opt/rh/rh-git29/root/usr/bin/git")
    (setq magit-git-executable "/opt/rh/rh-git29/root/usr/bin/git")
    )
)

;; ** gif-screencast

(with-eval-after-load 'gif-screencast
  (define-key gif-screencast-mode-map (kbd "<f8>") 'gif-screencast-toggle-pause)
  (define-key gif-screencast-mode-map (kbd "<f9>") 'gif-screencast-stop)

  (when (eq 'darwin system-type)
    (setq gif-screencast-args '("-x")) ;; To shut up the shutter sound of `screencapture' (see `gif-screencast-command').
    (setq gif-screencast-cropping-program "mogrify") ;; Optional: Used to crop the capture to the Emacs frame.
    (setq gif-screencast-capture-format "ppm") ;; Optional: Required to crop captured images.
    ))
