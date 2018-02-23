(require 'init-general)
(require 'init-quelpa)

(use-package bookmark
  :requires (init-quelpa init-general)
  :after general
  :init
  (setq-default bmkp-last-as-first-bookmark-file nil)
  :config
  (bookmark-bmenu-list)
  ;; uncomment if you prefer going straight to bookmarks
  ;; (switch-to-buffer "*Bookmark List*")
  (nmap
    :prefix rc/leader
    "b" 'bookmark-set))

(use-package bookmark+
  :requires init-quelpa
  :after (quelpa bookmark)
  :quelpa (bookmark+ :fetcher github :repo "emacsmirror/bookmark-plus"))

(provide 'init-bookmarks)
