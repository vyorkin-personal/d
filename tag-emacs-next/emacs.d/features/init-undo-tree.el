(require 'init-general)

(use-package undohist
  :config
  (undohist-initialize))

(use-package undo-tree
  :requires init-general
  :after general
  :defer 1
  :init
  (setq
   undo-tree-auto-save-history t
   undo-tree-history-directory-alist `((".*" . "~/.emacs.d/tmp")))
  ;; diff is slow as hell and it doesn't destroy the diff buffer automatically
  ;; (setq undo-tree-visualizer-diff t)
  ;; (setq undo-tree-visualizer-timestamps t)
  :config
  (undo-tree-mode)
  (nmap
    :prefix rc/leader
    "u" 'undo-tree-visualize)
  :diminish undo-tree-mode)

(provide 'init-undo-tree)
