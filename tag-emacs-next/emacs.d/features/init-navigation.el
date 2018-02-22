(require 'init-general)

(use-package flx)

(use-package ivy
  :after flx
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

(use-package counsel
  :init
  ;; much faster than grep
  (setq
    counsel-grep-base-command
    "rg -i -M 120 --no-heading --line-number --color never '%s' %s")
  ;; projectile replacements
  (use-package counsel-projectile
    :demand t
    :config
    ;; for kinesis
    (nmap
      :prefix rc/leader
      "q" 'counsel-projectile-find-file
      "a" 'counsel-projectile-switch-to-buffer)
    ;; for macbook pro
    (nmap
      "C-q" 'counsel-projectile-find-file
      "C-a" 'counsel-projectile-switch-to-buffer))
  :config
  (nmap
   :prefix rc/leader
    "f" 'counsel-rg)
  (nmap
    "M-x" 'counsel-M-x
    "C-x C-r" 'find-file
    "C-x d f" 'counsel-describe-function
    "C-x d v" 'counsel-describe-variable
    "C-x C-f" 'counsel-find-file
    "C-x C-g" 'counsel-git-grep
    "C-x p" 'counsel-package)
  (nmap
   :prefix rc/leader
   rc/leader 'counsel-M-x
   "T" 'counsel-load-theme
   "j" 'counsel-bookmark))

(use-package swiper
  :config
  ;; recenter after swiper is finished
  (setq swiper-action-recenter t)
  (general-define-key
    :keymaps 'swiper-map
    "C-r" 'swiper-query-replace)
  (nmap
    "C-s" 'swiper))

(use-package hydra)
(use-package ivy-hydra)

;; (use-package ranger)

(provide 'init-navigation)
