(use-package dired
  :ensure nil
  :commands (dired)
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
  (when (display-graphic-p)
    (use-package all-the-icons-dired
      :config
      (all-the-icons-dired-mode)))
  ;; Mac OS ls command doesn't support "--dired" option
  (when (string= system-type "darwin")
    (setq dired-use-ls-dired nil))
  (use-package dash)
  (use-package dired-hacks-utils)
  (use-package dired-avfs)
  (use-package dired-open)
  (use-package dired-rainbow :demand t)
  (use-package dired-subtree
    :config
    (general-evil-define-key 'normal 'dired-mode-map
      "<tab>" 'dired-subtree-toggle
      "M" 'dired-subtree-mark-subtree
      "U" 'dired-subtree-unmark-subtree))
  (use-package dired-narrow)
  (use-package dired-collapse)
  ;; (use-package dired-quick-sort
  ;;   :config
  ;;   (dired-quick-sort-setup))
  :config
  (defun rc/dired/previous-line ()
    (interactive)
    (dired-previous-line 1)
    (if (bobp) (dired-next-line 1)))
  (defun rc/dired/next-line ()
    (interactive)
    (dired-next-line 1)
    (if (eobp) (dired-next-line -1)))
  (defun rc/dired/up-directory (&optional other-window)
    (interactive "P")
    (let* ((dir (dired-current-directory))
           (orig (current-buffer))
           (up (file-name-directory (directory-file-name dir))))
      (or (dired-goto-file (directory-file-name dir))
          (and (cdr dired-subdir-alist)
               (dired-goto-subdir up))
          (progn
            (kill-buffer orig)
            (dired up)
            (dired-goto-file dir)))))
  (defun rc/dired/diff ()
    "Ediff marked files in dired or selected files in separate window"
    (interactive)
    (let* ((marked-files (dired-get-marked-files nil nil))
           (other-win
            (get-window-with-predicate
             (lambda (window)
               (with-current-buffer (window-buffer window)
                 (and (not (eq window (selected-window)))
                      (eq major-mode 'dired-mode))))))
           (other-marked-files
            (and other-win
                 (with-current-buffer (window-buffer other-win)
                   (dired-get-marked-files nil)))))
      (cond ((= (length marked-files) 2)
             (ediff-files (nth 0 marked-files)
                          (nth 1 marked-files)))
            ((= (length marked-files) 3)
             (ediff-files3 (nth 0 marked-files)
                           (nth 1 marked-files)
                           (nth 2 marked-files)))
            ((and (= (length marked-files) 1)
                  (= (length other-marked-files) 1))
             (ediff-files (nth 0 marked-files)
                          (nth 0 other-marked-files)))
            ((= (length marked-files) 1)
             (dired-diff))
            (t (error "mark exactly 2 files, at least 1 locally")))))
  (defun rc/dired/toggle-marks (arg)
    (save-restriction
      (narrow-to-region (point-at-bol) (point-at-eol))
      (dired-toggle-marks))
    (dired-previous-line arg))
  (defun rc/dired/mark-up () (interactive) (rc/dired/toggle-marks 1))
  (defun rc/dired/mark-down () (interactive) (rc/dired/toggle-marks -1))
  (evil-make-overriding-map dired-mode-map 'normal)
  (general-define-key :states 'normal "-" (kbd "C-x d RET"))
  (general-evil-define-key 'visual 'dired-mode-map
    "m" 'dired-mark
    "u" 'dired-unmark)
  (general-evil-define-key 'normal 'dired-mode-map
    ";" 'evil-ex
    "-" 'rc/dired/up-directory
    "u" 'rc/dired/up-directory
    "=" 'rc/dired/diff
    "RET" 'dired-find-alternate-file
    "a" 'dired-create-directory
    "d" 'dired-do-delete
    "c" 'dired-do-copy
    "r" 'dired-do-rename
    "f" 'counsel-find-file
    "K" 'rc/dired/mark-up
    "J" 'rc/dired/mark-down
    "k" 'rc/dired/previous-line
    "j" 'rc/dired/next-line
    "h" 'dired-hide-details-mode
    "I" 'all-the-icons-dired-mode
    "R" 'revert-buffer
    "gg" 'evil-goto-first-line
    "G" 'evil-goto-line)
  :bind
  (;; instantly teleports to the currently
   ;; edited file's position in a dired buffer
   ("C-x C-j" . dired-jump))
  :diminish dired-mode)

;; left here to play around with it later
(use-package direx
  :disabled
  :init
  (use-package dired-k)
  :bind
  (("C-x C-k" . direx:jump-to-directory)))
