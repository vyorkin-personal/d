(require 'init-general)

;; key bindings are provided by evil-collection
(use-package neotree
  :requires init-general
  :after general
  :config
  (nmap
    :prefix rc/leader
    "q" 'neotree-show
    "Q" 'neotree-hide
    "r" 'neotree-find))

(provide 'init-neotree)
