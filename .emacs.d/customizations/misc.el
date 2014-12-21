;; Changes all yes/no questions to y/n type
(fset 'yes-or-no-p 'y-or-n-p)

;; shell scripts
(setq-default sh-basic-offset 2)
(setq-default sh-indentation 2)

;; No need for ~ files when editing
(setq create-lockfiles nil)

;; Go straight to scratch buffer on startup
(setq inhibit-startup-message t)

;; :set nowrap
(set-default 'truncate-lines t)

;; wrap to next line when at end of previous
(setq-default evil-cross-lines t) 

;; show trailing whitespace
(setq-default show-trailing-whitespace t)
