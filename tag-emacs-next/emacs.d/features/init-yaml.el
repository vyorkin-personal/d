(require 'init-osx)
(require 'init-flycheck)

(use-package yaml-mode
  :requires (init-osx)
  :after dash-at-point
  :config
  (add-to-list 'dash-at-point-mode-alist '(yaml-mode . "yaml"))
  :delight "yafml")

(use-package flycheck-yamllint
  :requires (init-flycheck)
  :after (flycheck yaml-mode)
  :if (executable-find "yamllint")
  :config
  (flycheck-yamllint-setup))

(provide 'init-yaml)
