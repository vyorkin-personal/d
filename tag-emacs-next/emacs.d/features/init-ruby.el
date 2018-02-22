(require 'init-osx)
(require 'init-appearance)
(require 'init-company)

(use-package robe
  :after company
  :config
  (add-hook 'ruby-mode-hook 'robe-mode)
  (add-to-list 'company-backends 'company-robe)
  (add-to-list 'dash-at-point-mode-alist '(ruby-mode . "ruby")))

(use-package rubocop
  :after robe
  :config
  (add-hook 'ruby-mode-hook 'rubocop-mode)
  :delight "rcop")

(use-package bundler)

(provide 'init-ruby)
