;; shutdown emacs server instance
(defun rc/server-shutdown ()
  "Save buffers, quit and shutdown (kill) server"
  (interactive)
  (save-some-buffers)
  (kill-emacs))

(provide 'init-utils)
