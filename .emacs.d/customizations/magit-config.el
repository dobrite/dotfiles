(require 'magit)

; some git keybindings
(evil-leader/set-key
  "gs" 'magit-status
  "gb" 'vc-annotate)
