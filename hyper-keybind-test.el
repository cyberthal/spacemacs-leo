;; from http://ergoemacs.org/emacs/emacs_menu_app_keys.html

(define-key key-translation-map (kbd "<apps>") (kbd "<menu>"))

(progn
  (define-prefix-command 'xah-fly-leader-key-map))

  
(global-set-key (kbd "<menu>") 'xah-fly-leader-key-map)
