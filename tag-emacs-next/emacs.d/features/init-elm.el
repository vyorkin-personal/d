(require 'init-general)
(require 'init-flycheck)

(use-package elm-mode
  :requires init-general)

(use-package flycheck-elm
  :requires init-flycheck
  :after (eml-mode flycheck))

(provide 'init-elm)
