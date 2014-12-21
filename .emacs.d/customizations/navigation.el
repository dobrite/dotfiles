;; These customizations make it easier for you to navigate files,
;; switch buffers, and choose options from the minibuffer.

;; "When several buffers visit identically-named files,
;; Emacs must give the buffers distinct names. The usual method
;; for making buffer names unique adds ‘<2>’, ‘<3>’, etc. to the end
;; of the buffer names (all but one of them).
;; The forward naming method includes part of the file's directory
;; name at the beginning of the buffer name
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Uniquify.html
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; Turn on recent file mode so that you can more easily switch to
;; recently edited files when you first start emacs
(setq recentf-save-file (concat user-emacs-directory ".recentf"))
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 40)


;; ido-mode allows you to more easily navigate choices. For example,
;; when you want to switch buffers, ido presents you with a list
;; of buffers in the the mini-buffer. As you start to type a buffer's
;; name, ido will narrow down the list of buffers to match the text
;; you've typed in
;; http://www.emacswiki.org/emacs/InteractivelyDoThings
(ido-mode t)

;; This allows partial matches, e.g. "tl" will match "Tyrion Lannister"
(setq ido-enable-flex-matching t)

;; Turn this behavior off because it's annoying
(setq ido-use-filename-at-point nil)

;; Don't try to match file across all "work" directories; only match files
;; in the current directory displayed in the minibuffer
(setq ido-auto-merge-work-directories-length -1)

;; Includes buffer names of recently open files, even if they're not
;; open now
(setq ido-use-virtual-buffers t)

;; This enables ido in all contexts where it could be useful, not just
;; for selecting buffer and file names
(ido-ubiquitous-mode 1)

;; Shows a list of buffers
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Enhances M-x to allow easier execution of commands. Provides
;; a filterable list of possible commands in the minibuffer
;; http://www.emacswiki.org/emacs/Smex
(setq smex-save-file (concat user-emacs-directory ".smex-items"))
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)

;; projectile everywhere!
(projectile-global-mode)

;; horiz split cursor goes right
;; veritcal split cursor goes down
(defadvice split-window (after move-point-to-new-window activate)
  "Moves the point to the newly created window after splitting."
  (other-window 1))

(require 'helm-projectile)
(defun helm-projectile-recentf (&optional arg)
  "Use projectile with Helm instead of ido.
   With a prefix ARG invalidates the cache first.
   If invoked outside of a project, displays a list of known projects to jump."
  (interactive "P")
  (if (projectile-project-p)
      (projectile-maybe-invalidate-cache arg))
  (let ((helm-ff-transformer-show-only-basename nil)
        (src (if (projectile-project-p)
                 '(helm-source-projectile-recentf-list)
               helm-source-projectile-projects)))
    (helm :sources src
          :buffer "*helm projectile*"
          :prompt (projectile-prepend-project-name (if (projectile-project-p)
                                                       "pattern: "
                                                       "Switch to project: ")))))

(require 'layout-restore)
(global-set-key [?\C-c ?l] 'layout-save-current)
(global-set-key [?\C-c ?\C-l ?\C-l] 'layout-restore)

(defun zoom-win ()
  "Show only the current window, or restore previous window layout."
  (interactive)
  (if layout-configuration-alist
      (progn
        (layout-restore)
        (layout-delete-current))
    (progn
      (layout-save-current)
      (delete-other-windows))))

; buffer navigation keys
(evil-leader/set-key
   "f" 'helm-recentf
   "r" 'helm-projectile-recentf
   "b" 'projectile-switch-to-buffer
   "p" 'helm-projectile
   "w" 'kill-this-buffer)

(evil-leader/set-key
  ";" 'helm-show-kill-ring)

; window navigation keys
(evil-leader/set-key
  "v" 'evil-window-vsplit
  "s" 'evil-window-split
  "q" 'delete-window
  "o" 'zoom-win
  "h" 'evil-window-left
  "j" 'evil-window-down
  "k" 'evil-window-up
  "l" 'evil-window-right
  "H" 'evil-window-move-far-left
  "J" 'evil-window-move-very-bottom
  "K" 'evil-window-move-very-top
  "L" 'evil-window-move-far-right)
(global-set-key (kbd "C-^") 'iflipb-next-buffer)

; directory tree view
(evil-leader/set-key
  "p" 'projectile-dired
  "P" 'dired-jump)
