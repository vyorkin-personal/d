(use-package yasnippet
  :defer t
  :init
  (setq yas-snippet-dirs
        '("~/.emacs.d/snippets"
          "~/.emacs.d/yasnippet-snippets"))
  :config
  (yas-global-mode 1)
  :diminish yas-minor-mode)
