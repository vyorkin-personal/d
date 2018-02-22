(require 'init-general)
(require 'init-quelpa)

(use-package bookmark+
  :after (:both quelpa general)
  :quelpa (bookmark+ :fetcher github :repo "emacsmirror/bookmark-plus")
  :config
  (use-package bookmark
    :init
    (setq-default bmkp-last-as-first-bookmark-file nil)
    :config
    (bookmark-bmenu-list)
    ;; uncomment if you prefer going straight to bookmarks
    ;; (switch-to-buffer "*Bookmark List*")
    (nmap
      :prefix rc/leader
      "b" 'bookmark-set)))

(provide 'init-bookmarks)
