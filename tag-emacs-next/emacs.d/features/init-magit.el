(require 'init-general)
(require 'init-evil)

(use-package evil-magit
  :requires (init-general init-evil)
  :config
  (setq evil-magit-state 'normal))

(provide 'init-magit)
