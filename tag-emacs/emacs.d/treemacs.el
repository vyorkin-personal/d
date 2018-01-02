(use-package treemacs
  :disabled
  :init
  (setq
   treemacs-follow-after-init t
   treemacs-width 20
   treemacs-indentation 2
   treemacs-git-integration t
   treemacs-change-root-without-asking nil
   treemacs-sorting 'alphabetic-desc
   treemacs-show-hidden-files t
   treemacs-never-persist nil
   treemacs-goto-tag-strategy 'refetch-index)
  :config
  (setq treemacs-header-function 'treemacs--create-header-projectile)
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  (general-evil-define-key 'normal 'treemacs-mode-map
    "c" 'treemacs-create-file
    "C" 'treemacs-create-dir
    "d" 'treemacs-delete
    "i" 'treemacs-visit-node-vertical-split
    "s" 'treemacs-visit-node-horizontal-split
    "M-j" 'treemacs-next-neighbour
    "M-k" 'treemacs-previous-neighbour
    "u" 'treemacs-uproot
    "h" 'treemacs-toggle-show-dotfiles
    "M-f" 'treemacs-follow-mode
    "M-W" 'treemacs-toggle-fixed-width
    "M-w" 'treemacs-reset-width
    "M-r" 'treemacs-change-root))
