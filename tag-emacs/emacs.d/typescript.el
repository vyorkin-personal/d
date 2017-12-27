(use-package typescript-mode
  :init
  (setq
   typescript-indent-level 2
   flycheck-check-syntax-automatically '(save mode-enabled)
   flycheck-tslint-args . ("--type-check"))
  (use-package tide
    :preface
    (defun rc/tide/setup ()
      (tide-setup)
      (flycheck-mode +1)
      (eldoc-mode +1)
      (tide-hl-identifier-mode +1)
      (add-to-list
       'compilation-error-regexp-alist
       '("ERROR in \\(.*\\)\n(\\([0-9]+\\),\\([0-9]+\\)):" 1 2 3))
      (company-mode +1))
    (defun rc/tide/setup-tsx ()
      (when (string-equal "tsx" (file-name-extension buffer-file-name))
        (rc/tide/setup)))
    :config
    (general-evil-define-key '(normal visual) tide-mode-map
      "M-j" 'tide-find-next-reference
      "M-k" 'tide-find-previous-reference
      "M-l" 'tide-jump-to-definition
      "M-h" 'tide-jump-back
      "M-i" 'tide-jump-to-implementation)
    (general-evil-define-key '(normal visual) tide-mode-map
      :prefix "SPC"
      "!" 'tide-restart-server
      "." 'tide-documentation-at-point
      "r" 'tide-references
      "e" 'tide-project-errors
      "n" 'tide-rename-symbol
      "t" 'tide-format
      "x" 'tide-fix
      "@" 'tide-refactor)
    (add-hook 'typescript-mode-hook 'rc/tide/setup)
    ;; enable tide for .tsx files
    (add-hook 'web-mode-hook 'rc/tide/setup-tsx))
  :delight " ts")
