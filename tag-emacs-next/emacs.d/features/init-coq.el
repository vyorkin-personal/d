(require 'init-utils)
(require 'init-general)

(use-package company-coq
  :requires (init-utils init-general)
  :after general
  :mode ("\\.v\\'" . coq-mode)
  :preface
  (defun rc/company-coq/setup ()
    (company-coq-mode)
    (enable-coq-pretty-symbols)
    (sp-local-pair 'coq-mode "'" nil :actions nil))
  :init
  (load (expand-lisp "PG/generic/proof-site"))
  :config
  (add-hook 'coq-mode-hook #'rc/company-coq/setup))

(provide 'init-coq)
