(require 'init-osx)

(use-package idris-mode
  :config
  (add-to-list 'dash-at-point-mode-alist '(idris-mode . "idris")))

(provide 'init-idris)
