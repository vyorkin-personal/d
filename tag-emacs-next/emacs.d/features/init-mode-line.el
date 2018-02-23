(use-package spaceline
  :init
  (setq
    spaceline-highlight-face-func 'spaceline-highlight-face-evil-state
    powerline-default-separator 'bar)
  :config
  (require 'spaceline-config)
  (spaceline-spacemacs-theme)
  (spaceline-helm-mode))

(use-package smart-mode-line
  :disabled
  :config
  (setq
    rm-blacklist
    '(" WK" " SP" " =>"
      " Undo-Tree" " ivy" " company"
      " Fly" " FlyC" " FlyC-" " FlyC:0/4"
      " FlyC:1/4" " FlyC:0/8" " es"
      " PgLn" " LR" " jk" " ARev"))
  (setq sml/theme 'respectful)
  (setq sml/no-confirm-load-theme t)
  (sml/setup))

(use-package telephone-line
  :disabled
  :config
  (setq
   telephone-line-primary-left-separator 'telephone-line-flat
   telephone-line-secondary-left-separator 'telephone-line-flat
   telephone-line-primary-right-separator 'telephone-line-flat
   telephone-line-secondary-right-separator 'telephone-line-flat
   telephone-line-height 20
   telephone-line-evil-use-short-tag t)
  (require 'telephone-line-config)
  (telephone-line-evil-config))

(use-package powerline
  :disabled
  :init
  (setq
   powerline-height (truncate (* 1.0 (frame-char-height)))
   powerline-default-separator 'utf-8)
  :config
  ;; see: https://www.emacswiki.org/emacs/DelightedPowerLine
  (defadvice powerline-major-mode (around delight-powerline-major-mode activate)
    "Ensure that powerline's major mode names are delighted. See `delight-major-mode'."
    (let ((inhibit-mode-name-delight nil)) ad-do-it))
  (powerline-default-theme))

(provide 'init-mode-line)