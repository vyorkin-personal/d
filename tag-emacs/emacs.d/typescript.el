(use-package typescript-mode
  :init
  (setq
   typescript-indent-level 2
   flycheck-check-syntax-automatically '(save mode-enabled)
   flycheck-tslint-args . ("--type-check"))
  :delight "[ts]")
