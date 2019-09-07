;; * config.el of private/personal layer
;; * offset
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


;; **** golden ratio mode on

(with-eval-after-load 'org
  (spacemacs/toggle-golden-ratio-on)
  )
;; *** dired
;; **** misc

(require 'dired-x) ; Enable dired-x
(add-hook 'dired-mode-hook (lambda () (dired-omit-mode)))

;; dired-quick-sort activate
;; (require 'dired-quick-sort)
;; (dired-quick-sort-setup)

;; **** dired sorting by directories first

;; Mac
(when (string-equal system-type "darwin")
  (setq dired-listing-switches "-ADhl --group-directories-first")
  )

;; Linux
(when (string-equal system-type "gnu/linux")
  (setq dired-listing-switches "-alGh --group-directories-first")
  )

;; remote?
(add-hook
 'dired-before-readin-hook
 (lambda ()
   (when (file-remote-p default-directory)
     (setq dired-actual-switches "-al"))))

;; *** outshine

(add-hook 'ahk-mode-hook 'outline-minor-mode)

;; ** org-mode & bbcodeize
(with-eval-after-load 'org
;; *** text scale

(defgroup leo nil "Leo's personal Spacemacs layer."
  :group 'convenience)

(defcustom leo-supersize-text t
  "Non-nil if text should be supersized."
  :type 'boolean
  :group 'leo)

(defun leo-darwin-supersize ()
  (if (eq system-type 'darwin) ;; OSX
      (text-scale-set 2)))

(when leo-supersize-text
  (add-hook 'org-mode-hook
            'leo-darwin-supersize)
  (add-hook 'dired-mode-hook
            'leo-darwin-supersize))


;; *** make org start with wrapped lines.  works.
  (setq org-startup-truncated nil)
  (setq line-move-visual nil)

;; *** word wrap for org only.  works.
(add-hook 'org-mode-hook #'toggle-word-wrap)


;; *** line spacing

;; add line spacing to org-mode
(defun leo-space-lines ()
  (setq line-spacing 5)
  )
(add-hook 'org-mode-hook 'leo-space-lines)
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

;; *** load bbcodeize

(push "~/.emacs.d/private/personal/bbcode/" load-path)
(require 'bbcodeize)

;; *** MobileOrg

;; Set to the location of your Org files on your local system
(setq org-directory "~/1-Mansort/1-Textmind")
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/1-Mansort/1-Textmind/2-Linked/flagged.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")

;; Enable encryption
(setq org-mobile-use-encryption t)
;; Set a password
(setq org-mobile-encryption-password
      (condition-case nil
          (with-temp-buffer
            (insert-file-contents "~/1-Mansort/1-Textmind/3-Non/9-Code/Static-path/Mobileorg/Password.txt")
            (goto-char (point-max))
            (delete-char -1)
            (buffer-string))
        (user-error "%s" "MobileOrg password file not found")
        )
      )
;; *** end org-mode block

) 

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

;; *** Mac path

;; fixes dired display failure
;; by switching from default mac ls to brew coreutils
(when (eq system-type 'darwin)
  (require 'ls-lisp)
  (setq insert-directory-program "gls"))

;; *** CentOS git path

;; set magit executable for CentOS
(when (eq system-type 'gnu/linux)
  (when (file-exists-p "/opt/rh/rh-git29/root/usr/bin/git")
    (setq magit-git-executable "/opt/rh/rh-git29/root/usr/bin/git")
    )
)

;; ** Textmind

;; add Textmind to org-agenda scope
(push "~/.emacs.d/private/personal/" load-path)
(require 'maintext-toggle)

;; ** gif-screencast

(with-eval-after-load 'gif-screencast
  (define-key gif-screencast-mode-map (kbd "<f8>") 'gif-screencast-toggle-pause)
  (define-key gif-screencast-mode-map (kbd "<f9>") 'gif-screencast-stop)

  (when (eq 'darwin system-type)
    (setq gif-screencast-args '("-x")) ;; To shut up the shutter sound of `screencapture' (see `gif-screencast-command').
    (setq gif-screencast-cropping-program "mogrify") ;; Optional: Used to crop the capture to the Emacs frame.
    (setq gif-screencast-capture-format "ppm") ;; Optional: Required to crop captured images.
    ))
