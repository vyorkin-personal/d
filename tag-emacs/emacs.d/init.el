;; less GC during startup
;; see: https://github.com/nilcons/emacs-use-package-fast#a-trick-less-gc-during-startup
(setq gc-cons-threshold 64000000)
;; restore after startup
(add-hook 'after-init-hook (lambda () (setq gc-cons-threshold 800000)))
;; disable garbage collection in minibuffer
;; see: http://tiny.cc/7wd7ay
(add-hook 'minibuffer-setup-hook (lambda () (setq gc-cons-threshold most-positive-fixnum)))
(add-hook 'minibuffer-exit-hook (lambda () (setq gc-cons-threshold 800000)))

;; don't create lock files, fuck collisions
(setq create-lockfiles nil)

;; remove menu bars, toolbars, scrollbars
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(when (fboundp 'horizontal-scroll-bar-mode) (horizontal-scroll-bar-mode -1))

;; uncomment these lines below
;; if you want to change initial window position
;; (when (window-system)
;;   (set-frame-position (selected-frame) 220 130)
;;   (set-frame-height (selected-frame) 40)
;;   (set-frame-width (selected-frame) 120))

(setq
 make-backup-files nil        ; disable backup files
 auto-save-list-file-name nil ; disable .saves files
 auto-save-default nil        ; disable auto saving
 ring-bell-function 'ignore)  ; turn off alarms completely

;; use spaces instead of tabs everywhere
(setq-default indent-tabs-mode nil)
;; display tabs as 2 spaces
(setq-default tab-width 2)

;; y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; fonts ;;

;; (add-to-list 'default-frame-alist '(font . "VT220-mod 28"))
;; (set-frame-font "VT220-mod 28" nil t)

;; (add-to-list 'default-frame-alist '(font . "Source Code Pro 14"))
;; (set-frame-font "Source Code Pro 14" nil t)
(add-to-list 'default-frame-alist '(font . "Fira Code 14"))
(set-frame-font "Fira Code 14" nil t)

;; disable *GNU Emacs* buffer on startup
(setq inhibit-startup-screen t)

;; disable native fullscreen support
;; I don't like sliding animation on Mac OS X
(setq ns-use-native-fullscreen nil)

;; highlight parens
(setq show-paren-style 'parenthesis)
(show-paren-mode 1)

;; hide the fringe
(set-fringe-style 18)

;; over-write selection to make things
;; slightly less uncomfortable to others
(delete-selection-mode t)

(setq
 tramp-default-method "ssh"        ; faster than scp
 tramp-auto-save-directory "/tmp") ; disable autosave for tramp buffers

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

;; highlight the current line in the buffer
(global-hl-line-mode 1)

;; allow minibuffer commands while in the minibuffer
(setq enable-recursive-minibuffers t)

;; convert certain words into symbols, e.g. lambda becomes λ.
(global-prettify-symbols-mode)

;; enable HideShow in programming modes,
;; useful for getting an overview of the code,
;; it works better in some languages and layouts than others
(add-hook 'prog-mode-hook (lambda () (hs-minor-mode t)))

;; enable recentf-mode and remember a lot of files
(recentf-mode 1)
(setq recentf-max-saved-items 200)

;; when gdb debugging, show the many windows (stack trace, break points,etc.)
(setq gdb-many-windows t)

;; automatically save place in each file
(save-place-mode 1)

;; shutdown emacs server instance
(defun rc/server-shutdown ()
  "Save buffers, quit and shutdown (kill) server"
  (interactive)
  (save-some-buffers)
  (kill-emacs))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; uncomment if you want to disable GNU MELPA (for some reason)
;; (setq package-archives nil)

;; its ok to use both package-initialize and use-package for a well behaved package:
;; package-initialize will not load the whole package,
;; but only autoload functions selected by the package author
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))
;; install missing packages by default
(setq use-package-always-ensure t)

;; packages ;;

;; modernizing Emacs' Package Menu
;; with package ratings, usage statistics, customizability, and more
(use-package paradox
  :demand t
  :init
  (setq
   paradox-execute-asynchronously t
   paradox-automatically-star t)
  :config
  ;; replace the default interface with paradox
  (paradox-enable))

(use-package exec-path-from-shell
  :init
  (setq exec-path-from-shell-check-startup-files nil)
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

;; helps keeping ~/.emacs.d clean
;; I need to setup bookmarks file before using this
;; (use-package no-littering)

;; guesses the indentation offset originally used
;; for creating source code files and
;; transparently adjusts the corresponding settings in Emacs,
;; making it more convenient to edit foreign files
(use-package dtrt-indent)

;; makes managing multiple terminals easier
(use-package multi-term)

(use-package highlight-chars
  :config
  (add-hook 'font-lock-mode-hook 'hc-highlight-tabs)
  (add-hook 'font-lock-mode-hook 'hc-highlight-trailing-whitespace))

(use-package whitespace
  :disabled
  :init
  (setq whitespace-style '(face spaces tabs newline space-mark tab-mark))
  (setq whitespace-display-mappings
        '((space-mark 32 [183] [46])
          (newline-mark 10 [182 10])
          (tab-mark 9 [9655 9] [92 9])))
  :preface
  (defvar rc/whitespace/modes
    '(tuareg-mode-hook
      c++-mode-hook
      emacs-lisp-mode-hook
      java-mode-hook
      lua-mode-hook
      rust-mode-hook
      scala-mode-hook
      markdown-mode-hook
      web-mode-hook
      j2-mode-hook
      typescript-mode-hook
      reason-mode-hook
      elixir-mode-hook
      idris-mode-hook
      haskell-mode-hook))
  (defvar rc/whitespace/prev-mode nil)
  (defun rc/whitespace/setup ()
    ;; comment out if you don't want
    ;; hidden chars to be visible by default
    (whitespace-mode 1)
    (add-to-list 'write-file-functions 'delete-trailing-whitespace))
  (make-variable-buffer-local 'rc/whitespace/prev-mode)
  (defun rc/whitespace/pre-popup-draw ()
    "Turn off whitespace mode before showing company complete tooltip"
    (if whitespace-mode
        (progn
          (setq rc/whitespace/prev-mode t)
          (whitespace-mode -1)
          (setq rc/whitespace/prev-mode t))))
  (defun rc/whitespace/post-popup-draw ()
    "Restore previous whitespace mode after showing company tooltip"
    (if rc/whitespace/prev-mode
        (progn
          (whitespace-mode 1)
          (setq rc/whitespace/prev-mode nil))))
  :commands whitespace-mode
  :config
  (dolist (mode rc/whitespace/modes)
    (add-hook mode 'rc/whitespace/setup))
  ;; disable whitespace while popup is displayed
  ;; see: https://github.com/company-mode/company-mode/pull/245#issuecomment-232943098
  (advice-add 'company-pseudo-tooltip-unhide :before 'rc/whitespace/pre-popup-draw)
  (advice-add 'company-pseudo-tooltip-hide :after 'rc/whitespace/post-popup-draw)
  ;; (general-define-key
  ;;  :prefix "SPC"
  ;;  "W" 'whitespace-mode)
  :diminish whitespace-mode)

;; see http://company-mode.github.io/
(use-package company
  :preface
  ;; company interferes with yasnippet's native behaviour
  (defun rc/company/check-expansion ()
    (save-excursion
      (if (looking-at "\\_>") t
        (backward-char 1)
        (if (looking-at "\\.") t
          (backward-char 1)
          (if (looking-at "->") t nil)))))
  (defun rc/company/do-yas-expand ()
    (let ((yas/fallback-behavior 'return-nil))
      (yas/expand)))
  (defun rc/company/tab-indent-or-complete ()
    (interactive)
    (if (minibufferp)
        (minibuffer-complete)
      (if (or (not yas/minor-mode)
              (null (rc/company/do-yas-expand)))
          (if (rc/company/check-expansion)
              (company-complete-common)
            (indent-for-tab-command)))))
  :init
  ;; adjust this setting according to your typing speed
  (setq company-idle-delay 0.4)
  (setq company-minimum-prefix-length 1)
  ;; (setq company-show-numbers t)
  ;; aligns annotation to the right hand side
  (setq company-tooltip-align-annotations t)
  ;; (setq company-tern-meta-as-single-line t)
  ;; (setq company-tooltip-align-annotations t)
  :config
  (use-package company-quickhelp :demand t)
  (use-package company-web :demand t)
  (use-package company-tern :demand t)
  (use-package company-irony :demand t)
  (use-package company-irony-c-headers :demand t)
  ;; use company-mode in all buffers
  (add-hook 'after-init-hook 'global-company-mode)
  (with-eval-after-load 'company
    '(add-to-list 'company-backends
                  '(company-tern
                    company-robe
                    company-irony-c-headers
                    company-irony
                    merlin-company-backend))
    '(define-key company-active-map (kbd "C-c h")
       'company-quickhelp-manual-begin))
  (general-define-key
   :keymaps 'company-active-map
   "C-j" 'company-select-next-or-abort
   "C-k" 'company-select-previous-or-abort)
  :bind
  (:map global-map
        ([tab] . rc/company/tab-indent-or-complete))
  :diminish company-mode)

(use-package highlight-indentation
  :preface
  (defvar rc/highlight-indentation/modes
    '(reason-mode-hook
      idris-mode-hook
      haskell-mode-hook))
  :commands highlight-indentation-mode
  :config
  (dolist (mode rc/highlight-indentation/modes)
    (add-hook mode 'highlight-indentation-mode))
  :diminish highlight-indentation-mode)

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

  (load-theme 'base16-grayscale-dark t)

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
  :disabled
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

(use-package delight
  :config
  (delight '((emacs-lisp-mode " elisp" :major)
             (elixir-mode " ex" elixir)
             (alchemist-mode " al" alchemist)
             (alchemist-hex-mode " alhex" alchemist)
             (alchemist-test-mode " altest" alchemist)
             (rust-mode " rs" rust)
             (javascript-mode " js" js)
             (eldoc-mode " eldoc" eldoc)
             (auto-revert-mode " ar" autorevert)
             (hi-lock-mode " hi" hi-lock))))

(use-package diminish
  :config
  (eval-after-load "simple" '(diminish 'overwrite-mode))
  (eval-after-load "dired" '(diminish 'dired-omit-mode))
  (eval-after-load "hideshow" '(diminish 'hs-minor-mode))
  (eval-after-load "autorevert" '(diminish 'auto-revert-mode))
  (eval-after-load "eldoc" '(diminish 'eldoc-mode)))

(use-package try
  :defer t)

(use-package which-key
  :init
  (setq
   which-key-idle-delay 1
   which-key-side-window-max-height 0.50
   which-key-allow-evil-operators t
   which-key-show-operator-state-maps nil)
  :config
  (which-key-mode)
  :diminish which-key-mode)

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

(use-package general
  :after evil
  :preface
  (defun rc/text-scale-reset ()
    "Reset the text scale to 0."
    (interactive)
    (text-scale-set 0))
  :init
  ;; bind a key globally in normal state; keymaps must be quoted
  (setq general-default-keymaps 'evil-normal-state-map)
  :config
  (general-evil-setup)
  (general-define-key
   "<f11>" 'toggle-frame-fullscreen
   "C-M-=" 'text-scale-increase
   "C-M--" 'text-scale-decrease
   "C-M-0" 'rc/text-scale-reset
   "C-h" 'windmove-left
   "C-l" 'windmove-right
   "C-k" 'windmove-up
   "C-j" 'windmove-down
   "M-l" (kbd "\\ M-.")
   "M-h" 'xref-pop-marker-stack)
  (general-define-key
   :prefix "SPC"
   "f" 'toggle-frame-fullscreen
   "v" 'split-window-horizontally
   "s" 'split-window-vertically
   "p" 'list-processes
   "U" 'winner-undo
   "R" 'winner-redo
   "d" 'delete-window
   "o" 'other-window
   "w" 'ace-window
   "H" 'highlight-indentation-mode
   "G" 'global-git-gutter+-mode
   "T" 'counsel-load-theme
   "j" 'counsel-bookmark
   "q" 'treemacs-toggle
   "SPC" 'counsel-M-x
   "`" 'rc/customize-appearance
   "RET" 'sublimity-mode
   "a" 'counsel-projectile-switch-project
   "c" 'projectile-invalidate-cache
   "gs" 'magit-status
   "gd" 'magit-diff
   "gf" 'magit-file-popup
   "gc" 'magit-commit
   "gl" 'magit-log
   "gp" 'magit-push
   "gw" 'magit-stage-file   ; "write"
   "gr" 'magit-unstage-file ; "remove"
   "gg" 'vc-git-grep)
  (general-evil-define-key 'normal 'help-mode-map
    "q" 'quit-window
    "<" 'help-go-back
    ">" 'help-go-forward)
  (general-define-key
   :keymaps 'process-menu-mode-map
   "M-d" 'process-menu-delete-process))

;; text-scale-increase/decrease doesn't play well with
;; company (suggestions popup alignment issue)
;; more info: https://github.com/company-mode/company-mode/issues/299#issuecomment-115056397
(use-package zoom-frm
  :after general
  :config
  (general-define-key
   "C-=" 'zoom-in/out
   "C--" 'zoom-in/out
   "<s-triple-wheel-up>" 'zoom-frm-in
   "<s-triple-wheel-down>" 'zoom-frm-out))

(use-package restart-emacs
  :commands (restart-emacs)
  :bind ("C-x C-x" . restart-emacs))

(use-package undo-tree
  :defer t
  :init
  (setq
   undo-tree-auto-save-history t
   undo-tree-history-directory-alist `((".*" . "~/.emacs.d/tmp")))
  ;; diff is slow as hell and it doesn't destroy the diff buffer automatically
  ;; (setq undo-tree-visualizer-diff t)
  ;; (setq undo-tree-visualizer-timestamps t)
  :config
  (undo-tree-mode)
  :diminish undo-tree-mode)

(use-package anzu
  :disabled
  :config
  (global-anzu-mode +1)
  (set-face-attribute 'anzu-mode-line nil :foreground "yellow" :weight 'normal)
  (define-key isearch-mode-map [remap isearch-query-replace] 'anzu-isearch-query-replace)
  (define-key isearch-mode-map [remap isearch-query-replace-regexp] 'anzu-isearch-query-replace-regexp)
  :diminish anzu-mode)

(use-package telephone-line
  :config
  (setq
   telephone-line-primary-left-separator 'telephone-line-flat
   telephone-line-secondary-left-separator 'telephone-line-flat
   telephone-line-primary-right-separator 'telephone-line-flat
   telephone-line-secondary-right-separator 'telephone-line-flat
   telephone-line-height 20
   telephone-line-evil-use-short-tag t)
  (require 'telephone-line-config)
  (telephone-line-evil-config))

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

(use-package sublimity
  :defer t
  :init
  (setq
    sublimity-scroll-weight 12
    sublimity-scroll-drift-length 0.5
    sublimity-map-size 20
    sublimity-map-fraction 0.3
    sublimity-map-text-scale -10)
  :config
  (paradox-require 'sublimity-scroll)
  (paradox-require 'sublimity-map) ;; experimental
  (paradox-require 'sublimity-attractive)
  (sublimity-map-set-delay 1))

(use-package rtags
  :defer t)
(use-package ggtags
  :defer t
  :commands ggtags-mode
  :config
  (add-hook 'c-mode-common-hook 'ggtags-mode)
  (add-hook 'ruby-mode-hook 'ggtags-mode)
  (add-hook 'haml-mode-hook 'ggtags-mode)
  :diminish ggtags-mode)

(use-package all-the-icons :demand t)

(use-package treemacs
  :init
  (setq
   treemacs-follow-after-init t
   treemacs-width 20
   treemacs-indentation 2
   treemacs-git-integration t
   treemacs-change-root-without-asking nil
   treemacs-sorting 'alphabetic-desc
   treemacs-show-hidden-files t
   treemacs-never-persist nil
   treemacs-goto-tag-strategy 'refetch-index)
  :config
  (setq treemacs-header-function 'treemacs--create-header-projectile)
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  (general-evil-define-key 'normal 'treemacs-mode-map
    "c" 'treemacs-create-file
    "C" 'treemacs-create-dir
    "d" 'treemacs-delete
    "i" 'treemacs-visit-node-vertical-split
    "s" 'treemacs-visit-node-horizontal-split
    "M-j" 'treemacs-next-neighbour
    "M-k" 'treemacs-previous-neighbour
    "u" 'treemacs-uproot
    "h" 'treemacs-toggle-show-dotfiles
    "M-f" 'treemacs-follow-mode
    "M-W" 'treemacs-toggle-fixed-width
    "M-w" 'treemacs-reset-width
    "M-r" 'treemacs-change-root))

(use-package projectile
  :preface
  (defvar rc/projectile/ignored-dirs
    '(".git" ".svn" "out" "repl" "project"
      "target" "venv" ".emacs.d" "elpa"))
  (defvar rc/projectile/ignored-files
    '(".DS_Store" "TAGS" "*.gz" "*.pyc"
      "*.jar" "*.tar.gz" "*.tgz" "*.zip"))
  :init
  ;; projectile requires this setting for ivy completion
  (setq projectile-completion-system 'ivy)
  ;; useful for very large projects
  (setq projectile-enable-caching t)
  (setq projectile-require-project-root nil)
  (use-package projectile-rails)
  :config
  (setq projectile-globally-ignored-directories
        (append rc/projectile/ignored-dirs
                projectile-globally-ignored-directories))
  (setq projectile-globally-ignored-files
        (append rc/projectile/ignored-files
                projectile-globally-ignored-files))
  ;; use projectile everywhere
  (projectile-mode)
  ;; remove the mode name for projectile-mode, but show the project name
  :delight '(:eval (concat " " (projectile-project-name)))
  :bind
  (:map global-map
        ("C-x C-q" . projectile-find-file-in-known-projects) ; don't use this, it is super-slow
        ("C-x C-g" . projectile-ripgrep)))

(use-package yasnippet
  :defer t
  :init
  (setq yas-snippet-dirs
        '("~/.emacs.d/snippets"
          "~/.emacs.d/yasnippet-snippets"))
  :config
  (yas-global-mode 1)
  :diminish yas-minor-mode)

(use-package irony
  :defer t
  :preface
  (defvar rc/irony/modes
    '(c++-mode-hook
      c-mode-hook
      objc-mode-hook))
  :commands irony-mode
  :config
  (use-package irony-eldoc
    :config
    (add-hook 'irony-mode-hook 'irony-eldoc))
  (dolist (mode rc/irony/modes)
    (add-hook mode 'irony-mode))
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

;; disassemble C/C++ code under cursor
(use-package disaster
  ;; here is why: https://github.com/jart/disaster/issues/13
  :disabled
  :config
  :bind
  (:map c-mode-base-map
        ("C-c d") 'disaster))

(use-package git-gutter+
  :config
  :diminish git-gutter+-mode)

(use-package flycheck
  :defer t
  :init
  (setq-default
   flycheck-disabled-checkers
   '(emacs-lisp-checkdoc javascript-jshint))
  (setq
   flycheck-mode-line-prefix "fly"
   flycheck-javascript-eslint-executable "eslint_d")
  (use-package flycheck-rust)
  (use-package flycheck-clojure)
  (use-package flycheck-irony)

  ;; should be superseeded by psc-ide-mode's flycheck integration
  ;; https://github.com/dysinger/purescript-mode/pull/8
  (use-package flycheck-purescript
    :disabled
    :preface
    (defun rc/flycheck-purescript/setup ()
      (setq default-directory (locate-dominating-file default-directory "node_modules")))
    :after purescript-mode
    :init
    (eval-after-load 'flycheck
      '(add-hook 'flycheck-mode-hook 'flycheck-purescript-setup))
    :config
    (add-hook 'purescript-mode-hook 'rc/flycheck-purescript/setup))

  (use-package flycheck-flow)
  (use-package flycheck-elixir)
  (use-package flycheck-mix
    :config
    (flycheck-mix-setup))
  (use-package flycheck-dialyzer) ;; for erlang
  (use-package flycheck-dialyxir) ;; for elixir
  (use-package flycheck-color-mode-line
    ;; seems to work only with powerline,
    ;; not with telephone-line that I currently use
    :disabled
    :config
    (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))
  :config
  ;; make the error list display like similar lists in contemporary IDEs
  ;; like VisualStudio, Eclipse, etc.
  (add-to-list
   'display-buffer-alist
   `(,(rx bos "*Flycheck errors*" eos)
     (display-buffer-reuse-window display-buffer-in-side-window)
     (side . bottom)
     (reusable-frames . visible)
     (window-height . 0.33)))
  (global-flycheck-mode 1)
  :bind
  (:map global-map
        ([f10] . flycheck-list-errors)))

;; flycheck-error-list-goto-error

(setq flyspell-use-meta-tab nil
      flyspell-mode-line-string " flys"
      flyspell-auto-correct-binding (kbd ""))

;; for programming modes, enable flyspell-prog-mode for
;; spell checking in comments and strings.
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

(use-package flyspell-correct-ivy
  :demand t
  :config
  (setq flyspell-correct-interface 'flyspell-correct-ivy)
  :bind
  (:map flyspell-mode-map
        ("C-;" . flyspell-correct-previous-word-generic)))

(use-package rust-mode
  :config
  (use-package racer
    :demand t
    :commands racer-mode
    :config
    (add-hook 'racer-mode-hook 'eldoc-mode)
    (add-hook 'racer-mode-hook 'company-mode)
    (add-hook 'rust-mode-hook 'racer-mode))
  :commands rust-mode
  :config
  ;; enable rust-mode for .lalrpop files
  (add-to-list 'auto-mode-alist '("\\.lalrpop\\'" . rust-mode))
  :bind
  (:map rust-mode-map
        ([tab] . company-indent-or-complete-common)
        ("C-c <tab>" . rust-format-buffer)))

(use-package clojure-mode)

(use-package ivy
  :init
  (setq
   ;; add 'recentf-mode' and bookmarks to 'ivy-switch-buffer'
   ivy-use-virtual-buffers t
   ;; number of result lines to display
   ivy-height 10
   ;; wrap around ivy results
   ivy-wrap t
   ;; display current candidate
   ivy-count-format "(%d/%d) "
   ;; omit ^ at the beginning of regexp
   ivy-initial-inputs-alist nil)
  (use-package all-the-icons-ivy
    ;; doesn't work for some reason
    ;; works only when enabled manually
    :disabled
    :demand t
    :after all-the-icons
    :commands (all-the-icons-ivy-setup)
    :config
    (all-the-icons-ivy-setup))
  :config
  (ivy-mode 1)
  ;; enable fuzzy matching
  ;; see: https://oremacs.com/2016/01/06/ivy-flx/
  (setq ivy-re-builders-alist
        '((ivy-switch-buffer . ivy--regex-plus)
          (t . ivy--regex-fuzzy)))
  (general-define-key
   :keymaps 'ivy-minibuffer-map
   "C-j" 'ivy-next-line
   "C-k" 'ivy-previous-line
   "C-n" 'ivy-next-history-element
   "C-p" 'ivy-previous-history-element
   "<C-return>" 'ivy-immediate-done
   "C-l" 'ivy-immediate-done
   "C-w" 'ivy-backward-kill-word)
  :diminish ivy-mode)

(use-package flx)

(use-package counsel
  :config
  ;; install projectile replacements (counsel-projectile)
  (counsel-projectile-on)
  :bind
  (:map global-map
        ("M-x" . counsel-M-x)
        ("C-x C-r" . find-file)
        ("C-x C-f" . counsel-find-file)
        ("C-x f" . counsel-describe-function)
        ("C-x v" . counsel-describe-variable)
        ("C-c g" . counsel-git)
        ("C-c j" . counsel-git-grep)
        ("C-c l" . counsel-ag)
        ("C-c k" . counsel-rg)))

(use-package swiper
  :config
  ;; recenter after swiper is finished
  (setq swiper-action-recenter t)
  (general-define-key
   :keymaps 'swiper-map
   "C-r" 'swiper-query-replace)
  (general-define-key
    "C-s" 'swiper))

(use-package counsel-projectile
  :bind
  (:map global-map
        ("C-q" . counsel-projectile-find-file)
        ("C-a" . counsel-projectile-switch-to-buffer)))

(use-package hydra)

(use-package ivy-hydra)

;; dired ;;

(use-package dired
  :ensure nil
  :commands (dired)
  :init
  ;; prevents dired from creating an annoying popup
  ;; when dired-find-alternate-file is called
  (put 'dired-find-alternate-file 'disabled nil)
  (setq
   ;; if there is a dired buffer displayed in the next window,
   ;; use its current directory
   dired-dwim-target t
   dired-omit-verbose nil
   ;; human readable filesize
   dired-listing-switches "-alh"
   ;; recursive copy & delete
   dired-recursive-deletes 'always
   dired-recursive-copies 'always)
  (setq
   delete-by-moving-to-trash t
   trash-directory "~/.emacs.d/trash")
  ;; enable omit mode
  ;; (setq-default dired-omit-mode t)
  ;; hide autosave files
  (setq-default dired-omit-files "^\\.?#")
  ;; uncomment the line below if you want to hide dot files
  ;; (setq-default dired-omit-files (concat dired-omit-files "\\|^\\.[^\\.]"))
  (when (display-graphic-p)
    (use-package all-the-icons-dired
      :config
      (all-the-icons-dired-mode)))
  (use-package dash)
  (use-package dired-hacks-utils)
  (use-package dired-avfs)
  (use-package dired-open)
  (use-package dired-rainbow :demand t)
  (use-package dired-subtree
    :config
    (general-evil-define-key 'normal 'dired-mode-map
      "<tab>" 'dired-subtree-toggle
      "M" 'dired-subtree-mark-subtree
      "U" 'dired-subtree-unmark-subtree))
  (use-package dired-narrow)
  (use-package dired-collapse)
  ;; (use-package dired-quick-sort
  ;;   :config
  ;;   (dired-quick-sort-setup))
  :config
  (defun rc/dired/previous-line ()
    (interactive)
    (dired-previous-line 1)
    (if (bobp) (dired-next-line 1)))
  (defun rc/dired/next-line ()
    (interactive)
    (dired-next-line 1)
    (if (eobp) (dired-next-line -1)))
  (defun rc/dired/up-directory (&optional other-window)
    (interactive "P")
    (let* ((dir (dired-current-directory))
           (orig (current-buffer))
           (up (file-name-directory (directory-file-name dir))))
      (or (dired-goto-file (directory-file-name dir))
          (and (cdr dired-subdir-alist)
               (dired-goto-subdir up))
          (progn
            (kill-buffer orig)
            (dired up)
            (dired-goto-file dir)))))
  (defun rc/dired/diff ()
    "Ediff marked files in dired or selected files in separate window"
    (interactive)
    (let* ((marked-files (dired-get-marked-files nil nil))
           (other-win
            (get-window-with-predicate
             (lambda (window)
               (with-current-buffer (window-buffer window)
                 (and (not (eq window (selected-window)))
                      (eq major-mode 'dired-mode))))))
           (other-marked-files
            (and other-win
                 (with-current-buffer (window-buffer other-win)
                   (dired-get-marked-files nil)))))
      (cond ((= (length marked-files) 2)
             (ediff-files (nth 0 marked-files)
                          (nth 1 marked-files)))
            ((= (length marked-files) 3)
             (ediff-files3 (nth 0 marked-files)
                           (nth 1 marked-files)
                           (nth 2 marked-files)))
            ((and (= (length marked-files) 1)
                  (= (length other-marked-files) 1))
             (ediff-files (nth 0 marked-files)
                          (nth 0 other-marked-files)))
            ((= (length marked-files) 1)
             (dired-diff))
            (t (error "mark exactly 2 files, at least 1 locally")))))
  (defun rc/dired/toggle-marks (arg)
    (save-restriction
      (narrow-to-region (point-at-bol) (point-at-eol))
      (dired-toggle-marks))
    (dired-previous-line arg))
  (defun rc/dired/mark-up () (interactive) (rc/dired/toggle-marks 1))
  (defun rc/dired/mark-down () (interactive) (rc/dired/toggle-marks -1))
  (evil-make-overriding-map dired-mode-map 'normal)
  (general-define-key :states 'normal "-" (kbd "C-x d RET"))
  (general-evil-define-key 'visual 'dired-mode-map
    "m" 'dired-mark
    "u" 'dired-unmark)
  (general-evil-define-key 'normal 'dired-mode-map
    ";" 'evil-ex
    "-" 'rc/dired/up-directory
    "u" 'rc/dired/up-directory
    "=" 'rc/dired/diff
    "RET" 'dired-find-alternate-file
    "a" 'dired-create-directory
    "d" 'dired-do-delete
    "c" 'dired-do-copy
    "r" 'dired-do-rename
    "f" 'counsel-find-file
    "K" 'rc/dired/mark-up
    "J" 'rc/dired/mark-down
    "k" 'rc/dired/previous-line
    "j" 'rc/dired/next-line
    "h" 'dired-hide-details-mode
    "I" 'all-the-icons-dired-mode
    "R" 'revert-buffer
    "gg" 'evil-goto-first-line
    "G" 'evil-goto-line)
  :bind
  (:map global-map
        ;; instantly teleports to the currently
        ;; edited file's position in a dired buffer
        ("C-x C-j" . dired-jump)))

;; left here to play around with it later
(use-package direx
  :disabled
  :init
  (use-package dired-k)
  :bind
  (:map global-map
        ("C-x C-k" . direx:jump-to-directory)))

;; (use-package ranger)

(use-package bookmark+
  :config
  (use-package bookmark
    :init
    (setq-default bmkp-last-as-first-bookmark-file nil)
    :config
    (bookmark-bmenu-list)
    ;; instead of a splash screen, let's start with the Bookmark List
    (switch-to-buffer "*Bookmark List*")
    (general-define-key
     :prefix "SPC"
     "b" 'bookmark-set)))

(use-package ace-window)

(use-package ripgrep)
(use-package projectile-ripgrep)

(use-package multiple-cursors
  ;; I use evil-mc and evil-multiedit instead
  :disabled
  :bind
  (:map global-map
        ("C-M-n" . mc/mark-next-like-this)
        ("C-M-p" . mc/mark-previous-like-this)
        ("C-M-m" . mc/mark-all-like-this)
        ("C-M->" . mc/skip-to-next-like-this)
        ("C-M-<" . mc/skip-to-previous-like-this)))

(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
  :diminish rainbow-delimiters-mode)

(use-package color-identifiers-mode
  :config
  (add-hook 'after-init-hook 'global-color-identifiers-mode)
  :diminish color-identifiers-mode)

(use-package idle-highlight-mode
  :config
  (add-hook 'prog-mode-hook 'idle-highlight-mode))

(use-package solidity-mode)

(use-package nyan-mode
  :disabled
  :config
  (nyan-mode 1)
  (nyan-start-animation))

(use-package rainbow-mode
  :preface
  (defvar rc/rainbow/modes
    '(html-mode-hook
      web-mode-hook
      js2-mode-hook
      typescript-mode-hook
      css-mode-hook))
  :commands rainbow-mode
  :config
  (dolist (mode rc/rainbow/modes)
    (add-hook mode 'rainbow-mode)))

;; org mode ;;

(setq org-ellipsis "•••") ; noticeable ellipsis

(use-package magit
  :after ivy
  :init
  ;; magit requires this setting for ivy completion
  (setq magit-completing-read-function 'ivy-completing-read)
  :diminish magit-mode)

;; measure how many time you execute commands
;; see: http://blog.binchen.org/posts/how-to-be-extremely-efficient-in-emacs.html
(use-package keyfreq
  :demand t
  :config
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1))

(use-package dockerfile-mode)

;; purescript

;; I use my forked version https://github.com/vyorkin-forks/purescript-mode/tree/bugfix/conflicting-quail-rules
;; with some conflicting quail rules disabled from the local path
;; (and I have no idea how to use "use-package" to use package from a local path lol)

(add-to-list 'load-path "~/projects/github/purescript-mode/")
(require 'purescript-mode-autoloads)
(add-to-list 'Info-default-directory-list "~/projects/github/purescript-mode/")

(defun rc/purescript-emmet ()
  (interactive)
  (let ((start (point))
        (end (save-excursion (beginning-of-line-text) (point))))
    (call-process-region start end "purescript-emmet" t t)))

(general-evil-define-key 'insert 'purescript-mode-map
    "C-c C-e" 'rc/purescript-emmet)

(use-package psc-ide
  :preface
  (defun rc/psc-ide/setup ()
    (setq-local evil-auto-indent nil)
    (psc-ide-mode)
    (turn-on-purescript-unicode-input-method)
    (turn-on-purescript-indentation))
  :after purescript-mode
  :init
  (setq psc-ide-use-npm-bin t)
  :config
  (general-evil-define-key 'normal 'psc-ide-mode-map
    "M-l" 'psc-ide-goto-definition)
  (add-hook 'purescript-mode-hook 'rc/psc-ide/setup))

(use-package psci
  :after purescript-mode
  :config
  (add-hook 'purescript-mode-hook 'inferior-psci-mode))

(use-package d-mode)

(use-package nginx-mode)
(use-package yaml-mode
  :delight " yaml")
(use-package markdown-mode)
(use-package apib-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.apib\\'" . apib-mode)))
(use-package toml-mode)
(use-package kotlin-mode)
(use-package glsl-mode)
(use-package jade-mode)
(use-package haml-mode)
(use-package scss-mode
  :delight " scss")
(use-package lua-mode)
(use-package robe
  :config
  (add-hook 'ruby-mode-hook 'robe-mode))
(use-package rubocop
  :config
  (add-hook 'ruby-mode-hook 'rubocop-mode)
  :delight " rubocop")
(use-package go-mode)

(use-package erlang)

(use-package elixir-mode
  :init
  (use-package alchemist
    :demand t
    :init
    (setq
     alchemist-goto-elixir-source-dir "~/projects/github/elixir"
     alchemist-goto-erlang-source-dir "/usr/local/Cellar/erlang/19.2.3")
    :config
    (general-evil-define-key 'normal 'alchemist-mode-map
      :prefix "SPC"
      ;; elixir general key bindings
      "t" 'alchemist-mix-test
      "T" 'alchemist-project-run-tests-for-current-file
      "," 'alchemist-test-toggle-test-report-display
      "h" 'alchemist-help-search-at-point
      "H" 'alchemist-help
      "a" 'alchemist-project-toggle-file-and-tests
      "A" 'alchemist-project-toggle-file-and-tests-other-window
      "m" 'alchemist-mix
      ;; elixir IEx-specific key bindings
      "e" 'alchemist-iex-project-run
      "r" 'alchemist-iex-reload-module)
    (general-evil-define-key 'visual 'alchemist-mode-map
      :prefix "SPC"
      "e" 'alchemist-iex-send-current-line
      "E" 'alchemist-iex-send-current-line-and-go
      "r" 'alchemist-iex-send-region
      "R" 'alchemist-iex-send-region-and-go)
    ;; elixir HEX-specific key bindings
    (general-evil-define-key 'normal 'alchemist-hex-mode-map
      :prefix "SPC"
      "i" 'alchemist-hex-info-at-point
      "I" 'alchemist-hex-info
      "r" 'alchemist-hex-releases-at-point
      "R" 'alchemist-hex-releases
      "f" 'alchemist-hex-search))
  :config
  (add-hook 'elixir-mode-hook 'alchemist-mode)
  (add-hook 'elixir-mode-hook
            (lambda ()
              (when (and
                     (string-equal "exs" (file-name-extension buffer-file-name))
                     (string-equal "mix" (file-name-base buffer-file-name)))
                (alchemist-hex-mode 1)))))

(use-package ensime)
(use-package scala-mode)

(use-package haskell-mode
  :preface
  (defun rc/haskell-mode/setup ()
    (set (make-local-variable 'company-backends)
         (append '((company-capf company-dabbrev-code))
                 company-backends))
    (haskell-doc-mode)
    (setq-local evil-auto-indent nil)
    (haskell-indent-mode))
  :commands (haskell-indent-mode
             interactive-haskell-mode
             haskell-doc-mode)
  :config
  (add-hook 'haskell-mode-hook 'rc/haskell-mode/setup))

(use-package idris-mode)

;; ad-handle-definition warning are generated when functions are redefined
;; with defadvice in a third-party packages and they aren't helpful
(setq ad-redefinition-action 'accept)

(use-package winner
  :demand t
  :defer 5
  :config
  ;; restore split pane config, winner-undo, winner-redo
  (winner-mode 1))

(when (executable-find "rg")
  (progn
    (defconst modi/rg-arguments
              `("--line-number" ; line numbers
                "--smart-case"
                "--follow"      ; follow symlinks
                "--mmap")       ; apply memory map optimization when possible
              "Default rg arguments used in the functions in `projectile' package.")
    (defun advice-projectile-use-rg ()
      "Always use `rg' for getting a list of all files in the project."
      (mapconcat 'identity
                 (append '("\\rg") ; used unaliased version of `rg': \rg
                         modi/rg-arguments
                         '("--null" ; output null separated results,
                           "--files")) ; get file names matching the regex '' (all files)
                 " "))
      (advice-add 'projectile-get-ext-command :override 'advice-projectile-use-rg)))

;; ocaml, reason, merlin ;;

;; setup / init merlin
(let ((opam-share (ignore-errors (car (process-lines "opam" "config" "var" "share")))))
 (when (and opam-share (file-directory-p opam-share))
  ;; register Merlin
  (add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share))
  (autoload 'merlin-mode "merlin" nil t nil)
  ;; automatically start it in OCaml buffers
  (add-hook 'tuareg-mode-hook 'merlin-mode)
  (add-hook 'caml-mode-hook 'merlin-mode)
  ;; use opam switch to lookup ocamlmerlin binary
  (setq merlin-command 'opam)))

;; setup / init tuareg
;; (load "~/.opam/system/share/emacs/site-lisp/tuareg-site-file")

;; c, c++ ;;

(use-package compile
  :preface
  (paradox-require 'cl)
  (defun rc/compile/closest-pathname (&optional (file "Makefile"))
    "Determine the pathname of the first instance of FILE starting from the current directory towards root.
    This may not do the correct thing in presence of links. If it does not find FILE, then it shall return the name
    of FILE in the current directory, suitable for creation"
    (let ((root (expand-file-name "/"))) ;; the win32 builds should translate this correctly
      (expand-file-name
       file
       (loop
        for d = default-directory then (expand-file-name ".." d)
        if (file-exists-p (expand-file-name file d))
        return d
        if (equal d root)
        return nil))))
  ;; need for running Make with the closest Makefile
  (defun rc/compile/setup-make ()
    (set
     (make-local-variable 'compile-command)
     (format "make -f %s" (rc/compile/closest-pathname))))
  :config
  (add-hook 'c++-mode-hook 'rc/compile/setup-make))

;; always use the latest & greatest
(add-hook
 'c++-mode-hook
 (lambda () (setq
        flycheck-gcc-language-standard "c++17"
        flycheck-clang-language-standard "c++17")))

(with-eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook 'flycheck-irony-setup))

(use-package emmet-mode
  :after sgml-mode
  :preface
  (defvar rc/emmet/modes
    '(sgml-mode-hook
      css-mode-hook
      jade-mode-hook))
  :commands emmet-mode
  :config
  (dolist (mode rc/emmet/modes)
    (add-hook mode 'emmet-mode))
  :delight " emmet")

(use-package web-mode
  :after (flycheck company)
  :preface
  (defvar rc/web-mode/extensions
    '("\\.tsx\\'"
      "\\.jsx\\'"))
  (defun rc/web-mode-hook ()
    "Hook for web-mode"
    (set (make-local-variable 'company-backends)
         '(company-tern
           company-web-html
           company-yasnippet
           company-files)))
  :commands web-mode
  :config
  ;; use eslint with web-mode for jsx files
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  (add-hook 'web-mode-hook 'rc/web-mode-hook)
  (dolist (ext rc/web-mode/extensions)
    (add-to-list 'auto-mode-alist `(,ext . web-mode))))

(use-package json-mode)
(use-package json-navigator)

(use-package tern
  :commands tern-mode
  :config
  ;; enable js completion between <script>...</script> etc
  (defadvice company-tern (before web-mode-set-up-ac-sources activate)
    "Set `tern-mode' based on current language before running company-tern."
    (message "advice")
    (if (equal major-mode 'web-mode)
        (let ((web-mode-cur-language (web-mode-language-at-pos)))
            (if (or (string= web-mode-cur-language "javascript")
                    (string= web-mode-cur-language "jsx"))
                (unless tern-mode (tern-mode))
            (if tern-mode (tern-mode -1)))))))

(use-package npm-mode
  :commands (npm-mode npm-global-mode)
  :config
  (npm-global-mode)
  :diminish npm-mode)

(use-package js2-mode
  :init
  ;; indent step is 2 spaces
  (setq-default js2-basic-offset 2)
  (setq-default js-indent-level 2)
  (use-package xref-js2
    :preface
    (defun rc/xref-js2/add-backend ()
      (add-hook 'xref-backend-functions
                'xref-js2-xref-backend nil t))
    :config
    (unbind-key "M-." js2-mode-map)
    (add-hook 'js2-mode-hook 'rc/xref-js2/add-backend))
  (use-package js2-refactor
    :config
    ;; enable minor mode for js refactoring
    ;; see: https://github.com/magnars/js2-refactor.el#refactorings
    (js2r-add-keybindings-with-prefix "C-c C-j")
    (add-hook 'js2-mode-hook 'js2-refactor-mode))
  :commands js2-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  :delight " js2")

(use-package rjsx-mode
  :commands rjsx-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.jsx\\'" . rjsx-mode)))

(use-package typescript-mode
  :init
  (setq
   typescript-indent-level 2
   flycheck-check-syntax-automatically '(save mode-enabled)
   flycheck-tslint-args . ("--type-check"))
  (use-package tide
    :preface
    (defun rc/tide/setup ()
      (tide-setup)
      (flycheck-mode +1)
      (eldoc-mode +1)
      (tide-hl-identifier-mode +1)
      (add-to-list
       'compilation-error-regexp-alist
       '("ERROR in \\(.*\\)\n(\\([0-9]+\\),\\([0-9]+\\)):" 1 2 3))
      (company-mode +1))
    (defun rc/tide/setup-tsx ()
      (when (string-equal "tsx" (file-name-extension buffer-file-name))
        (rc/tide/setup)))
    :config
    (general-evil-define-key '(normal visual) tide-mode-map
      "M-j" 'tide-find-next-reference
      "M-k" 'tide-find-previous-reference
      "M-l" 'tide-jump-to-definition
      "M-h" 'tide-jump-back
      "M-i" 'tide-jump-to-implementation)
    (general-evil-define-key '(normal visual) tide-mode-map
      :prefix "SPC"
      "!" 'tide-restart-server
      "." 'tide-documentation-at-point
      "r" 'tide-references
      "e" 'tide-project-errors
      "n" 'tide-rename-symbol
      "t" 'tide-format
      "x" 'tide-fix
      "@" 'tide-refactor)
    (add-hook 'typescript-mode-hook 'rc/tide/setup)
    ;; enable tide for .tsx files
    (add-hook 'web-mode-hook 'rc/tide/setup-tsx))
  :delight " ts")

(use-package prettier-js
  :preface
  (defvar rc/prettier-js/modes
    '(js2-mode-hook
      web-mode-hook))
  :config
  (dolist (mode rc/prettier-js/modes)
    (add-hook mode 'prettier-js-mode))
  :delight " prttr")

(use-package google-translate
  :init
  (setq google-translate-default-source-language "en")
  (setq google-translate-default-target-language "ru")
  :config
  (paradox-require 'google-translate-default-ui)
  :bind
  (:map global-map
        ("C-c C-t" . google-translate-at-point)
        ("C-c C-q" . google-translate-query-translate)))

;; save customizations somewhere other than your initialization file
(setq custom-file "~/.emacs-custom.el")
(load custom-file)

;; maximize Emacs on startup
;; (set-frame-parameter nil 'fullscreen 'fullboth)

;; bootstrap quelpa ;;
(if (require 'quelpa nil t)
  ;; prevent quelpa from doing anyting
  ;; that requires network connection
  (setq
    quelpa-update-melpa-p nil    ; don't update MELPA git repo
    quelpa-checkout-melpa-p nil  ; don't clone MELPA git repo
    quelpa-upgrade-p nil         ; don't try to update packages
    quelpa-self-upgrade-p nil)   ; don't upgrade quelpa automatically

    ;; (quelpa-self-upgrade)
  (with-temp-buffer
    (url-insert-file-contents "https://raw.github.com/quelpa/quelpa/master/bootstrap.el")
    (eval-buffer)))

;; install use-package and the quelpa handler
(quelpa
 '(quelpa-use-package
   :fetcher github
   :repo "quelpa/quelpa-use-package"))
(require 'quelpa-use-package)

;; advice setting :ensure nil for use-package + quelpa
(quelpa-use-package-activate-advice)

(use-package reason-mode
  :ensure nil
  :quelpa (reason-mode :repo "arichiardi/reason-mode" :fetcher github :stable t))
