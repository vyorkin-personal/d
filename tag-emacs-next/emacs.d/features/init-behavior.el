(require 'init-general)

;; key bindings are provided by evil-collection
(use-package which-key
  :demand t
  :diminish which-key-mode
  :init
  (setq
    which-key-idle-delay 0.5
    which-key-sort-order 'which-key-prefix-then-key-order-reverse
    ;; hack to make this work with Evil
    which-key-show-operator-state-maps t
    which-key-prefix-prefix ""
    which-key-side-window-max-width 0.5
    which-key-popup-type 'side-window
    which-key-side-window-location 'bottom)
  :config
  (which-key-mode)
  (with-eval-after-load 'evil-collection
    (add-to-list 'evil-collection-mode-list 'while-key)))

(use-package try
  :defer t)

(use-package restart-emacs
  :demand t
  :commands (restart-emacs)
  :config
  (nmap
    :prefix rc/leader
    "z" 'restart-emacs))

(provide 'init-behavior)
