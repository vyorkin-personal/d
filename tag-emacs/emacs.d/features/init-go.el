(require 'init-company)
(require 'init-flycheck)
(require 'init-lsp)

(use-package go-mode
  :requires (init-company init-flycheck)
  :after (company flycheck)
  :preface
  (defun rc/go-mode/setup ()
    (add-hook 'before-save-hook 'gofmt-before-save)
    (add-hook 'go-mode-hook 'flycheck-mode)
    (setq-default)
    (setq standard-indent 8)
    (setq tab-width 8)
    (setq indent-tabs-mode 1))
  :config
  (add-hook 'go-mode-hook #'rc/go-mode/setup))

(use-package company-go
  :requires init-company
  :after (company go-mode)
  :config
  (add-hook 'go-mode-hook 'company-mode)
  (add-to-list 'company-backends 'company-go))

(use-package lsp-go)

(use-package go-stacktracer)

(use-package go-add-tags)

(use-package go-eldoc
  :config
  (add-hook 'go-mode-hook 'go-eldoc-setup))

(use-package go-gopath)

(use-package go-direx)

(use-package gotest)

(use-package go-playground)

(provide 'init-go)
