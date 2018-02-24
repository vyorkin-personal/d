(require 'init-quelpa)
(require 'init-general)

(defvar after-load-theme-hook nil
  "Hook run after a color theme is loaded using `load-theme'.")
(defadvice load-theme (after run-after-load-theme-hook activate)
  "Run `after-load-theme-hook'."
  (run-hooks 'after-load-theme-hook))

(defun rc/customize-appearance ()
  (interactive)
  ;; set the background or vertical border to the main area background color
  (set-face-background 'vertical-border (face-background 'default))
  ;; set the foreground and background of the vertical-border face to
  ;; the same value so there is no line up the middle
  (set-face-foreground 'vertical-border (face-background 'vertical-border))
  ;; set the fringe colors to whatever is the background color
  (set-face-attribute
   'fringe nil
   :foreground (face-foreground 'default)
   :background (face-background 'default)))

(add-hook 'after-load-theme-hook 'rc/customize-appearance)

(nmap
  :prefix rc/leader
  "`" 'rc/customize-appearance)

(use-package delight
  :config
  (delight '((emacs-lisp-mode "elisp" :major)
             (elixir-mode "ex" elixir)
             (alchemist-mode "al" alchemist)
             (alchemist-hex-mode "alhex" alchemist)
             (alchemist-test-mode "altest" alchemist)
             (rust-mode "rs" rust)
             (purescript-mode "purs" purescript)
             (javascript-mode "js" js)
             (eldoc-mode "eldoc" eldoc)
             ;; (hi-lock-mode "hi" hi-lock)
             (auto-revert-mode "ar" autorevert))))

(use-package diminish
  :config
  (eval-after-load "purescript-indentation" '(diminish 'purescript-indentation-mode))
  (eval-after-load "simple" '(diminish 'overwrite-mode))
  (eval-after-load "dired" '(diminish 'dired-omit-mode))
  (eval-after-load "hideshow" '(diminish 'hs-minor-mode))
  (eval-after-load "autorevert" '(diminish 'auto-revert-mode))
  (eval-after-load "eldoc" '(diminish 'eldoc-mode))
  (eval-after-load "hi-lock" '(diminish 'hi-lock-mode)))

(use-package dimmer
  :init
  (setq-default dimmer-fraction 0.3)
  :config
  (dimmer-activate))

(use-package disable-mouse
  ;; ok, sometimes mouse can be helpful
  :disabled
  :diminish disable-mouse-global-mode
  :config
  (global-disable-mouse-mode))

;; visualizes cursor position
(use-package beacon
  :demand t
  :config
  (setq
   beacon-color "#deff00"
   beacon-dont-blink-commands nil)
  (beacon-mode 1)
  :diminish beacon-mode)

(use-package focus
  :config
  (nmap
    :prefix rc/leader
    "t f" 'focus-mode))

(use-package rainbow-delimiters
  :demand t
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
  :diminish rainbow-delimiters-mode)

(use-package color-identifiers-mode
  :demand t
  :config
  (add-hook 'after-init-hook 'global-color-identifiers-mode)
  :diminish color-identifiers-mode)

;; it doesn't work with git-gutter
;; (but there is git-gutter-fringe)
(use-package linum-relative
  :disabled
  :defer 0.6
  :init
  (setq
   linum-relative-current-symbol "")
  :config
  ;; (add-hook 'text-mode-hook 'linum-relative-mode)
  ;; (add-hook 'prog-mode-hook 'linum-relative-mode)
  (nmap
    :prefix rc/leader
    "t n" 'linum-relative-toggle))

(use-package highlight-chars
  :preface
  (defun rc/highlight-chars/setup ()
    (hc-highlight-tabs)
    (hc-highlight-trailing-whitespace))
  :defer 0.5
  :quelpa (highlight-chars :fetcher github :repo "emacsmirror/highlight-chars")
  :config
  (add-hook 'lisp-mode-hook #'rc/highlight-chars/setup)
  (add-hook 'prog-mode-hook #'rc/highlight-chars/setup))

(use-package rainbow-blocks
  :config
  (add-hook 'clojure-mode-hook 'rainbow-blocks-mode))

(use-package highlight-blocks
  :defer 0.2
  :init
  (setq highlight-blocks-delay 0.05)
  :config
  ;; (add-hook 'prog-mode-hook 'highlight-blocks-mode)
  ;; (add-hook 'emacs-lisp-mode-hook 'highlight-blocks-mode)
  (nmap
    :prefix rc/leader
    "t h" 'highlight-blocks-mode
    "H" 'highlight-blocks-now)
  :diminish highlight-blocks-mode)

(use-package highlight-thing
  :defer 0.2
  :init
  (setq
   highlight-thing-case-sensitive-p t
   ;; don't highlight the thing at point itself
   highlight-thing-exclude-thing-under-point t
   highlight-thing-prefer-active-region t
   highlight-thing-ignore-list '("False" "True" "--"))
  :config
  (global-highlight-thing-mode)
  :diminish)

;; basically its the same as highlight-thing
(use-package idle-highlight-mode
  :disabled
  :config
  (add-hook 'prog-mode-hook 'idle-highlight-mode))

(use-package highlight-leading-spaces
  :defer 0.8
  :config
  (nmap
    :prefix rc/leader
    "t s" 'highlight-leading-spaces-mode))

(use-package golden-ratio
  ;; distracting
  :disabled
  :requires init-general
  :after general
  :init
  (setq golden-ratio-auto-scale t)
  ;; (setq
  ;;  golden-ratio-adjust-factor .8
  ;;  golden-ratio-wide-adjust-factor .8)
  :config
  (golden-ratio-mode 1)
  (nmap
    :prefix rc/leader
    "t G" 'golden-ratio-mode)
  :diminish golden-ratio-mode)

(use-package vi-tilde-fringe
  :config
  (global-vi-tilde-fringe-mode)
  :diminish vi-tilde-fringe-mode)

(use-package hl-todo
  :config
  (global-hl-todo-mode))

(use-package indent-guide
  :requires init-general
  :after general
  :config
  ;; (indent-guide-global-mode)
  (nmap
    :prefix rc/leader
    "t i" 'indent-guide-mode))

(use-package highlight-indent-guides
  ;; slow
  :disabled
  :requires init-general
  :after general
  :defer 0.2
  :init
  (setq highlight-indent-guides-method 'character)
  :config
  ;; (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
  (nmap
    :prefix rc/leader
    "t i" 'highlight-indent-guides-mode))

(use-package smeargle
  ;; slow
  :disabled
  :requires init-general
  :after general
  :config
  (custom-set-variables
   '(smeargle-age-colors
     '((0 . nil)
       (1 . "grey8")
       (2 . "grey7")
       (3 . "grey6")
       (4 . "grey5")
       (5 . "grey4")
       (6 . "grey3")
       (7 . "grey2")
       (8 . "grey1"))))
  (nmap
    :prefix rc/leader
    "t S t" 'smeargle
    "t S c" 'smeargle-commits
    "t S C" 'smeargle-clear))

(use-package smooth-scrolling
  :config
  (smooth-scrolling-mode 1))

(provide 'init-appearance)
