(require 'init-osx)

(use-package reason-mode
  :requires (init-osx)
  :after dash-at-point
  :ensure nil
  :quelpa (reason-mode :repo "arichiardi/reason-mode" :fetcher github :stable t)
  :config
  (add-to-list 'dash-at-point-mode-alist '(reason-mode . "reason")))

(provide 'init-reason)
