(use-package rust-mode
  :config
  (use-package racer
    :demand t
    :commands racer-mode
    :config
    (add-hook 'racer-mode-hook 'eldoc-mode)
    (add-hook 'racer-mode-hook 'company-mode)
    (add-hook 'rust-mode-hook 'racer-mode))
  :commands rust-mode
  :config
  ;; enable rust-mode for .lalrpop files
  (add-to-list 'auto-mode-alist '("\\.lalrpop\\'" . rust-mode))
  :bind
  (:map rust-mode-map
        ([tab] . company-indent-or-complete-common)
        ("C-c C-b" . rust-compile)
        ("C-c <tab>" . rust-format-buffer)))
