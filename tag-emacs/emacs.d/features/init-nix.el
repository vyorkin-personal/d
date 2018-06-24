(require 'init-company)

(use-package nix-mode)

(use-package nixos-options
  :after nix-mode)

(use-package nix-sandbox
  :after nix-mode)

(use-package company-nixos-options
  :requires init-company
  :after (nix-mode company)
  :config
  config
  (add-to-list 'company-backends 'company-nixos-options))

(provide 'init-nix)
