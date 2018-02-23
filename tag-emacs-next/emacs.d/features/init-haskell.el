(require 'init-osx)
(require 'init-general)
(require 'init-company)
(require 'init-org)
(require 'init-flycheck)

(use-package haskell-mode
  :requires
  (init-general
   init-osx
   init-company
   init-org)
  :after
  (general
   company
   org
   dash-at-point)
  :if (executable-find "gch")
  :mode
  (("\\.hs\\(c\\|-boot\\)?\\'" . haskell-mode)
   ("\\.lhs\\'" . literate-haskell-mode)
   ("\\.cabal\\'" . haskell-cabal-mode))
  :preface
  (defun rc/haskell-mode/setup ()
    (custom-set-variables '(haskell-process-type 'ghci))
    (setq-local evil-auto-indent nil)
    (setq haskell-compile-cabal-build-command "stack build")
    (set (make-local-variable 'company-backends)
         (append '((company-capf company-dabbrev-code))
                 company-backends))
    (turn-on-haskell-indentation)
    ;; (interactive-haskell-mode)
    (turn-on-haskell-unicode-input-method))
  :init
  (setq
   haskell-process-log t
   haskell-process-type 'stack-ghci)
  :config
  (add-to-list 'org-babel-load-languages '(haskell . t))
  (nmap 'haskell-mode-map
    "C-c C-b" 'haskell-compile
    "C-c C-u" 'haskell-navigate-imports
    "C-c C-f" 'haskell-mode-format-imports)
  (add-to-list 'dash-at-point-mode-alist '(haskell-mode . "h"))
  (add-hook 'haskell-mode-hook 'rc/haskell-mode/setup)
  :delight "hs")

(use-package intero
  :requires init-general
  :after (general haskell-mode)
  :if (executable-find "stack")
  :config
  (intero-global-mode 1)
  (nmap 'intero-mode-map
    "C-c C-r" 'intero-restart
    "M-l" 'intero-goto-definition)
  :delight "int")

(use-package ghci-completion
  :config
  (add-hook 'inferior-haskell-mode-hook 'turn-on-ghci-completion))

(use-package hayoo)

(use-package hindent
  ;; TODO: try
  :disabled
  :after hackell-mode)

(use-package flycheck-stack
  ;; TODO: try
  :disabled
  :after (flycheck haskell-mode)
  :preface
  (defun rc/flycheck-stack/setup ()
    (flycheck-select-checker 'stack)
    (flycheck-mode))
  :config
  (add-hook 'haskell-mode-hook #'rc/flycheck-stack/setup))

(use-package flycheck-haskell
  ;; I use intero, but could change
  ;; my mind in the future
  :disabled
  :require init-flycheck
  :after (haskell-mode flycheck)
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-haskell-setup))

(provide 'init-haskell)