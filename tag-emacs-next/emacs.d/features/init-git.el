(require 'init-general)
(require 'init-evil)
(require 'init-editor)

(use-package evil-magit
  :requires (init-general init-evil)
  :after (evil fullframe)
  :init
  (setq evil-magit-state 'normal)
  :config
  (fullframe magit-log-all quit-window)
  (fullframe magit-log-current quit-window)
  (nmap
   :prefix rc/leader
   "g w" 'magit-stage-file   ; "write"
   "g r" 'magit-unstage-file ; "remove"
   "g s" 'magit-status
   "g d" 'magit-diff
   "g f" 'magit-file-popup
   "g c" 'magit-commit
   "g l" 'magit-log
   "g p" 'magit-push))

(use-package magithub
  :after magit
  :config
  (magithub-feature-autoinject t)
  (setq magithub-clone-default-directory "~/github"))

(use-package git-gutter
  :requires init-general
  :after general
  :config
  (global-git-gutter-mode t)
  ;; (git-gutter:linum-setup)
  (custom-set-variables
   '(git-gutter:update-interval 2)
   '(git-gutter:modified-sign "*")
   '(git-gutter:added-sign "+")
   '(git-gutter:deleted-sign "-")
   '(git-gutter:hide-gutter nil))
  (set-face-foreground 'git-gutter:modified "orange2")
  (set-face-foreground 'git-gutter:added "light green")
  (set-face-foreground 'git-gutter:deleted "maroon3")
  (nmap
    :prefix rc/leader
    "t g" 'git-gutter-mode)
  :diminish git-gutter-mode)

(use-package git-timemachine)

(use-package gitattributes-mode)
(use-package gitignore-mode)
(use-package gitconfig-mode)

(use-package diff-hl
  :config
  (global-diff-hl-mode))

(use-package gist)

(provide 'init-git)
