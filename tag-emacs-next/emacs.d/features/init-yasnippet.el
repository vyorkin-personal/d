(require 'init-general)
(require 'init-behavior)

(use-package yasnippet
  :defer 1.2
  :init
  (setq
   yas-wrap-around-region t
   yas-indent-line t
   yas-snippet-dirs '("~/.emacs.d/yasnippet-snippets"))
  :config
  (yas-global-mode 1)
  :diminish yas-minor-mode)

(provide 'init-yasnippet)
