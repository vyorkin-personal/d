(require 'init-general)
(require 'init-appearance)
(require 'init-company)

(use-package fill-column-indicator
  :requires (init-general init-appearance init-company)
  :after (general company)
  :preface
  ;; temporary disable fill column indicator
  ;; while showing company mode popup
  (defun on-off-fci-before-company (command)
    (when (string= "show" command)
      (turn-off-fci-mode))
    (when (string= "hide" command)
      (turn-on-fci-mode)))
  :init
  (setq
   fci-rule-color "#cd3278"
   fci-rule-use-dashes t)
  :config
  (advice-add 'company-call-frontends :before #'on-off-fci-before-company)
  (fci-mode))

(provide 'init-fill-column)
