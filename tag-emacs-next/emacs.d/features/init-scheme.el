(require 'init-general)
(require 'init-geiser)

(use-package scheme
  :ensure nil
  :requires init-general
  :after geiser
  :preface
  (defun rc/scheme/setup ()
    (geiser-mode t))
  :defer 0.5
  :init
  (add-hook 'scheme-mode-hook #'rc/scheme/setup)
  :config)

(use-package quack
  :after scheme
  :defer 0.5
  :config
  (setq
   ;; use emacs-style fontification
   quack-fontify-style 'emacs))

(provide 'init-scheme)
