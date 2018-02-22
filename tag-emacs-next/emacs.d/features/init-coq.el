(use-package company-coq
  :disabled
  :init
  (load "~/.emacs.d/lisp/PG/generic/proof-site.el")
  :config
  (add-hook 'coq-mode-hook company-coq-mode))

(provide 'init-coq)
