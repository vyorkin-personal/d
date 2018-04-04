(require 'init-appearance)
(require 'init-general)
(require 'init-company)
(require 'init-hydra)
(require 'init-flycheck)
(require 'init-flyspell)

(use-package flx)

(use-package company-flx
  :requires init-company
  :after (company flx)
  :demand t
  :config
  ;; use C-o to switch backend and
  ;; enable company mode fuzzyness
  (company-flx-mode +1))

(use-package ivy
  :requires init-general
  :after (general flx)
  :preface
  (defun rc/ivy/switch-buffer-occur ()
    "Occur function for `ivy-switch-buffer' using `ibuffer'."
    (ibuffer nil (buffer-name) (list (cons 'name ivy--old-re))))
  :custom
  (ivy-count-format "%d/%d " "Show anzu-like counter")
  ;; :custom-face
  ;; (ivy-current-match ((t (:background "gray1"))))
  :init
  (setq
   ;; add 'recentf-mode' and bookmarks to 'ivy-switch-buffer'
   ivy-use-virtual-buffers t
   ;; number of result lines to display
   ivy-height 12
   ;; current input becomes selectable as a candidate
   ;; solves the issue of creating a file or
   ;; a directory `foo` when a file `foobar` already exists
   ;; another way is to use C-M-j
   ivy-use-selectable-prompt t
   ;; wrap around ivy results
   ivy-wrap t
   ;; omit ^ at the beginning of regexp
   ivy-initial-inputs-alist nil)
  :config
  (ivy-mode 1)
  ;; enable fuzzy matching
  ;; see: https://oremacs.com/2016/01/06/ivy-flx/
  (setq ivy-re-builders-alist
        '((ivy-switch-buffer . ivy--regex-plus)
          (t . ivy--regex-fuzzy)))
  (ivy-set-occur 'ivy-switch-buffer #'rc/ivy/switch-buffer-occur)
  (nmap
    :prefix rc/leader
    "a" 'ivy-switch-buffer)
  (general-define-key
   :keymaps 'ivy-minibuffer-map
   "C-j" 'ivy-next-line
   "C-k" 'ivy-previous-line
   "C-n" 'ivy-next-history-element
   "C-p" 'ivy-previous-history-element
   "<C-return>" 'ivy-immediate-done
   "C-l" 'ivy-immediate-done
   "C-w" 'ivy-backward-kill-word)
  :diminish ivy-mode)

(use-package ivy-xref
  :custom
  (xref-show-xrefs-function #'ivy-xref-show-xrefs "Use Ivy to show xrefs"))

(use-package ivy-rich
  :after ivy
  :custom
  (ivy-rich-switch-buffer-name-max-length 60 "Increase max length of buffer name.")
  :init
  (setq
   ivy-virtual-abbreviate 'full
   ivy-rich-path-style 'abbrev
   ivy-rich-switch-buffer-align-virtual-buffer t)
  :config
  (dolist
      (cmd
       '(ivy-switch-buffer
         ivy-switch-buffer-other-window
         counsel-projectile-switch-to-buffer))
    (ivy-set-display-transformer cmd #'ivy-rich-switch-buffer-transformer)))

(use-package ibuffer-vc
  :custom
  (ibuffer-formats
   '((mark modified read-only vc-status-mini " "
           (name 18 18 :left :elide)
           " "
           (size 9 -1 :right)
           " "
           (mode 16 16 :left :elide)
           " "
           filename-and-process)) "include vc status info")
  :hook
  (ibuffer . (lambda ()
               (ibuffer-vc-set-filter-groups-by-vc-root)
               (unless (eq ibuffer-sorting-mode 'alphabetic)
                 (ibuffer-do-sort-by-alphabetic)))))

(use-package flyspell-correct-ivy
  :requires (init-general init-flyspell)
  :after (general flyspell ivy)
  :demand t
  :init
  (setq flyspell-correct-interface 'flyspell-correct-ivy)
  :config
  (nmap 'flyspell-mode-map
    "C-;" 'flyspell-correct-previous-word-generic))

(use-package fzf)

(use-package counsel
  :requires init-general
  :after general
  :init
  ;; much faster than grep
  (setq
   counsel-git-cmd "rg --files"
   counsel-grep-base-command
   "rg -i -M 120 --no-heading --line-number --color never %s .")
  :config
  (nmap
    "C-f" 'counsel-imenu)
  (nmap
    :prefix rc/leader
    "f" 'counsel-rg
    "F" 'counsel-fzf
    "h v" 'counsel-describe-variable
    "h f" 'counsel-describe-function)
  (nmap "M-x" 'counsel-M-x)
  (nmap
    :prefix "C-x"
    "C-r" 'find-file
    "C-f" 'counsel-find-file
    "C-g" 'counsel-git-grep
    "p" 'counsel-package)
  (nmap
    :prefix rc/leader
    rc/leader 'counsel-M-x
    "T" 'counsel-load-theme
    "J" 'counsel-bookmark))

;; projectile replacements
(use-package counsel-projectile
  :requires init-general
  :after (counsel general)
  :config
  (nmap
    "C-q" 'counsel-projectile-find-file
    "C-a" 'counsel-projectile-switch-to-buffer))

(use-package counsel-etags
  :requires init-general
  :after (general counsel))

(use-package swiper
  :requires init-general
  :after general
  :init
  ;; recenter after swiper is finished
  (setq swiper-action-recenter t)
  :config
  (general-define-key
   :keymaps 'swiper-map
   "C-r" 'swiper-query-replace)
  (nmap
    "C-s" 'swiper))

(use-package ivy-hydra
  :requires init-hydra
  :after hydra
  :config
  (general-define-key
   :keymaps 'ivy-minibuffer-map
   "M-i" 'hydra-ivy/body))

;; (use-package ranger)

(use-package ag
  :ensure-system-package (ag . silversearcher-ag)
  :custom
  (ag-highlight-search t "Highlight the current search term."))

(use-package dumb-jump
  :custom
  (dumb-jump-selector 'ivy)
  (dumb-jump-prefer-searcher 'ag)
  (nmap
    "C-c C-j" 'dumb-jump-go))

(use-package avy
  :requires init-general
  :demand t
  :config
  (mmap
    :prefix "C-c j"
    "c" 'avy-goto-char
    "w" 'avy-goto-word-1
    "l" 'avy-goto-line))

(use-package avy-zap
  :bind
  ([remap zap-to-char] . avy-zap-to-char))

(use-package avy-flycheck
  :requires (init-general init-flycheck)
  :after (general avy flycheck)
  :init
  (setq avy-flycheck-style 'pre)
  :config
  (avy-flycheck-setup)
  (nmap
    :prefix rc/leader
    "n e" #'avy-flycheck-goto-error))

(provide 'init-navigation)
