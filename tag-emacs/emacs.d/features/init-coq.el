(use-package proof-site
  :load-path "lisp/PG/generic"
  :mode ("\\.v\\'" . coq-mode)
  :init
  (use-package coq-mode
    :ensure nil
    :commands coq-mode
    :init
    (setq
     company-coq-live-on-the-edge t
     company-coq-disabled-features '()
     company-coq-dynamic-autocompletion t)
    (use-package company-coq
      :commands company-coq-mode
      :preface
      (defun rc/company-coq/setup ()
        (interactive)
        (setq-local
         prettify-symbols-alist
         '((":=" . ?≜)
           ("Proof." . ?∵)
           ("Qed." . ?■)
           ("Defined." . ?□)))
        (sp-local-pair 'coq-mode "'" nil :actions nil)
        (company-coq-mode)
        (enable-coq-pretty-symbols)))
    (add-hook 'coq-mode-hook #'rc/company-coq/setup)))

(provide 'init-coq)
