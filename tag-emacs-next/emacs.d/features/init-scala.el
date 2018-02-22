(require 'init-osx)

(use-package ensime)

(use-package scala-mode
  :config
  (add-to-list 'dash-at-point-mode-alist '(scala-mode . "scala")))

(provide 'init-scala)
