(defun rc/expand-emacs (path)
  "Expands `PATH' with Emacs home directory."
  (expand-file-name path user-emacs-directory))

(defun rc/expand-tmp (path)
  "Expand `PATH' with Emacs temporary directory."
  (rc/expand-emacs (format "tmp/%s" path)))

(defun rc/expand-lisp (path)
  "Expand `PATH' with Emacs LISP directory."
  (rc/expand-emacs (format "lisp/%s" path)))

;; shutdown emacs server instance
(defun rc/server-shutdown ()
  "Save buffers, quit and shutdown (kill) server"
  (interactive)
  (save-some-buffers)
  (kill-emacs))

(provide 'init-utils)
