(use-package undo-tree
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
  :diminish undo-tree-mode)

(provide 'init-undo-tree)
