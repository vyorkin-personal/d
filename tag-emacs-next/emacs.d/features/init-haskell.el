(require 'init-osx)
(require 'init-general)
(require 'init-company)

(use-package haskell-mode
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
  :config
  (nmap 'haskell-mode-map
    "C-c C-b" 'haskell-compile
    "C-c C-u" 'haskell-navigate-imports
    "C-c C-f" 'haskell-mode-format-imports)
  (add-to-list 'dash-at-point-mode-alist '(haskell-mode . "h"))
  (add-hook 'haskell-mode-hook 'rc/haskell-mode/setup)
  :delight "hs")

(use-package intero
  :after haskell-mode
  :config
  (intero-global-mode 1)
  (nmap 'intero-mode-map
    "C-c C-r" 'intero-restart
    "M-l" 'intero-goto-definition)
  :delight "int")

(provide 'init-haskell)
