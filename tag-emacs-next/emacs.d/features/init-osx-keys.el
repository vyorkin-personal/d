(when (eq system-type 'darwin)
  (setq
    mac-command-modifier 'super
    mac-option-modifier 'meta
    mac-control-modifier 'control
    ns-function-modifier 'hyper)
  ;; make mouse wheel / trackpad scrolling less jerky
  (setq mouse-wheel-scroll-amount
        '(1 ((shift) . 5) ((control))))
  (dolist (multiple '("" "double-" "triple-"))
    (dolist (direction '("right" "left"))
      (global-set-key (read-kbd-macro (concat "<" multiple "wheel-" direction ">")) 'ignore))))

(provide 'init-osx-keys)
