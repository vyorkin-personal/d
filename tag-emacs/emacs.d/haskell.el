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
  :init
  (use-package intero
    :config
    (intero-global-mode 1)
    (general-evil-define-key 'normal 'intero-mode-map
      "M-l" 'intero-goto-definition)
    :delight "[int]")
  :config
  (general-evil-define-key 'normal 'haskell-mode-map
    "C-c C-b" 'haskell-compile
    "C-c C-u" 'haskell-navigate-imports
    "C-c C-f" 'haskell-mode-format-imports)
  (add-hook 'haskell-mode-hook 'rc/haskell-mode/setup)
  :delight "[hs]")
