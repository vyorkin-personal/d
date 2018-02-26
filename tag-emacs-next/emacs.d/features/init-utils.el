(defun expand-emacs (path)
  "Expands `PATH' with Emacs home directory."
  (expand-file-name path user-emacs-directory))

(defun expand-tmp (path)
  "Expand `PATH' with Emacs temporary directory."
  (expand-emacs (format "tmp/%s" path)))

(defun expand-lisp (path)
  "Expand `PATH' with Emacs LISP directory."
  (expand-emacs (format "lisp/%s" path)))

;; shutdown emacs server instance
(defun rc/server-shutdown ()
  "Save buffers, quit and shutdown (kill) server"
  (interactive)
  (save-some-buffers)
  (kill-emacs))

(provide 'init-utils)
