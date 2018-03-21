(require 'init-osx)
(require 'init-quelpa)
(require 'init-general)
(require 'init-company)
(require 'init-org)
(require 'init-flycheck)

(use-package hindent
  :ensure-system-package (hindent . "stack install hindent")
  :delight "hi")

(use-package ghc
  :if (executable-find "ghc"))

(use-package company-ghc
  :after ghc
  :init
  (setq company-ghc-show-info t)
  :config
  (add-to-list 'company-backends 'company-ghc))

(use-package haskell-mode
  :requires
  (init-general
   init-osx
   init-company
   init-org)
  :after
  (general
   company
   ghc
   company-ghc
   hindent
   dash-at-point)
  :if
  (and
   (executable-find "ghc")
   (executable-find "stack"))
  :ensure-system-package
  ((hasktags . "stack install hasktags")
   (haskdogs . "stack install haskdogs")
   (hoogle . "stack install hoogle"))
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
    (autoload 'ghc-init "ghc" nil t)
    (autoload 'ghc-debug "ghc" nil t)
    (ghc-init))
  :init
  (setq
   haskell-process-log t
   haskell-process-suggest-remove-import-lines t
   haskell-process-auto-import-loaded-modules t
   haskell-process-type 'stack-ghci
   haskell-compile-cabal-build-command "stack build"
   haskell-tags-on-save t)
  :config
  (add-hook 'haskell-mode-hook 'rc/haskell-mode/setup)
  ;; haskell
  (nmap 'haskell-mode-map
    "C-c C-o" 'haskell-process-load-or-reload
    "C-c C-s" 'haskell-interactive-switch
    "C-t" 'haskell-process-do-type
    "C-i" 'haskell-process-do-info
    "C-c C-n C-c" 'haskell-process-cabal-build
    "C-c C-n c" 'haskell-process-cabal
    "C-c C-b" 'haskell-compile
    "C-c C-u" 'haskell-navigate-imports)
  ;; cabal
  (nmap 'haskell-cabal-mode-map
    "C-c C-s" 'haskell-interactive-switch
    "C-c C-l" 'haskell-interactive-mode-clear
    "C-c C-c" 'haskell-process-cabal-build
    "C-c c" 'haskell-process-cabal
    "C-c C-b" 'haskell-compile)
  ;; stylish
  (nmap 'haskell-mode-map
    "C-c f" 'haskell-mode-stylish-buffer)
  ;; hindent
  (vmap 'haskell-mode-map
    "C-c C-f" 'hindent-reformat-region)
  (nmap 'haskell-mode-map
    "C-c C-f" 'hindent-reformat-buffer)
  ;; ghc-mod
  (nmap 'haskell-mode-map
    "C-c C-i" 'ghc-insert-module
    "C-c I" 'ghc-initial-code-from-signature)
  ;; company-ghc
  (nmap 'haskell-mode-map
    "C-c h" 'company-ghc-complete-by-hoogle
    "C-c m" 'company-ghc-complete-in-module)
  (add-to-list 'dash-at-point-mode-alist '(haskell-mode . "h"))
  (add-to-list 'org-babel-load-languages '(haskell . t))
  :delight "hs")

(use-package ghci-completion
  :config
  (add-hook 'inferior-haskell-mode-hook 'turn-on-ghci-completion))

(use-package hayoo
  :defer 2
  :config
  (nmap 'haskell-mode-map
    :prefix rc/leader
    "r" 'hayoo-query))

(use-package hsearch-mode
  ;; haskell-mode already provides that
  :disabled
  :defer 2
  :quelpa (hsearch-mode :fetcher github :repo "jschaf/hsearch")
  :config
  (nmap 'haskell-mode-map
    :prefix rc/leader
    "i" 'hsearch))

(use-package flycheck-stack
  ;; TODO: try
  :disabled
  :after (flycheck haskell-mode)
  :preface
  (defun rc/flycheck-stack/setup ()
    (flycheck-select-checker 'stack)
    (flycheck-mode))
  :config
  (add-hook 'haskell-mode-hook #'rc/flycheck-stack/setup))

(use-package flycheck-haskell
  :disabled
  :require init-flycheck
  :after (haskell-mode flycheck)
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-haskell-setup))

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

(provide 'init-haskell)
