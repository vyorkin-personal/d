(require 'init-quelpa)
(require 'init-general)
(require 'init-flycheck)
(require 'init-haskell)

(use-package company-ghc
  :requires (init-general init-haskell)
  :after (general ghc haskell-mode)
  :init
  (setq company-ghc-show-info t)
  :config
  (add-to-list 'company-backends 'company-ghc)
  (nmap 'haskell-mode-map
    "C-c h" 'company-ghc-complete-by-hoogle
    "C-c m" 'company-ghc-complete-in-module))

(use-package ghci-completion
  ;; I don't now what it does
  ;; GHCI completion seem to work without it
  :disabled
  :config
  (add-hook 'inferior-haskell-mode-hook 'turn-on-ghci-completion))

(use-package hsearch-mode
  ;; haskell-mode already provides that
  :disabled
  :defer 2
  :quelpa (hsearch-mode :fetcher github :repo "jschaf/hsearch")
  :config
  (nmap 'haskell-mode-map
    :prefix rc/leader
    "i" 'hsearch))

(use-package hlint-refactor
  ;; doesn't work for me
  :disabled
  :requires init-general
  :after (general haskell-mode)
  :ensure-system-package
  ((hlint . "stack install hlint")
   (refactor . "stack install apply-refact"))
  :diminish hlint-refactor-mode
  :commands
  (hlint-refactor-refactor-buffer
   hlint-refactor-refactor-at-point)
  :init
  (add-hook 'haskell-mode-hook 'hlint-refactor-mode)
  :config
  (nmap 'haskell-mode-map
    :prefix rc/leader
    "h r " 'hlint-refactor-refactor-at-point
    "h b" 'hlint-refactor-refactor-buffer))

;; (use-package flycheck-stack
;;   :after (flycheck haskell-mode)
;;   :preface
;;   (defun rc/flycheck-stack/setup ()
;;     (flycheck-select-checker 'stack)
;;     (flycheck-mode))
;;   :config
;;   (add-hook 'haskell-mode-hook #'rc/flycheck-stack/setup))

(use-package flycheck-ghcmod
  :disabled
  :requires init-flycheck
  :after (haskell-mode flycheck))

(use-package intero
  :disabled
  :requires init-general
  :after (general haskell-mode)
  :if (executable-find "stack")
  :config
  (intero-global-mode 1)
  (nmap 'intero-mode-map
    "C-c r" 'intero-restart
    "M-l" 'intero-goto-definition)
  :delight "int")

(provide 'init-haskell-experimental)
