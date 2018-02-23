(require 'init-osx)
(require 'init-general)
(require 'init-appearance)
(require 'init-company)
(require 'init-projectile)

(use-package robe
  :requires (init-osx init-company)
  :after (company dash-at-point)
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

(use-package rbenv
  :preface
  (defun rc/rbenv/modeline (current-ruby)
    (append
     '("ruby [")
     (list (propertize current-ruby 'face 'rbenv-active-ruby-face))
     '("]")))
  :init
  (setq rbenv-modeline-function #'rc/rbenv/modeline)
  :config
  (global-rbenv-mode))

(use-package rake
  :requires (init-general init-projectile)
  :after (general projectile)
  :init
  (setq rake-completion-system projectile-completion-system)
  :config
  (nmap 'ruby-mode-map
    :prefix rc/leader
    "r" 'rake))

(use-package rspec-mode)

(use-package projectile-rails
  :requires init-projectile
  :after projectile
  :config
  (projectile-rails-global-mode))

(provide 'init-ruby)
