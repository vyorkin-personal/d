;; I use my forked version https://github.com/vyorkin-forks/purescript-mode/tree/bugfix/conflicting-quail-rules
;; with some conflicting quail rules disabled from the local path
;; (and I have no idea how to use "use-package" to use package from a local path lol)

(add-to-list 'load-path "~/projects/github/purescript-mode/")
(require 'purescript-mode-autoloads)
(add-to-list 'Info-default-directory-list "~/projects/github/purescript-mode/")

(defun rc/purescript-emmet ()
  (interactive)
  (let ((start (point))
        (end (save-excursion (beginning-of-line-text) (point))))
    (call-process-region start end "purescript-emmet" t t)))

(general-evil-define-key 'insert 'purescript-mode-map
    "C-c C-e" 'rc/purescript-emmet)

(use-package psc-ide
  :preface
  (defun rc/psc-ide/setup ()
    (setq-local evil-auto-indent nil)
    (psc-ide-mode)
    (turn-on-purescript-unicode-input-method)
    (turn-on-purescript-indentation))
  :after purescript-mode
  :init
  (setq psc-ide-use-npm-bin t)
  :config
  (general-evil-define-key 'normal 'psc-ide-mode-map
    "M-l" 'psc-ide-goto-definition)
  (add-hook 'purescript-mode-hook 'rc/psc-ide/setup)
  :delight "[psc-ide]")

(use-package psci
  :after purescript-mode
  :config
  (add-hook 'purescript-mode-hook 'inferior-psci-mode)
  :delight "[psci]")
