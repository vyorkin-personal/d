(require 'init-company)

(use-package go-mode
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
  :config
  (add-hook 'go-mode-hook 'company-mode)
  (add-to-list 'company-backends 'company-go))

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
