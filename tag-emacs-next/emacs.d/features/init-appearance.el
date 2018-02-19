(defvar after-load-theme-hook nil
  "Hook run after a color theme is loaded using `load-theme'.")
(defadvice load-theme (after run-after-load-theme-hook activate)
  "Run `after-load-theme-hook'."
  (run-hooks 'after-load-theme-hook))

(defun rc/customize-appearance ()
  (interactive)
  ;; set the background or vertical border to the main area background color
  (set-face-background 'vertical-border (face-background 'default))
  ;; set the foreground and background of the vertical-border face to
  ;; the same value so there is no line up the middle
  (set-face-foreground 'vertical-border (face-background 'vertical-border))
  ;; set the fringe colors to whatever is the background color
  (set-face-attribute
   'fringe nil
   :foreground (face-foreground 'default)
   :background (face-background 'default)))

(add-hook 'after-load-theme-hook 'rc/customize-appearance)

(use-package dimmer
  :init
  (setq-default dimmer-fraction 0.1)
  :config
  (add-hook 'after-init-hook 'dimmer-mode))

(use-package disable-mouse
  :config
  (global-disable-mouse-mode))

(provide 'init-appearance)
