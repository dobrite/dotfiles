;; Customizations relating to editing a buffer.

;; Key binding to use "hippie expand" for text autocompletion
;; http://www.emacswiki.org/emacs/HippieExpand
(global-set-key (kbd "M-/") 'hippie-expand)

;; Lisp-friendly hippie expand
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))

;; Highlights matching parenthesis
(show-paren-mode 1)

;; Highlight current line
(global-hl-line-mode 1)

;; Interactive search key bindings. By default, C-s runs
;; isearch-forward, so this swaps the bindings.
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;; Don't use hard tabs
(setq-default indent-tabs-mode nil)

(require 'saveplace)
; place backup and auto-save files in my ~/tmp directory
(defvar user-temporary-file-directory "~/tmp")
(setq backup-by-copying t
      backup-directory-alist
        '(("." . "~/tmp"))
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)
(setq auto-save-default nil)

; remember cursor position when re-opening a file
(setq save-place-file "~/tmp/emacs-saveplace")
(setq-default save-place t)

;; comments
(defun toggle-comment-on-line ()
  "comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))
(global-set-key (kbd "C-;") 'toggle-comment-on-line)

;; yay rainbows!
;; (global-rainbow-delimiters-mode t)

;; use 2 spaces for tabs
(defun die-tabs ()
  (interactive)
  (set-variable 'tab-width 2)
  (mark-whole-buffer)
  (untabify (region-beginning) (region-end))
  (keyboard-quit))

;; fix weird os x kill error
(defun ns-get-pasteboard ()
  "Returns the value of the pasteboard, or nil for unsupported formats."
  (condition-case nil
      (ns-get-selection-internal 'CLIPBOARD)
    (quit nil)))

(setq electric-indent-mode nil)

; return auto indents
(define-key global-map (kbd "RET") 'newline-and-indent)

;; disable return and indent when pasting
(defun enable-paste-mode ()
  "Disable auto indent"
  (interactive)
  (define-key global-map (kbd "RET") 'newline))
(defun disable-paste-mode ()
  "Reenable auto indent"
  (interactive)
  (define-key global-map (kbd "RET") 'newline-and-indent))
(disable-paste-mode)

; Undo/Redo
(require 'undo-tree)
(global-undo-tree-mode)
(setq undo-tree-auto-save-history t)
(setq undo-tree-history-directory-alist '((".*" . "~/tmp/emacs-undo")))

(defun new-empty-buffer ()
  "Open a new empty buffer."
  (interactive)
  (let ((buf (generate-new-buffer "untitled")))
    (switch-to-buffer buf)
    (funcall (and initial-major-mode))
    (setq buffer-offer-save t)))

(evil-leader/set-key
  "u" 'undo-tree-visualize)
(global-set-key (kbd "C-r") 'undo-tree-redo)

;; default keybindings for evil-nerd-commenter
;; ,ci comment or uncomment lines
;; ,cl comment or uncomment to the line
(evilnc-default-hotkeys)
