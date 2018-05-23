(require 'init-flycheck)
(require 'init-quelpa)

(use-package css-mode)

(use-package scss-mode
  :config
  :delight "scss")

(use-package flycheck-css-colorguard
  :requires init-flycheck
  :after flycheck
  :config
  (flycheck-css-colorguard-setup))

(use-package css-autoprefixer
  :if (executable-find "npx"))

(provide 'init-styles)
