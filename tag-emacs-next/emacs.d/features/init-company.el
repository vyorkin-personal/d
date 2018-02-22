(require 'init-general)

(use-package company
  :preface
  :init
  ;; adjust this setting according to your typing speed
  (setq
   company-dabbrev-ignore-case nil
   company-dabbrev-code-ignore-case nil
   company-dabbrev-downcase nil
   company-idle-delay 0
   company-minimum-prefix-length 1
   ;; company-show-numbers t
   ;; aligns annotation to the right hand side
   company-tooltip-align-annotations t
   ;; company-tern-meta-as-single-line t
   company-transformers '(company-sort-by-occurrence))
  :config
  ;; use company-mode in all buffers
  (add-hook 'after-init-hook 'global-company-mode)

  ;; some of the key bindings are
  ;; provide by the evil-collection
  (general-define-key
   :keymaps 'company-active-map
   "C-j" 'company-select-next-or-abort
   "C-k" 'company-select-previous-or-abort
   "C-o" 'company-other-backend
   "C-d" 'company-show-doc-buffer)
  :diminish company-mode)

(use-package company-quickhelp
  :after company
  :demand t
  :config
  (general-define-key
    :keymaps 'company-active-map
    "C-c h" 'company-quickhelp-manual-begin))

(provide 'init-company)
