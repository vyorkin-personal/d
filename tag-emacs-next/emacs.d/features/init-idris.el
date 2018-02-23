(require 'init-osx)

(use-package idris-mode
  :requires init-osx
  :after dash-at-point
  :config
  (add-to-list 'dash-at-point-mode-alist '(idris-mode . "idris")))

(provide 'init-idris)
