(require 'init-general)

(use-package flycheck
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
   `(,(rx bos "*Flycheck errors*" eos)
     (display-buffer-reuse-window display-buffer-in-side-window)
     (side . bottom)
     (reusable-frames . visible)
     (window-height . 0.33)))
  (global-flycheck-mode 1)
  (nmap
    :prefix rc/leader
    "E" 'flycheck-list-errors)
  :diminish flycheck-mode)

(use-package flycheck-color-mode-line
  ;; seems to work only with powerline
  :disabled
  :config
  (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))

;; flycheck-error-list-goto-error

(setq flyspell-use-meta-tab nil
      flyspell-mode-line-string ""
      flyspell-auto-correct-binding (kbd ""))

;; for programming modes, enable flyspell-prog-mode for
;; spell checking in comments and strings.
;; (add-hook 'prog-mode-hook 'flyspell-prog-mode)

(use-package flyspell-correct-ivy
  :demand t
  :config
  (setq flyspell-correct-interface 'flyspell-correct-ivy)
  :bind
  (:map flyspell-mode-map
        ("C-;" . flyspell-correct-previous-word-generic)))

(provide 'init-flycheck)
