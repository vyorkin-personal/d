(require 'init-utils)

(defvar rc/leader "SPC")

(use-package general
  :config
  (general-define-key
    "C-h" 'windmove-left
    "C-l" 'windmove-right
    "C-k" 'windmove-up
    "C-j" 'windmove-down
    "M-q" 'rc/server-shutdown)
  (general-evil-setup t)
  (nmap
    ;; swap : and ; to make colon commands
    ;; easier to type in Emacs
    ";" 'evil-ex
    ":" 'evil-repeat-find-char)
  (nmap
    :prefix rc/leader
    "F" 'toggle-frame-fullscreen
    "v" 'split-window-horizontally
    "s" 'split-window-vertically
    "p" 'list-processes))

(provide 'init-general)
