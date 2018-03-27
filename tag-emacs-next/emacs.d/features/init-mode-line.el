(use-package spaceline
  :init
  (setq
   spaceline-highlight-face-func 'spaceline-highlight-face-evil-state
   powerline-default-separator 'bar)
  :config
  (require 'spaceline-config)
  (spaceline-emacs-theme)
  ;; (spaceline-helm-mode)
  )

(use-package spaceline-all-the-icons
  :after spaceline
  :config
  ;; (spaceline-all-the-icons-theme)
  ;; (spaceline-all-the-icons--setup-package-updates)
  ;; (spaceline-all-the-icons--setup-git-ahead)
  ;; (spaceline-all-the-icons--setup-neotree)
  )

(provide 'init-mode-line)
