(use-package anzu
  :disabled
  :config
  (global-anzu-mode +1)
  (set-face-attribute 'anzu-mode-line nil :foreground "yellow" :weight 'normal)
  (define-key isearch-mode-map [remap isearch-query-replace] 'anzu-isearch-query-replace)
  (define-key isearch-mode-map [remap isearch-query-replace-regexp] 'anzu-isearch-query-replace-regexp)
  :diminish anzu-mode)
