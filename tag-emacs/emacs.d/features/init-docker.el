(require 'init-evil)

(use-package docker
  :requires init-evil
  :diminish docker-mode
  :defer
  :config
  (docker-global-mode 1))

(use-package docker-compose-mode)

(provide 'init-docker)
