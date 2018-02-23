(require 'init-osx)
(require 'init-flycheck)

(use-package kotlin-mode
  :requires (init-osx)
  :after dash-at-point
  :config
  (add-to-list 'dash-at-point-mode-alist '(kotlin-mode . "kot")))

(use-package flycheck-kotlin
  :requires (init-flycheck)
  :after (kotlin-mode flycheck)
  :config
  (flycheck-kotlin-setup))

(provide 'init-kotlin)
