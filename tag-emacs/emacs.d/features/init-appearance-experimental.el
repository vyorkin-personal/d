(require 'init-quelpa)
(require 'init-general)

(use-package dimmer
  ;; doesn't always work reliably
  :disabled
  :init
  (setq-default dimmer-fraction 0.4)
  :config
  (dimmer-activate))

;; visualizes cursor position
(use-package beacon
  ;; maybe slow (or not so)
  ;; it works good without evil mode
  :disabled
  :requires init-general
  :after general
  :demand t
  :custom
  (beacon-color "#ff00ee")
  (beacon-blink-when-window-scrolls nil)
  (beacon-dont-blink-commands nil)
  :config
  (beacon-mode 1)
  (nmap
    :prefix rc/leader
    "t b" 'beacon-mode)
  :diminish beacon-mode)


;; basically its the same as highlight-thing
;; but seems to be smarter and less distracting
(use-package idle-highlight-mode
  :disabled
  :config
  (add-hook 'prog-mode-hook 'idle-highlight-mode)
  (nmap
    :prefix rc/leader
    "t H" 'idle-highlight-mode))

(use-package highlight-blocks
  ;; cool, but useless for me
  :disabled
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

(use-package indent-guide
  ;; I don't use it
  :disabled
  :requires init-general
  :after general
  :config
  ;; (indent-guide-global-mode)
  (nmap
    :prefix rc/leader
    "t i" 'indent-guide-mode))

(use-package color-identifiers-mode
  ;; I don't need it
  :disabled
  :demand t
  :config
  (add-hook 'after-init-hook 'global-color-identifiers-mode)
  :diminish color-identifiers-mode)

;; it doesn't work with git-gutter
;; (but there is git-gutter-fringe which I don't use eihter)
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

(use-package focus
  ;; I don't use it
  :disabled
  :config
  (nmap
    :prefix rc/leader
    "t f" 'focus-mode))

(use-package disable-mouse
  ;; ok, sometimes mouse can be helpful
  :disabled
  :diminish disable-mouse-global-mode
  :config
  (global-disable-mouse-mode))

(use-package rainbow-blocks
  ;; I don't like how it looks
  :disabled
  :config)

(use-package highlight-thing
  ;; distracting
  :disabled
  :defer 0.2
  :init
  (setq
   highlight-thing-case-sensitive-p t
   ;; don't highlight the thing at point itself
   highlight-thing-exclude-thing-under-point t
   highlight-thing-prefer-active-region t
   highlight-thing-ignore-list
   '("False" "True"
     "--" "|"
     "+" "-" "*" "/" "=" ">" "<"
     "&&" "||" "%" "$" "#"))
  :config
  ;; (global-highlight-thing-mode)
  (nmap
    :prefix rc/leader
    "t H" 'global-highlight-thing-mode)
  :diminish highlight-thing-mode)

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
  :disabled
  :config
  (global-vi-tilde-fringe-mode)
  :diminish vi-tilde-fringe-mode)

(use-package hl-todo
  ;; I don't use TODO that much lol
  :disabled
  :config
  (global-hl-todo-mode))

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

(provide 'init-appearance-experimental)
