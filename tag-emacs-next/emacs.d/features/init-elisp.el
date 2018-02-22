(require 'init-general)
(require 'init-company)
(require 'init-smartparens)

(use-package elisp-mode
  :ensure nil
  :after (:both general company smartparens)
  :config
  (nmap
   "M-." 'find-function-at-point
   "M-," 'find-variable-at-point
   "C-c e r" 'eval-region)

  (general-define-key
   :keymaps 'emacs-lisp-mode-map
   "e"  '(:ignore t :which-key "Emacs")
   "ev" '(:ignore t :which-key "Describe Variable")
   "ed" '(:ignore t :which-key "Docs & Help"))

  (add-to-list 'company-backends 'company-elisp)

  (with-eval-after-load 'smartparens
    (sp-with-modes 'emacs-lisp-mode
                   (sp-local-pair "'" nil :actions nil))))

(use-package elisp-refs
  :after elisp-mode)

(use-package macrostep
  :after elisp-mode
  :commands macrostep-expand
  :mode ("\\*.el\\'" . emacs-lisp-mode)
  :config
  ;; support Macrostep in Evil mode
  (general-define-key
   :keymaps 'macrostep-keymap
   "q" #'macrostep-collapse-all
   "e" #'macrostep-expand)
  (general-define-key
   :keymaps 'emacs-lisp-mode-map
   "em" #'macrostep-expand))

(provide 'init-elisp)
