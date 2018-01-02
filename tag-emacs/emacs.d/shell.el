(use-package virtualenvwrapper
  :config
  (venv-initialize-interactive-shells)
  (venv-initialize-eshell))

(use-package shell-switcher
  ;; :init
  ;; (add-hook 'eshell-mode-hook 'shell-switcher-manually-register-shell)
  :config
  (setq shell-switcher-mode t)
  :bind
  ("C-'" . shell-switcher-switch-buffer))

(use-package better-shell
  :disabled
  :bind
  (("C-'" . better-shell-shell)
   ("C-;" . better-shell-remote-open)))
