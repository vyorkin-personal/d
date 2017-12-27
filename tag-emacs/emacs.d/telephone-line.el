(use-package telephone-line
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
