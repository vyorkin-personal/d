(require 'init-osx)
(require 'init-quelpa)
(require 'init-general)
(require 'init-eldoc)
(require 'init-projectile)
(require 'init-company)
(require 'init-lsp)
(require 'init-org)
(require 'init-flycheck)

(use-package ghc
  :if (executable-find "ghc"))

(use-package haskell-mode
  :requires
  (init-general
   init-osx
   init-eldoc
   init-company
   init-org)
  :after
  (general
   company
   eldoc
   ghc
   dash-at-point)
  :if
  (and
   (executable-find "ghc")
   (executable-find "stack"))
  :ensure-system-package
  ((hasktags . "stack install hasktags")
   (haskdogs . "stack install haskdogs")
   (hoogle . "stack install hoogle"))
  :quelpa
  (haskell-mode
   :repo "pvmart/haskell-mode"
   :branch "patch-haskell-process-extract-modules"
   :fetcher github
   :stable t)
  :mode
  (("\\.hs\\(c\\|-boot\\)?\\'" . haskell-mode)
   ("\\.lhs\\'" . literate-haskell-mode)
   ("\\.cabal\\'" . haskell-cabal-mode))
  :preface
  (defun rc/haskell-mode/setup ()
    (setq-local evil-auto-indent nil)
    (turn-on-haskell-indentation)
    (turn-on-haskell-unicode-input-method)
    (hindent-mode)
    ;; (subword-mode 1)
    ;; (eldoc-overlay-mode)
    (ghc-init)
    (ghc-toggle-check-command))
  :init
  (setq
   haskell-process-log t
   haskell-tags-on-save t
   haskell-process-suggest-remove-import-lines t
   haskell-process-auto-import-loaded-modules t
   haskell-process-type 'stack-ghci
   haskell-compile-cabal-build-command "stack build")
  :config
  (autoload 'ghc-init "ghc" nil t)
  (autoload 'ghc-debug "ghc" nil t)
  (add-hook 'haskell-mode-hook 'rc/haskell-mode/setup)
  ;; haskell
  (nmap 'haskell-mode-map
    "C-c C-o" 'haskell-process-load-file
    "C-c C-r" 'haskell-process-restart
    "C-c C-s" 'haskell-interactive-switch
    "C-t" 'haskell-process-do-type
    "C-i" 'haskell-process-do-info
    "C-c C-c" 'haskell-process-cabal-build
    "C-c c" 'haskell-process-cabal
    "C-c C-b" 'haskell-compile
    "C-c C-u" 'haskell-navigate-imports)
  ;; cabal
  (nmap 'haskell-cabal-mode-map
    "C-c C-s" 'haskell-interactive-switch
    "C-c C-r" 'haskell-process-restart
    "C-c C-l" 'haskell-interactive-mode-clear
    "C-c C-c" 'haskell-process-cabal-build
    "C-c c" 'haskell-process-cabal
    "C-c C-b" 'haskell-compile)
  ;; interactive haskell
  (require 'haskell-interactive-mode)
  (unbind-key "C-j" haskell-interactive-mode-map)
  (nmap 'haskell-interactive-mode-map
    "C-c C-s" 'haskell-interactive-switch-back
    "C-c C-r" 'haskell-process-restart)
  ;; ghc-mod
  (nmap 'haskell-mode-map
    "C-c U" 'ghc-toggle-check-command
    "C-c C-i" 'ghc-insert-module
    "C-c I" 'ghc-initial-code-from-signature
    "C-c O" 'ghc-insert-template-or-signature)
  ;; stylish
  (nmap 'haskell-mode-map
    "C-c f" 'haskell-mode-stylish-buffer)
  (add-to-list 'dash-at-point-mode-alist '(haskell-mode . "h"))
  (add-to-list 'org-babel-load-languages '(haskell . t))
  :delight "hs")

(use-package lsp-haskell
  ;; slow
  :disabled
  :requires (init-general init-lsp)
  :after (lsp-mode general haskell-mode)
  :config
  (add-hook 'haskell-mode-hook #'lsp-haskell-enable))

(use-package hindent
  :requires init-general
  :after (general haskell-mode)
  :ensure-system-package (hindent . "stack install hindent")
  :config
  (vmap 'haskell-mode-map "C-c C-f" 'hindent-reformat-region)
  (nmap 'haskell-mode-map "C-c C-f" 'hindent-reformat-buffer)
  :diminish hindent-mode)

(use-package hasky-stack
  :requires init-general
  :after (general haskell-mode)
  :config
  (nmap 'haskell-mode-map
    :prefix rc/leader
    "h s" 'hasky-stack-execute
    "h n" 'hasky-stack-new))

(use-package hasky-extensions
  :requires init-general
  :after (general haskell-mode)
  :config
  (nmap 'haskell-mode-map
    :prefix rc/leader
    "h e" 'hasky-extensions
    "h d" 'hasky-extensions-browse-docs))

(use-package flycheck-haskell
  :requires init-flycheck
  :after (haskell-mode flycheck)
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-haskell-setup))

(use-package hayoo
  :requires init-general
  :after general
  :defer 2
  :config
  (nmap 'haskell-mode-map
    :prefix rc/leader
    "H" 'hayoo-query))

(provide 'init-haskell)
