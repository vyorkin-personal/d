(require 'init-general)
(require 'init-company)
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
   ;; don't count candidates
   ivy-count-format ""
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

(use-package flyspell-correct-ivy
  :requires (init-general init-flyspell)
  :after (general flyspell ivy)
  :demand t
  :init
  (setq flyspell-correct-interface 'flyspell-correct-ivy)
  :config
  (nmap 'flyspell-mode-map
    "C-;" 'flyspell-correct-previous-word-generic))

(use-package counsel
  :requires init-general
  :after general
  :init
  ;; much faster than grep
  (setq
   counsel-grep-base-command
   "rg -i -M 120 --no-heading --line-number --color never '%s' %s")
  ;; projectile replacements
  (use-package counsel-projectile
    :demand t
    :config
    (nmap
      "C-q" 'counsel-projectile-find-file
      "C-a" 'counsel-projectile-switch-to-buffer))
  :config
  (nmap
    :prefix rc/leader
    "f" 'counsel-rg
    "h v" 'counsel-describe-variable
    "h f" 'counsel-describe-function)
  (nmap
    "M-x" 'counsel-M-x
    "C-x C-r" 'find-file
    "C-x C-f" 'counsel-find-file
    "C-x C-g" 'counsel-git-grep
    "C-x p" 'counsel-package)
  (nmap
    :prefix rc/leader
    rc/leader 'counsel-M-x
    "T" 'counsel-load-theme
    "j" 'counsel-bookmark))

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
  :after hydra)

;; (use-package ranger)

(use-package avy
  :requires init-general
  :demand t
  :config
  (mmap
    :prefix "C-c j"
    "c" 'avy-goto-char
    "w" 'avy-goto-word-1
    "l" 'avy-goto-line))

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

(setq asdf 1)

(provide 'init-navigation)
