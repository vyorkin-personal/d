(require 'init-utils)

(defvar rc/leader "SPC")

(use-package general
  :config
  (general-define-key
    :keymaps 'normal
    "C-h" 'windmove-left
    "C-l" 'windmove-right
    "C-k" 'windmove-up
    "C-j" 'windmove-down
    "M-q" 'rc/server-shutdown
    ;; swap : and ; to make colon commands easier to type in Emacs
    ";" 'evil-ex
    ":" 'evil-repeat-find-char)
  (general-define-key
    :prefix rc/leader
    :keymaps 'normal
    "f" 'toggle-frame-fullscreen
    "v" 'split-window-horizontally
    "s" 'split-window-vertically
    "p" 'list-processes
    "U" 'winner-undo
    "R" 'winner-redo
    "d" 'delete-window
    "o" 'other-window))

(provide 'init-general)
