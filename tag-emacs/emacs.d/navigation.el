(use-package ivy
  :init
  (setq
   ;; add 'recentf-mode' and bookmarks to 'ivy-switch-buffer'
   ivy-use-virtual-buffers t
   ;; number of result lines to display
   ivy-height 10
   ;; wrap around ivy results
   ivy-wrap t
   ;; display current candidate
   ivy-count-format "(%d/%d) "
   ;; omit ^ at the beginning of regexp
   ivy-initial-inputs-alist nil)
  (use-package all-the-icons-ivy
    ;; doesn't work for some reason
    ;; works only when enabled manually
    :disabled
    :demand t
    :after all-the-icons
    :commands (all-the-icons-ivy-setup)
    :config
    (all-the-icons-ivy-setup))
  :config
  (ivy-mode 1)
  ;; enable fuzzy matching
  ;; see: https://oremacs.com/2016/01/06/ivy-flx/
  (setq ivy-re-builders-alist
        '((ivy-switch-buffer . ivy--regex-plus)
          (t . ivy--regex-fuzzy)))
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

(use-package flx)

(use-package counsel
  :config
  ;; install projectile replacements (counsel-projectile)
  (counsel-projectile-on)
  :bind
  (("M-x" . counsel-M-x)
   ("C-x C-r" . find-file)
   ("C-x C-f" . counsel-find-file)
   ("C-x f" . counsel-describe-function)
   ("C-x v" . counsel-describe-variable)
   ("C-c g" . counsel-git)
   ("C-c j" . counsel-git-grep)
   ("C-c l" . counsel-ag)
   ("C-c k" . counsel-rg)))

(use-package swiper
  :config
  ;; recenter after swiper is finished
  (setq swiper-action-recenter t)
  (general-define-key
   :keymaps 'swiper-map
   "C-r" 'swiper-query-replace)
  (general-define-key
    "C-s" 'swiper))

(use-package counsel-projectile
  :bind
  (("C-q" . counsel-projectile-find-file)
   ("C-a" . counsel-projectile-switch-to-buffer)))

(use-package hydra)
(use-package ivy-hydra)

;; (use-package ranger)

(use-package bookmark+
  :config
  (use-package bookmark
    :init
    (setq-default bmkp-last-as-first-bookmark-file nil)
    :config
    (bookmark-bmenu-list)
    ;; instead of a splash screen, let's start with the Bookmark List
    (switch-to-buffer "*Bookmark List*")
    (general-define-key
     :prefix "SPC"
     "b" 'bookmark-set)))
