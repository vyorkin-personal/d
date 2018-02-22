;; required by dashboard
(use-package page-break-lines
  :init
  (global-page-break-lines-mode 1)
  :diminish #'page-break-lines-mode)

(use-package dashboard
  :after page-break-lines
  :init
  (setq dashboard-startup-banner "~/.emacs.d/images/lambda-cube.png")
  (setq dashboard-banner-logo-title "each axis represents a new form of abstraction")
  (setq dashboard-items
        '((bookmarks . 5)
         ;(recents  . 5)
          (projects . 5)
          (agenda . 5)
          (registers . 5)))
  :config
  (dashboard-setup-startup-hook)) 

(provide 'init-dashboard)
