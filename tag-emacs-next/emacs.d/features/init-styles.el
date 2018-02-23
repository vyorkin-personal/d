(require 'init-osx)
(require 'init-flycheck)
(require 'init-quelpa)

(use-package css-mode)

(use-package scss-mode
  :requires (init-osx)
  :after dash-at-point
  :config
  (add-to-list 'dash-at-point-mode-alist '(scss-mode . "scss"))
  :delight "scss")

(use-package flycheck-css-colorguard
  :requires init-flycheck
  :after flycheck
  :config
  (flycheck-css-colorguard-setup))

(use-package css-autoprefixer
  :if (executable-find "npx"))

(provide 'init-styles)
