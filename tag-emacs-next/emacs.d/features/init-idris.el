(require 'init-osx)

(use-package idris-mode
  :requires init-osx
  :after dash-at-point
  :preface
  (defun rc/idris-mode/setup ()
    (setq
     idris-repl-banner-functions '(idris-repl-text-banner)
     idris-repl-prompt-style 'short)
    (enable-idris-pretty-symbols))
  :config
  (add-to-list 'dash-at-point-mode-alist '(idris-mode . "idris"))
  (add-hook 'idris-mode-hook #'rc/idris-mode/setup))

(provide 'init-idris)
