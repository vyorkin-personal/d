(use-package ssh-config-mode
  :config
  (add-to-list 'auto-mode-alist '("~/.ssh/config\\'" . ssh-config-mode)))

(provide 'init-ssh)
