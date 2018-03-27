(require 'init-general)
(require 'init-company)
(require 'init-flycheck)
(require 'init-projectile)

(use-package lsp-mode
  :requires init-projectile
  :after projectile
  ;; :ensure nil
  ;; :load-path "~/projects/github/lsp-mode/"
  :preface
  (defun rc/lsp-mode/set-projectile-root ()
    (when lsp--cur-workspace
      (setq
       projectile-project-root
       (lsp--workspace-root lsp--cur-workspace))))
  :config
  (add-hook 'lsp-before-open-hook #'rc/lsp-mode/set-projectile-root)
  ;; This function will turn lsp-mode on and call the command given to
  ;; start the LSP server.
  (add-hook 'prog-major-mode #'lsp-prog-major-mode-enable)
  :delight "lsp")

(use-package lsp-ui
  :requires init-general
  :after (lsp-mode general)
  :preface
  (defun rc/lsp-ui/setup ()
    (lsp-ui-mode)
    (lsp-ui-sideline-mode))
  :init
  (setq
   lsp-ui-flycheck-enable t
   lsp-ui-peek-enable t
   lsp-ui-doc-enable nil
   lsp-ui-sideline-show-hover t
   lsp-ui-sideline-show-symbol t
   lsp-ui-sideline-enable t)
  :config
  (add-hook 'lsp-mode-hook #'rc/lsp-ui/setup)
  (add-hook 'lsp-after-open-hook #'lsp-enable-imenu)
  (nmap
    :prefix rc/leader
    "t l" 'lsp-mode
    "i" 'lsp-ui-imenu
    "1" 'lsp-ui-peek-find-definitions
    "2" 'lsp-ui-peek-find-references)
  (general-def 'lsp-ui-peek-mode-map
    "h" 'lsp-ui-peek--select-next-file
    "l" 'lsp-ui-peek--select-prev-file
    "j" 'lsp-ui-peek--select-next
    "k" 'lsp-ui-peek--select-prev))

(use-package company-lsp
  ;; slow
  :disabled
  :requires init-company
  :after (lsp-mode company)
  :init
  (setq
   ;; don't filter results on the client side
   company-transformers nil
   company-lsp-cache-candidates t
   company-lsp-async t
   company-lsp-enable-snippet t)
  :config
  (add-to-list 'company-backends 'company-lsp))

(provide 'init-lsp)
