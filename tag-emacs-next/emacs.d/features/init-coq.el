(require 'init-general)

(use-package company-coq
  :requires init-general
  :disabled
  :init
  (load "~/.emacs.d/lisp/PG/generic/proof-site.el")
  :config
  (add-hook 'coq-mode-hook company-coq-mode))

(provide 'init-coq)
