(require 'init-utils)

(defvar rc/leader "SPC")

(use-package general
  :config
  (general-define-key
   "C-h" 'windmove-left
   "C-l" 'windmove-right
   "C-k" 'windmove-up
   "C-j" 'windmove-down
   "M-q" 'rc/server-shutdown
   "C-w" 'backward-kill-word
   "C-x C-k" 'kill-region
   "C-c C-k" 'kill-region)
  (general-evil-setup t)
  (nmap
    ;; swap : and ; to make colon commands
    ;; easier to type in Emacs
    ";" 'evil-ex
    ":" 'evil-repeat-find-char)
  (nmap
    :prefix rc/leader
    "RET" 'toggle-frame-fullscreen
    "v" 'split-window-horizontally
    "s" 'split-window-vertically
    "p" 'list-processes
    "h k" 'describe-key-briefly
    "h K" 'describe-key
    "h M" 'describe-mode))

(provide 'init-general)
