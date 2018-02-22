;; measure how many time you execute commands
;; see: http://blog.binchen.org/posts/how-to-be-extremely-efficient-in-emacs.html
(use-package keyfreq
  :demand t
  :config
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1))

(use-package speed-type)

(provide 'init-misc)
