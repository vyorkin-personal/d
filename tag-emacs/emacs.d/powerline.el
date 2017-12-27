(use-package powerline
  :disabled
  :init
  (setq
   powerline-height (truncate (* 1.0 (frame-char-height)))
   powerline-default-separator 'utf-8)
  :config
  ;; see: https://www.emacswiki.org/emacs/DelightedPowerLine
  (defadvice powerline-major-mode (around delight-powerline-major-mode activate)
    "Ensure that powerline's major mode names are delighted. See `delight-major-mode'."
    (let ((inhibit-mode-name-delight nil)) ad-do-it))
  (powerline-default-theme))
