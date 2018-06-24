(use-package idris-mode
  :preface
  (defun rc/idris-mode/setup ()
    (setq
     idris-repl-banner-functions '(idris-repl-text-banner)
     idris-repl-prompt-style 'short)
    (enable-idris-pretty-symbols))
  :config
  (add-hook 'idris-mode-hook #'rc/idris-mode/setup))

(provide 'init-idris)
