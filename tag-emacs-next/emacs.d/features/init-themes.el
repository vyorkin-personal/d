(use-package base16-theme
  :config
  ;; (load-theme 'base16-chalk t)
  ;; (load-theme 'base16-default-dark t)
  ;; (load-theme 'base16-grayscale-dark t)
  ;; (load-theme 'base16-rebecca t)
  ;; (load-theme 'base16-pop t)
  ;; (load-theme 'base16-tomorrow-night t)
  ;; (load-theme 'base16-twilight t)
  ;; (load-theme 'base16-irblack t)
  )

(use-package dracula-theme :defer t)
(use-package gotham-theme :defer t)
(use-package sublime-themes :defer t)

(use-package doom-themes
  :disabled
  :config
  ;; enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; corrects (and improves) org-mode's native fontification
  (doom-themes-org-config)
  (load-theme 'doom-one t))

(use-package twilight-theme :defer t)
(use-package gruber-darker-theme :defer t)
(use-package monokai-theme :defer t)
(use-package badwolf-theme :defer t)
(use-package boron-theme :defer t)
(use-package bliss-theme :defer t)
(use-package busybee-theme :defer t)
(use-package color-theme-sanityinc-tomorrow :defer t)
(use-package badger-theme :defer t)
(use-package atom-one-dark-theme :defer t)
(use-package zenburn-theme :defer t)
(use-package hemisu-theme :defer t)
(use-package paganini-theme :defer t)
(use-package yoshi-theme :defer t)
(use-package moe-theme :defer t)

(use-package theme-changer
  :config
  (change-theme 'base16-rebecca 'base16-chalk))

(provide 'init-themes)
