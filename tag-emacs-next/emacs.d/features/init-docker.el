(require 'init-evil)

(use-package docker
  :diminish docker-mode
  :defer
  :config
  (docker-global-mode 1))

(use-package docker-compose-mode)

(provide 'init-docker)
