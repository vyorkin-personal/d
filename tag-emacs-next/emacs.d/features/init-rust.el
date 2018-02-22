(require 'init-osx)
(require 'init-general)
(require 'init-company)
(require 'init-flycheck)

(use-package rust-mode
  :after (:both company general)
  :commands rust-mode
  :config
  ;; enable rust-mode for .lalrpop files
  (add-to-list 'auto-mode-alist '("\\.lalrpop\\'" . rust-mode))
  (add-to-list 'dash-at-point-mode-alist '(rust-mode . "rust"))
  (general-define-key
    :keymaps 'rust-mode-map
    "TAB" 'company-indent-or-complete-common
    "C-c C-b" 'rust-compile
    "C-c <tab>" 'rust-format-buffer))

;; some of key bindings
;; are provided by evil-collection
(use-package racer
  :after rust-mode
  :demand t
  :commands racer-mode
  :config
  (add-hook 'racer-mode-hook 'eldoc-mode)
  (add-hook 'racer-mode-hook 'company-mode)
  (add-hook 'rust-mode-hook 'racer-mode))

(use-package flycheck-rust
  :after flycheck)

(provide 'init-rust)
