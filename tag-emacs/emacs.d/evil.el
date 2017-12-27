(use-package evil
  :preface
  (defvar rc/evil/esc-hook '(t)
    "A hook run after ESC is pressed in normal mode (invoked by `evil-force-normal-state').
    If a hook returns non-nil, all hooks after it are ignored.")
  (defun rc/evil/attach-esc-hook ()
    "Run all escape hooks, if any returns non-nil, then stop there"
    (run-hook-with-args-until-success 'rc/evil/esc-hook))
  (defun rc/evil/quit ()
    "Esc should always quit"
    (interactive)
    (evil-force-normal-state)
    (keyboard-quit))
  (defun rc/evil/minibuffer-quit ()
    "Abort recursive edit. In Delete Selection mode, if the mark is active, just deactivate it;
    then it takes a second \\[keyboard-quit] to abort the minibuffer."
    (interactive)
    (if (and delete-selection-mode transient-mark-mode mark-active)
        (setq deactivate-mark  t)
        (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
        (abort-recursive-edit)))
  (defun rc/setup-esc-quits ()
    "Setup esc to quit anything"
    (define-key evil-normal-state-map [escape] 'rc/evil/quit)
    (define-key evil-visual-state-map [escape] 'rc/evil/quit)
    (define-key minibuffer-local-map [escape] 'rc/evil/minibuffer-quit)
    (define-key minibuffer-local-ns-map [escape] 'rc/evil/minibuffer-quit)
    (define-key minibuffer-local-completion-map [escape] 'rc/evil/minibuffer-quit)
    (define-key minibuffer-local-must-match-map [escape] 'rc/evil/minibuffer-quit)
    (define-key minibuffer-local-isearch-map [escape] 'rc/evil/minibuffer-quit)
    (advice-add 'evil-force-normal-state :after 'rc/evil/attach-esc-hook))
  (defun rc/evil/restore-normal-state-on-windmove (orig-fn &rest args)
    "If in anything but normal or motion mode when moving to another window, restore normal mode.
    This prevents insert state from bleeding into other modes across windows."
    (unless (memq evil-state '(normal motion emacs))
      (evil-normal-state +1))
    (apply orig-fn args))
  :init
  (setq
   evil-want-C-u-scroll t ; to restore missing C-u in evil
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
   evil-ex-visual-char-range t ; column range for ex commands
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
  ;; disable evil-make-overriding/intercept-map at start-up,
  ;; otherwise, Evil will mess with other mode’s mappings
  (advice-add 'evil-make-intercept-map :override
              (defun my-kill-intercept-maps (&rest _)))
  (advice-add 'evil-make-overriding-map :override
              (defun my-kill-overriding-maps (&rest _)))
  (use-package sentence-navigation
    :after evil
    :config
    (define-key evil-normal-state-map ")" 'sentence-nav-evil-forward)
    (define-key evil-normal-state-map "(" 'sentence-nav-evil-backward)
    (define-key evil-normal-state-map "g)" 'sentence-nav-evil-forward-end)
    (define-key evil-normal-state-map "g(" 'sentence-nav-evil-backward-end)
    (define-key evil-outer-text-objects-map "s" 'sentence-nav-evil-outer-sentence)
    (define-key evil-inner-text-objects-map "s" 'sentence-nav-evil-inner-sentence))
  (use-package evil-mc
    :demand t
    :preface
    (defun rc/evil-mc/esc ()
      "Clear evil-mc cursors and restore state."
      (when (evil-mc-has-cursors-p)
        (evil-mc-undo-all-cursors)
        (evil-mc-resume-cursors)
        t))
    :config
    (global-evil-mc-mode 1)
    (add-hook 'rc/evil/esc-hook 'rc/evil-mc/esc))
  (use-package evil-magit
    :after magit
    :demand t
    :config
    (setq evil-magit-state 'normal))
  (use-package evil-ediff :demand t)
  (use-package evil-matchit
    :demand t
    :commands
    (evilmi-jump-items
     evilmi-text-object
     global-evil-matchit-mode)
    :config
    (global-evil-matchit-mode 1))
  (use-package evil-surround
    :demand t
    :commands
    (global-evil-surround-mode
     evil-surround-edit
     evil-Surround-edit
     evil-surround-region)
    :config
    (global-evil-surround-mode 1))
  (use-package evil-embrace
    :after evil-surround
    :demand t
    :init
    (setq evil-embrace-show-help-p nil)
    :config
    (evil-embrace-enable-evil-surround-integration))
  (use-package evil-visualstar
    :demand t
    :config
    (global-evil-visualstar-mode))
  (use-package evil-vimish-fold
    :demand t
    :init
    (setq vimish-fold-indication-mode 'right-fringe)
    :commands evil-vimish-fold-mode
    :config
    (evil-vimish-fold-mode 1))
  (use-package evil-args
    :demand t
    :commands
    (evil-inner-arg
     evil-outer-arg
     evil-forward-arg
     evil-backward-arg
     evil-jump-out-args))
  (use-package evil-indent-plus
    :demand t
    :commands
    (evil-indent-plus-i-indent
     evil-indent-plus-a-indent
     evil-indent-plus-i-indent-up
     evil-indent-plus-a-indent-up
     evil-indent-plus-i-indent-up-down
     evil-indent-plus-a-indent-up-down))
  (use-package evil-commentary
    :demand t
    :commands
    (evil-commentary
     evil-commentary-yank
     evil-commentary-line)
    :config (evil-commentary-mode))
  (use-package evil-org :demand t)
  (use-package evil-exchange
    :demand t
    :preface
    (defun rc/evil-exchange/cancel ()
      (when evil-exchange--overlays
        (evil-exchange-cancel) t))
    :commands
    (evil-exchange
     evil-exchange-install)
    :config
    (evil-exchange-install)
    (add-hook 'rc/evil/esc-hook 'rc/evil-exchange/cancel))
  (use-package evil-numbers :demand t)
  :config
  ;; normal state == motion state:
  ;; basically avoid motion state and use normal state instead,
  ;; I don't need motion state, so it adds unnecessary complexity
  (setq evil-normal-state-modes (append evil-motion-state-modes evil-normal-state-modes))
  (setq evil-motion-state-modes nil)
  ;; enable evil-mode globally,
  ;; good for ex-vimmers like me
  (evil-mode 1)
  (rc/setup-esc-quits)
  (with-eval-after-load "bookmark"
    (evil-set-initial-state 'bookmark-bmenu-mode 'normal)
    (define-key evil-normal-state-map (kbd "C-]") (kbd "\\ M-."))
    (evil-make-overriding-map bookmark-bmenu-mode-map 'normal)
    (general-evil-define-key 'normal 'bookmark-bmenu-mode-map
      "RET" 'bookmark-bmenu-this-window
      "j" 'evil-next-line
      "k" 'evil-previous-line))
  ;; magit
  ;; (evil-set-initial-state 'magit-status-mode 'emacs)
  ;; special
  (evil-make-overriding-map special-mode-map 'normal)
  ;; compilation
  (evil-set-initial-state 'compilation-mode 'normal)
  ;; occur
  (evil-make-overriding-map occur-mode-map 'normal)
  (evil-set-initial-state 'occur-mode 'normal)
  ;; jumping like in vim
  (define-key evil-normal-state-map (kbd "C-]") (kbd "\\ M-."))
  ;; comment region / uncomment region,
  ;; but I use evil-commentary, so left here as an example
  ;; (define-key evil-normal-state-map (kbd "C-c C-c") 'comment-region)
  ;; (define-key evil-normal-state-map (kbd "C-c C-u") 'uncomment-region)
  (global-set-key [escape] 'evil-exit-emacs-state)
  ;; swap : and ; to make colon commands easier to type in Emacs
  (define-key evil-normal-state-map ";" 'evil-ex)
  (define-key evil-normal-state-map ":" 'evil-repeat-find-char)
  (advice-add 'windmove-do-window-select :around 'rc/evil/restore-normal-state-on-windmove))
