(require 'init-quelpa)
(require 'init-general)

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
   :background (face-background 'default))
  (require 'init-font))

(run-with-idle-timer
 1 nil
 (lambda () (rc/customize-appearance)))

(add-hook 'after-load-theme-hook #'rc/customize-appearance)

(use-package delight
  :config
  (delight
   '((emacs-lisp-mode "elisp" :major)
     (elixir-mode "ex" elixir)
     (alchemist-mode "al" alchemist)
     (alchemist-hex-mode "alhex" alchemist)
     (alchemist-test-mode "altest" alchemist)
     (rust-mode "rs" rust)
     (purescript-mode "purs" purescript)
     (javascript-mode "js" js)
     (eldoc-mode "eldoc" eldoc)
     ;; (hi-lock-mode "hi" hi-lock)
     (subword-mode "sw" subword))))

(use-package diminish
  :config
  (eval-after-load "purescript-indentation" '(diminish 'purescript-indentation-mode))
  (eval-after-load "dired" '(diminish 'dired-omit-mode))
  (eval-after-load "hideshow" '(diminish 'hs-minor-mode))
  (eval-after-load "eldoc" '(diminish 'eldoc-mode))
  (eval-after-load "hi-lock" '(diminish 'hi-lock-mode)))

(use-package page-break-lines
  :init
  (global-page-break-lines-mode 1)
  :diminish page-break-lines-mode)

(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode)
  :diminish rainbow-delimiters-mode)

(use-package rainbow-identifiers
  :hook
  (prog-mode . rainbow-identifiers-mode)
  :diminish rainbow-identifiers-mode)

(use-package rainbow-mode
  :diminish rainbow-mode
  :hook prog-mode)

(use-package highlight-leading-spaces
  :defer 0.8
  :config
  (nmap
    :prefix rc/leader
    "t s" 'highlight-leading-spaces-mode))

(use-package highlight-chars
  :preface
  (defun rc/highlight-chars/setup ()
    (hc-highlight-tabs)
    (hc-highlight-trailing-whitespace))
  :defer 0.5
  :quelpa (highlight-chars :fetcher github :repo "emacsmirror/highlight-chars")
  :config
  (add-hook 'lisp-mode-hook #'rc/highlight-chars/setup)
  (add-hook 'prog-mode-hook #'rc/highlight-chars/setup))

(use-package all-the-icons
  :config
  (add-to-list
   'all-the-icons-mode-icon-alist
   '(package-menu-mode all-the-icons-octicon "package" :v-adjust 0.0)))

(provide 'init-appearance)
