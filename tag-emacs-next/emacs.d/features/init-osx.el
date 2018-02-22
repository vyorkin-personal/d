(require 'init-general)

(setq
  browse-url-browser-function 'browse-url-default-macosx-browser
  delete-by-moving-to-trash t)

(use-package reveal-in-osx-finder
  :demand t
  :config
  (nmap
    :prefix rc/leader
    "@" 'reveal-in-osx-finder))

(use-package dash-at-point
  :config
  (nmap
    :prefix rc/leader
    "d" 'dash-at-point))

(provide 'init-osx)
