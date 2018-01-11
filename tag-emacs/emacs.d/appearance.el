(defvar after-load-theme-hook nil
  "Hook run after a color theme is loaded using `load-theme'.")
(defadvice load-theme (after run-after-load-theme-hook activate)
  "Run `after-load-theme-hook'."
  (run-hooks 'after-load-theme-hook))

(defun rc/customize-appearance ()
  (interactive)
  ;; set the foreground and background of the vertical-border face to
  ;; the same value so there is no line up the middle
  (set-face-background 'vertical-border "#222222")
  (set-face-foreground 'vertical-border (face-background 'vertical-border))
  ;; set the fringe colors to whatever is the background color
  (set-face-attribute
   'fringe nil
   :foreground (face-foreground 'default)
   :background (face-background 'default)))

(add-hook 'after-load-theme-hook 'rc/customize-appearance)

(use-package base16-theme
  :config
  ;; (load-theme 'base16-chalk t)
  ;; (load-theme 'base16-default-dark t)

  ;; (load-theme 'base16-grayscale-dark t)

  ;; (load-theme 'base16-pop t)
  ;; (load-theme 'base16-tomorrow-night t)
  ;; (load-theme 'base16-twilight t)
  ;; (load-theme 'base16-irblack t)
  )

(use-package dracula-theme :disabled)
(use-package gotham-theme :disabled)
(use-package sublime-themes :disabled)

(use-package doom-themes
  :disabled
  :config
  ;; enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; corrects (and improves) org-mode's native fontification
  (doom-themes-org-config)
  (load-theme 'doom-one t))

(use-package twilight-theme
  :disabled
  :config
  (load-theme 'twilight t))

(use-package gruber-darker-theme
  :disabled
  :config
  (load-theme 'gruber-darker t))

(use-package monokai-theme
  :disabled
  :config
  (load-theme 'monokai t))

(use-package kaolin-theme
  :disabled
  :config
  (load-theme 'kaolin t))

(use-package badwolf-theme
  :disabled
  :config
  (load-theme 'badwolf t))

(use-package boron-theme
  :disabled
  :config
  (load-theme 'boron t))

(use-package bliss-theme
  :disabled
  :config
  (load-theme 'bliss t))

(use-package busybee-theme
  :disabled
  :config
  (load-theme 'busybee t))

(use-package color-theme-sanityinc-tomorrow
  :disabled
  :config
  (color-theme-sanityinc-tomorrow-night))

(use-package badger-theme
  :disabled
  :config
  (load-theme 'badger t))

(use-package atom-one-dark-theme
  :disabled
  :config
  (load-theme 'atom-one-dark t))

(use-package zenburn-theme
  ;; :disabled
  :config
  (load-theme 'zenburn t))

(use-package hemisu-theme
  :disabled
  :config
  (load-theme 'hemisu-dark t))

(use-package paganini-theme
  :disabled
  :config
  (load-theme 'paganini t))

(use-package yoshi-theme
  :disabled
  :config
  (load-theme 'yoshi t))
