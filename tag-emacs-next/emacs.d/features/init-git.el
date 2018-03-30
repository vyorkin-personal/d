(require 'init-general)
(require 'init-evil)
(require 'init-editor)
(require 'init-navigation)

(use-package git-commit)

(use-package magit
  :after git-commit
  :custom
  (magit-completing-read-function 'ivy-completing-read "Force Ivy usage."))

(use-package evil-magit
  :requires (init-general init-evil)
  :after (evil magit fullframe)
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
  :custom
  (magithub-clone-default-directory "~/github")
  :config
  (magithub-feature-autoinject t))

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
  ;; its slow
  :disabled
  :requires init-general
  :after general
  :hook
  ((magit-post-refresh . diff-hl-magit-post-refresh)
   (prog-mode . diff-hl-mode)
   (org-mode . diff-hl-mode)
   (dired-mode . diff-hl-dired-mode))
  :config
  (nmap
    :prefix rc/leader
    "t G" 'global-diff-hl-mode))

(use-package gist)

(provide 'init-git)
