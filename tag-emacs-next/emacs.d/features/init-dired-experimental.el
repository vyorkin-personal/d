(require 'init-quelpa)
(require 'init-general)
(require 'init-dired)

(use-package dired-collapse
  ;; it is too slow
  :disabled
  :after dired
  :config
  (add-hook 'dired-mode-hook 'dired-collapse-mode))

;; highlights dired buffer like k
(use-package dired-k
  ;; dired+ looks better
  :disabled
  :requires init-general
  :after (dired general)
  :defer 1
  :init
  (setq
   dired-k-padding 1
   dired-k-human-readable t)
  :config
  (nmap 'dired-mode-map
    "C-c C-k" 'dired-k))

(provide 'init-dired-experimental)
