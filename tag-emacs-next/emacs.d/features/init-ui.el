(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(when (fboundp 'horizontal-scroll-bar-mode)
  (horizontal-scroll-bar-mode -1))

;; I generally prefer to hide the menu bar,
;; but doing this on OS X simply makes it
;; update unreliably in GUI frames, so we make an exception
(if (eq system-type 'darwin)
  (add-hook 'after-make-frame-functions
            (lambda (frame)
              (set-frame-parameter frame 'menu-bar-lines
                                   (if (display-graphic-p frame) 1 0))))
  (when (fboundp 'menu-bar-mode)
    (menu-bar-mode -1)))

(when (fboundp 'pixel-scroll-mode)
  (pixel-scroll-mode 1))

(when (boundp 'window-divider-mode)
  (setq window-divider-default-places t
        window-divider-default-bottom-width 1
        window-divider-default-right-width 1)
  (window-divider-mode +1))

;; disable native fullscreen support
;; I don't like sliding animation on Mac OS X
(setq ns-use-native-fullscreen nil)

;; start maximized
(toggle-frame-maximized)

;; toggle fullscreen later
(run-with-idle-timer
  2 nil
  (lambda () (toggle-frame-fullscreen)))

;; use spaces instead of tabs everywhere
(setq-default indent-tabs-mode nil)
;; display tabs as 2 spaces
(setq-default tab-width 2)

;; disable *GNU Emacs* buffer on startup
(setq inhibit-startup-screen t)

(setq use-file-dialog nil)
(setq use-dialog-box nil)

(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

;; non-zero values for `line-spacing' can mess up ansi-term and co,
;; so we zero it explicitly in those cases.
(add-hook
  'term-mode-hook
  (lambda () (setq line-spacing 0)))

;; highlight parens
(setq show-paren-style 'parenthesis)
(show-paren-mode 1)

;; set fringe size
(fringe-mode '(12 . 12))

;; over-write selection to make things
;; slightly less uncomfortable to others
(delete-selection-mode t)

;; don't wrap long lines
(setq-default truncate-lines t)

;; set left and right margins for every window
(setq-default left-margin-width 2)
(setq-default right-margin-width 2)

(set-window-buffer nil (current-buffer))

;; scroll smoothly
(setq
 scroll-margin 0
 scroll-conservatively 10000
 scroll-preserve-screen-position t)

;; show the current time
;; (setq display-time-24hr-format t)
;; (display-time-mode nil)

;; show column number
(column-number-mode t)

;; wrap text at 80 characters
(setq-default fill-column 80)

;; enable automatic line breaking
(auto-fill-mode t)

;; cursor position
(global-hl-line-mode t)
(line-number-mode t)
(column-number-mode t)

;; cursor look
(blink-cursor-mode -1)
(setq cursor-type 'bar)
(setq x-stretch-cursor t)

;; convert certain words into symbols, e.g. lambda becomes λ.
(global-prettify-symbols-mode t)

;; turn-off tooltips on cursor hover-over
(setq mode-line-default-help-echo nil)

(setq
  mode-line-position
  '((line-number-mode ("%l" (column-number-mode ":%c")))))

(provide 'init-ui)
