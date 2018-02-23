(require 'init-general)

;; provides a simple system for tracking and
;; displaying the uptimes of emacs sessions
(use-package uptimes)

;; measure how many time you execute commands
;; see: http://blog.binchen.org/posts/how-to-be-extremely-efficient-in-emacs.html
(use-package keyfreq
  :demand t
  :config
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1))

(use-package define-word)

(use-package speed-type)

;; speed reading
(use-package spray
  :requires init-general
  :after general
  :config
  (nmap
    :prefix rc/leader
    "S" 'spray-mode))

(provide 'init-misc)
