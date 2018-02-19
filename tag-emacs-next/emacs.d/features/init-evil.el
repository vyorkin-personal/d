(require 'init-general)

(use-package evil
  ;; don't block emacs when starting,
  ;; load evil immediately after startup 
  ; :defer .1
  :init
  (setq
    ;; required by evil-collection
    evil-want-integration nil
    ;; to restore missing C-u in evil
    evil-want-C-u-scroll t
    evil-want-C-w-delete t
    evil-want-fine-undo "No"
    evil-want-visual-char-semi-exclusive t
    evil-want-Y-yank-to-eol t
    evil-magic t
    evil-echo-state t
    evil-indent-convert-tabs t
    evil-ex-search-vim-style-regexp t
    evil-overriding-maps nil
    evil-ex-substitute-global t
    ;; column range for ex commands
    evil-ex-visual-char-range t
    evil-insert-skip-empty-lines t
    evil-search-module 'evil-search
    evil-mode-line-format 'nil
    ;; more vim-like behavior
    evil-symbol-word-search t
    ;; cursors
    evil-default-cursor (face-background 'cursor nil t)
    evil-normal-state-cursor 'box
    evil-emacs-state-cursor `(,(face-foreground 'warning) box)
    evil-insert-state-cursor 'bar
    evil-visual-state-cursor 'box)

  :config

  ;; enable evil-mode globally,
  ;; good for ex-vimmers like me
  (evil-mode t)
  ;; special
  (evil-make-overriding-map special-mode-map 'normal)
  ;; compilation
  (evil-set-initial-state 'compilation-mode 'normal)
  ;; occur
  (evil-make-overriding-map occur-mode-map 'normal)
  (evil-set-initial-state 'occur-mode 'normal)

  (general-evil-setup))

(use-package evil-collection
  :after evil
  :init
  (setq
    evil-collection-setup-minibuffer t
    evil-collection-company-use-tgn nil)
  :config
  (evil-collection-init))

(use-package evil-goggles
  :after evil
  :config
  (defun evil-goggles--show-p (beg end)
    "Return t if the overlay should be displayed in region BEG to END."
    (and (not evil-goggles--on)
        (not evil-inhibit-operator-value)
        (bound-and-true-p evil-mode)
        (numberp beg)
        (numberp end)
        (> (- end beg) 1)
        (<= (point-min) beg end)
        (>= (point-max) end beg)
        ;; (not (evil-visual-state-p))
        (not (evil-insert-state-p))
        ;; don't show overlay when evil-mc has multiple fake cursors
        (not (and (fboundp 'evil-mc-has-cursors-p) (evil-mc-has-cursors-p)))
        ;; don't show overlay when the region has nothing but whitespace
        (not (null (string-match-p "[^ \t\n]" (buffer-substring-no-properties beg end))))))

  (setq evil-goggles-duration 0.12
        evil-goggles-enable-delete nil
        evil-goggles-pulse t)

  (evil-goggles-mode))

(use-package evil-lion
  :after evil
  :init
  (setq evil-lion-squeeze-spaces t)
  :commands (evil-lion-mode evil-lion-left evil-lion-right))

(use-package sentence-navigation
  :disabled
  :config
  (general-nmap
    ")" 'sentence-nav-evil-forward
    "(" 'sentence-nav-evil-backward
    "g)" 'sentence-nav-evil-forward-end
    "g(" 'sentence-nav-evil-backward-end)
  (define-key evil-outer-text-objects-map "s" 'sentence-nav-evil-outer-sentence)
  (define-key evil-inner-text-objects-map "s" 'sentence-nav-evil-inner-sentence))

(use-package evil-mc
  :config
  (global-evil-mc-mode 1)
  :diminish evil-mc-mode)

(use-package evil-ediff :demand t)

(use-package evil-matchit
  :commands
  (evilmi-jump-items
    evilmi-text-object
    global-evil-matchit-mode)
  :config
  (global-evil-matchit-mode 1))

(use-package evil-surround
  :commands
  (global-evil-surround-mode
    evil-surround-edit
    evil-Surround-edit
    evil-surround-region)
  :config
  (global-evil-surround-mode 1))

(use-package evil-embrace
  :init
  (setq evil-embrace-show-help-p nil)
  :config
  (evil-embrace-enable-evil-surround-integration))

(use-package evil-visualstar
  :commands
  (global-evil-visualstar-mode
    evil-visualstar/begin-search
    evil-visualstar/begin-search-forward
    evil-visualstar/begin-search-backward)
  :config
  (global-evil-visualstar-mode))

(use-package evil-vimish-fold
  :config
  (evil-vimish-fold-mode 1))

(use-package vimish-fold
  :config
  (use-package evil-vimish-fold
    :init
    (setq
      vimish-fold-indication-mode 'right-fringe
      vimish-fold-header-width nil)
    :commands evil-vimish-fold-mode
    :config
    (add-to-list 'after-init-hook #'evil-vimish-fold-mode)))

(use-package evil-args
  :commands
  (evil-inner-arg
    evil-outer-arg
    evil-forward-arg
    evil-backward-arg
    evil-jump-out-args))

(use-package evil-indent-plus
  :commands
  (evil-indent-plus-i-indent
    evil-indent-plus-a-indent
    evil-indent-plus-i-indent-up
    evil-indent-plus-a-indent-up
    evil-indent-plus-i-indent-up-down
    evil-indent-plus-a-indent-up-down))

(use-package evil-commentary
  :commands
  (evil-commentary
    evil-commentary-yank
    evil-commentary-line)
  :config (evil-commentary-mode))

(use-package evil-org)

(use-package evil-exchange
  :preface
  (defun rc/evil-exchange/cancel ()
    (when evil-exchange--overlays
      (evil-exchange-cancel) t))
  :commands
  (evil-exchange
    evil-exchange-install)
  :config
  (evil-exchange-install))

(use-package evil-numbers)

(provide 'init-evil)
