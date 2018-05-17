(require 'init-company)

(use-package nix-mode
  :config
  (add-to-list 'company-backends 'company-nixos-options))

(provide 'init-nix)
