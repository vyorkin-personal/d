;; modernizing Emacs' Package Menu
;; with package ratings, usage statistics, customizability, and more
(use-package paradox
  :init
  (setq
   paradox-execute-asynchronously t
   paradox-automatically-star t)
  :config
  ;; replace the default interface with paradox
  (paradox-enable))

(use-package exec-path-from-shell
  :init
  (setq exec-path-from-shell-check-startup-files nil)
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

(use-package use-package-ensure-system-package)

(provide 'init-system)
