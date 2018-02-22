(require 'init-general)

(use-package dired
  :ensure nil
  :commands (dired)
  :diminish dired-mode
  :init
  ;; prevents dired from creating an annoying popup
  ;; when dired-find-alternate-file is called
  (put 'dired-find-alternate-file 'disabled nil)
  (setq
   ;; if there is a dired buffer displayed in the next window,
   ;; use its current directory
   dired-dwim-target t
   dired-omit-verbose nil
   ;; human readable filesize
   dired-listing-switches "-alh"
   ;; recursive copy & delete
   dired-recursive-deletes 'always
   dired-recursive-copies 'always)
  (setq
   delete-by-moving-to-trash t
   trash-directory "~/.emacs.d/trash")
  ;; enable omit mode
  ;; (setq-default dired-omit-mode t)
  ;; hide autosave files
  (setq-default dired-omit-files "^\\.?#")
  ;; uncomment the line below if you want to hide dot files
  ;; (setq-default dired-omit-files (concat dired-omit-files "\\|^\\.[^\\.]"))

  ;; Mac OS ls command doesn't support "--dired" option
  (when (string= system-type "darwin")
    (setq dired-use-ls-dired nil))

  :config
  (nmap
    "-" 'dired-open))

(use-package dash)
(use-package dired-hacks-utils)
(use-package dired-avfs)
(use-package dired-open)
(use-package dired-rainbow :demand t)

(use-package dired-subtree
  :config
  (general-evil-define-key
    :keymaps'dired-mode-map
    "<tab>" 'dired-subtree-toggle
    "M" 'dired-subtree-mark-subtree
    "U" 'dired-subtree-unmark-subtree))

(use-package dired-narrow)
(use-package dired-collapse)

(provide 'init-dired)
