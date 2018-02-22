(require 'init-osx)
(require 'init-general)
(require 'init-flycheck)

;; I use my forked version:
;; https://github.com/vyorkin-forks/purescript-mode/tree/bugfix/conflicting-quail-rules
;; with some conflicting quail rules disabled from the local path
;; (and I have no idea how to "use-package" from a local path lol)

(add-to-list 'load-path "~/projects/github/purescript-mode/")
(require 'purescript-mode-autoloads)
(add-to-list 'Info-default-directory-list "~/projects/github/purescript-mode/")

(defun rc/purescript-emmet ()
  (interactive)
  (let ((start (point))
        (end (save-excursion (beginning-of-line-text) (point))))
    (call-process-region start end "purescript-emmet" t t)))

(eval-after-load 'purescript-mode
  '((imap 'purescript-mode-map
      "C-c C-e" #'rc/purescript-emmet)
    (add-to-list 'dash-at-point-mode-alist '(purescript-mode . "purs"))))

(use-package psc-ide
  :after purescript-mode
  :preface
  (defun rc/psc-ide/setup ()
    (setq-local evil-auto-indent nil)
    (psc-ide-mode)
    (turn-on-purescript-unicode-input-method)
    (turn-on-purescript-indentation))
  :init
  (setq psc-ide-use-npm-bin t)
  :config
  (general-define-key
    :states 'normal
    :keymaps 'psc-ide-mode-map
    "C-t" 'psc-ide-goto-definition)
  (add-hook 'purescript-mode-hook 'rc/psc-ide/setup)
  :delight "psc-ide")

(use-package psci
  :after purescript-mode
  :config
  (add-hook 'purescript-mode-hook 'inferior-psci-mode)
  :delight "psci")

;; should be superseeded by psc-ide-mode's flycheck integration
;; https://github.com/dysinger/purescript-mode/pull/8
(use-package flycheck-purescript
  :disabled
  :preface
  (defun rc/flycheck-purescript/setup ()
    (setq default-directory (locate-dominating-file default-directory "node_modules")))
  :after purescript-mode
  :init
  (eval-after-load 'flycheck
    '(add-hook 'flycheck-mode-hook 'flycheck-purescript-setup))
  :config
  (add-hook 'purescript-mode-hook 'rc/flycheck-purescript/setup))

(provide 'init-purescript)
