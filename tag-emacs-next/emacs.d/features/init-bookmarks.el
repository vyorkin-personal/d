(require 'init-general)
(require 'init-quelpa)

(use-package bookmark
  :requires (init-quelpa init-general)
  :after general
  :init
  (setq bookmark-version-control t)
  (setq bookmark-save-flag 1)
  :config
  ;; uncomment if you prefer going straight to bookmarks
  ;; (bookmark-bmenu-list)
  ;; (switch-to-buffer "*Bookmark List*")
  (nmap
    :prefix rc/leader
    "b" 'bookmark-set))

(provide 'init-bookmarks)
