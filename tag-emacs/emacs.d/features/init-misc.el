(require 'init-general)
(require 'init-quelpa)

;; provides a simple system for tracking and
;; displaying the uptimes of emacs sessions
(use-package uptimes)

;; measure how many time you execute commands
;; see: http://blog.binchen.org/posts/how-to-be-extremely-efficient-in-emacs.html
(use-package keyfreq
  :config
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1))

(use-package 0xc)
(use-package define-word)

(use-package google-this
  :diminish google-this-mode
  :config
  (google-this-mode 1)
  (nmap
    :prefix rc/leader
    "g g" google-this-mode-submap))

(use-package atomic-chrome
  ;; Even the fork doesn't work for me
  :disabled
  :quelpa
  (atomic-chrome
   :fetcher github
   :repo "dakrone/atomic-chrome"
   :branch "add-server-running-check")
  :custom
  (atomic-chrome-url-major-mode-alist
   '(("reddit\\.com" . markdown-mode)
     ("github\\.com" . gfm-mode)
     ("redmine" . textile-mode))
   "Major modes for URLs.")
  :config
  (when (not (atomic-chrome-server-running-p))
    (atomic-chrome-start-server)))

(use-package net-utils
  :config
  (nmap
    :prefix "C-c n"
    "p" 'ping
    "i" 'ifconfig
    "w" 'iwconfig
    "n" 'netstat
    "p" 'ping
    "a" 'arp
    "r" 'route
    "h" 'nslookup-host
    "d" 'dig
    "s" 'smbclient))

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
