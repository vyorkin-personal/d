(require 'init-general)

(use-package company
  :requires init-general
  :preface
  :init
  ;; adjust this setting according to your typing speed
  (setq
   company-dabbrev-ignore-case nil
   company-dabbrev-code-ignore-case nil
   company-dabbrev-downcase nil
   company-idle-delay 0.4
   company-minimum-prefix-length 1
   ;; company-show-numbers t
   ;; aligns annotation to the right hand side
   company-tooltip-align-annotations t
   ;; company-tern-meta-as-single-line t
   company-transformers '(company-sort-by-occurrence))
  :config
  ;; use company-mode in all buffers
  (add-hook 'after-init-hook 'global-company-mode)
  (imap
    "C-SPC" 'company-complete)
  ;; some of the key bindings are
  ;; provided by the evil-collection
  (general-define-key
   :keymaps 'company-active-map
   "C-j" 'company-select-next-or-abort
   "C-k" 'company-select-previous-or-abort
   "C-o" 'company-other-backend
   "C-f" 'company-abort
   "C-d" 'company-show-doc-buffer
   "C-w" 'backward-kill-word)
  :diminish company-mode)

;; (use-package company-box
;;   :quelpa (company-box :fetcher github :repo "sebastiencs/company-box")
;;   :hook (company-mode . company-box-mode))

(use-package company-quickhelp
  :requires init-general
  :after company
  :demand t
  :config
  (general-define-key
   :keymaps 'company-active-map
   "C-c h" 'company-quickhelp-manual-begin))

(provide 'init-company)
