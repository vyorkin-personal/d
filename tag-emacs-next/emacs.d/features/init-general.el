(use-package general
  :after evil
  :preface
  (defun rc/text-scale-reset ()
    "Reset the text scale to 0."
    (interactive)
    (text-scale-set 0))
  :init
  ;; bind a key globally in normal state; keymaps must be quoted
  (setq general-default-keymaps 'evil-normal-state-map)
  :config
  (general-evil-setup)
  (general-define-key
   "<f11>" 'toggle-frame-fullscreen
   "C-M-=" 'text-scale-increase
   "C-M--" 'text-scale-decrease
   "C-M-0" 'rc/text-scale-reset
   "C-h" 'windmove-left
   "C-l" 'windmove-right
   "C-k" 'windmove-up
   "C-j" 'windmove-down
   "M-q" 'rc/server-shutdown
   "M-l" (kbd "\\ M-.")
   "M-h" 'xref-pop-marker-stack)
  (general-define-key
   :prefix "SPC"
   "f" 'toggle-frame-fullscreen
   "v" 'split-window-horizontally
   "s" 'split-window-vertically
   "p" 'list-processes
   "U" 'winner-undo
   "R" 'winner-redo
   "d" 'delete-window
   "o" 'other-window
   "w" 'ace-window
   "H" 'highlight-indentation-mode
   "G" 'global-git-gutter+-mode
   "T" 'counsel-load-theme
   "j" 'counsel-bookmark
   "q" 'treemacs-toggle
   "SPC" 'counsel-M-x
   "`" 'rc/customize-appearance
   "RET" 'sublimity-mode
   "a" 'counsel-projectile-switch-project
   "c" 'projectile-invalidate-cache
   "gs" 'magit-status
   "gd" 'magit-diff
   "gf" 'magit-file-popup
   "gc" 'magit-commit
   "gl" 'magit-log
   "gp" 'magit-push
   "gw" 'magit-stage-file   ; "write"
   "gr" 'magit-unstage-file ; "remove"
   "gg" 'vc-git-grep)
  (general-evil-define-key 'normal 'help-mode-map
    "q" 'quit-window
    "<" 'help-go-back
    ">" 'help-go-forward)
  (general-define-key
   :keymaps 'process-menu-mode-map
   "M-d" 'process-menu-delete-process))

(provide 'init-general)
