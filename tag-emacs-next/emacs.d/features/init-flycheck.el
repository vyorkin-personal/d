(require 'init-general)

(use-package flycheck
  :requires init-general
  :after general
  :defer 1.8
  :init
  (setq-default
   flycheck-disabled-checkers
   '(emacs-lisp-checkdoc javascript-jshint))
  (setq
   flycheck-mode-line-prefix "fly"
   flycheck-javascript-eslint-executable "eslint_d")
  :config
  ;; make the error list display like similar lists in contemporary IDEs
  ;; like VisualStudio, Eclipse, etc.
  (add-to-list
   'display-buffer-alist
   `(,(rx bos "*fucking errors*" eos)
     (display-buffer-reuse-window display-buffer-in-side-window)
     (side . bottom)
     (reusable-frames . visible)
     (window-height . 0.33)))
  (global-flycheck-mode 1)
  (nmap
    :prefix rc/leader
    "e e" 'flycheck-list-errors
    "e c" 'flycheck-clear
    "e i" 'flycheck-manual
    "e C" 'flycheck-compile
    "e n" 'flycheck-next-error
    "e p" 'flycheck-previous-error
    "e b" 'flycheck-buffer
    "e v" 'flycheck-verify-setup
    "e V" 'flycheck-verify-checker)
  :diminish flycheck-mode)

(use-package flycheck-inline
  :after flycheck
  :demand t
  :config
  (add-hook 'flycheck-mode-hook 'flycheck-inline-enable))

(provide 'init-flycheck)
