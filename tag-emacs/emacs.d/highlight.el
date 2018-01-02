(use-package highlight-chars
  :config
  (add-hook 'font-lock-mode-hook 'hc-highlight-tabs)
  (add-hook 'font-lock-mode-hook 'hc-highlight-trailing-whitespace))

(use-package highlight-indentation
  :disabled
  :preface
  (defvar rc/highlight-indentation/modes
    '(reason-mode-hook
      idris-mode-hook
      haskell-mode-hook))
  :commands highlight-indentation-mode
  :config
  (dolist (mode rc/highlight-indentation/modes)
    (add-hook mode 'highlight-indentation-mode))
  :diminish highlight-indentation-mode)
