;; less GC during startup
;; see: https://github.com/nilcons/emacs-use-package-fast#a-trick-less-gc-during-startup
(setq gc-cons-threshold 64000000)
;; restore after startup
(add-hook 'after-init-hook (lambda () (setq gc-cons-threshold 800000)))

;; don't create lock files, fuck collisions
(setq create-lockfiles nil)

;; remove menu bars, toolbars, scrollbars
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(when (fboundp 'horizontal-scroll-bar-mode) (horizontal-scroll-bar-mode -1))

(setq make-backup-files nil)        ; disable backup files
(setq auto-save-list-file-name nil) ; disable .saves files
(setq auto-save-default nil)        ; disable auto saving
(setq ring-bell-function 'ignore)   ; turn off alarms completely

;; use spaces instead of tabs everywhere
(setq-default indent-tabs-mode nil)
;; display tabs as 2 spaces
(setq-default tab-width 2)

;; y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

(add-to-list 'default-frame-alist '(font . "Source Code Pro 16"))
(set-frame-font "Source Code Pro 16" nil t)

;; (add-to-list 'default-frame-alist '(font . "VT220-mod 28"))
;; (set-frame-font "VT220-mod 28" nil t)

;; disable *GNU Emacs* buffer on startup
(setq inhibit-startup-screen t)

;; disable native fullscreen support
;; I don't like sliding animation on Mac OS X
(setq ns-use-native-fullscreen nil)

;; highlight parens
(setq show-paren-style 'parenthesis)
(show-paren-mode 1)

;; hide the fringe
(set-fringe-style 0)

;; over-write selection to make things
;; slightly less uncomfortable to others
(delete-selection-mode t)

;; disable autosave for tramp buffers
(setq tramp-auto-save-directory "/tmp")

;; don't wrap long lines
(setq-default truncate-lines t)

;; set left and right margins for every window
(setq-default left-margin-width 2)
(setq-default right-margin-width 2)

(set-window-buffer nil (current-buffer))

;; show the current time
(setq display-time-24hr-format t)
(display-time-mode 1)

;; show column number
(column-number-mode t)

;; enable automatic line breaking
(auto-fill-mode t)

;; automatically save place in each file
(save-place-mode t)

;; highlight the current line in the buffer
(global-hl-line-mode 1)

;; allow minibuffer commands while in the minibuffer
(setq enable-recursive-minibuffers t)

;; global hotkeys

(global-set-key (kbd "<f11>") 'toggle-frame-fullscreen)

(global-set-key (kbd "C-M-=") 'default-text-scale-increase)
(global-set-key (kbd "C-M--") 'default-text-scale-decrease)

(global-set-key (kbd "C-h") 'windmove-left)
(global-set-key (kbd "C-l") 'windmove-right)
(global-set-key (kbd "C-k") 'windmove-up)
(global-set-key (kbd "C-j") 'windmove-down)

(global-set-key (kbd "C-x C-m") 'magit-status)
(global-set-key (kbd "C-x C-y") 'magit-dispatch-popup)

;; set initial window position
(when (window-system)
  (set-frame-position (selected-frame) 220 130)
  (set-frame-height (selected-frame) 40)
  (set-frame-width (selected-frame) 120))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; uncomment if you want to disable GNU MELPA (for some reason)
;; (setq package-archives nil)

;; its ok to use both package-initialize and use-package for a well behaved package:
;; package-initialize will not load the whole package,
;; but only autoload functions selected by the package author
(package-initialize)

(setq exec-path-from-shell-check-startup-files nil)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

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

(use-package whitespace
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
    (if (minibufferp)
        (minibuffer-complete)
      (if (or (not yas/minor-mode)
              (null (rc/company/do-yas-expand)))
          (if (rc/company/check-expansion)
              (company-complete-common)
            (indent-for-tab-command)))))
  (defun rc/company/setup-ui ()
    (custom-set-variables
     '(company-preview-common
       ((t (:inherit company-preview))))
     '(company-tooltip-common
       ((((type x)) (:inherit company-tooltip :weight normal))
        (t (:inherit company-tooltip))))
     '(company-tooltip-common-selection
       ((((type x)) (:inherit company-tooltip-selection :weight normal))
        (t (:inherit company-tooltip-selection))))))
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
  (rc/company/setup-ui)
  ;; use company-mode in all buffers
  (add-hook 'after-init-hook 'global-company-mode)
  (with-eval-after-load 'company
    '(add-to-list 'company-backends
                  '(company-tern
                    company-irony-c-headers
                    company-irony
                    merlin-company-backend))
    '(define-key company-active-map (kbd "C-c h")
       'company-quickhelp-manual-begin))
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

(use-package base16-theme
  :disabled
  :preface
  (defun rc/theme/grayscale-light ()
    (load-theme 'base16-grayscale-light t)
    (set-face-attribute 'vertical-border nil :foreground "#dddddd"))
  (defun rc/theme/grayscale-dark ()
    (load-theme 'base16-grayscale-dark t)
    (set-face-attribute 'vertical-border nil :foreground "#000000"))
  :config
  (rc/theme/grayscale-light))

(use-package dracula-theme :disabled)
(use-package gotham-theme :disabled)
(use-package sublime-themes :disabled)

(use-package doom-themes
  :config
  ;; enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; corrects (and improves) org-mode's native fontification
  (doom-themes-org-config)
  (load-theme 'doom-one t))

(use-package diminish)
(use-package delight
  :config
  (delight '((auto-revert-mode " ar" autorevert)
             (emacs-lisp-mode " elisp" :major)
             (elixir-mode " ex" elixir)
             (alchemist-mode " alch" alchemist)
             (rust-mode " rs" rust)
             (eldoc-mode " eldoc" eldoc)
             (hi-lock-mode " hi" hi-lock))))

(use-package try
  :defer t)
(use-package which-key
  :defer t
  :init
  (setq which-key-idle-delay 1)
  :config
  (which-key-mode)
  :diminish which-key-mode)

(use-package evil
  :preface
  (defun rc/evil/minibuffer-keyboard-quit ()
    "Abort recursive edit. In Delete Selection mode, if the mark is active, just deactivate it;
    then it takes a second \\[keyboard-quit] to abort the minibuffer."
    (if (and delete-selection-mode transient-mark-mode mark-active)
        (setq deactivate-mark  t)
        (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
        (abort-recursive-edit)))
  (defun rc/setup-esc-quits ()
    "Esc should always quit"
    (define-key evil-normal-state-map [escape] 'keyboard-quit)
    (define-key evil-visual-state-map [escape] 'keyboard-quit)
    (define-key minibuffer-local-map [escape] 'rc/evil/minibuffer-keyboard-quit)
    (define-key minibuffer-local-ns-map [escape] 'rc/evil/minibuffer-keyboard-quit)
    (define-key minibuffer-local-completion-map [escape] 'rc/evil/minibuffer-keyboard-quit)
    (define-key minibuffer-local-must-match-map [escape] 'rc/evil/minibuffer-keyboard-quit)
    (define-key minibuffer-local-isearch-map [escape] 'rc/evil/minibuffer-keyboard-quit))
  :init
  ;; to restore missing C-u in evil
  (setq evil-want-C-u-scroll t)
  (use-package evil-magit)
  (use-package evil-surround)
  (use-package evil-leader
    :demand t
    :config
    (global-evil-leader-mode)
    ;; enable leader key, use your thumbs!
    (evil-leader/set-leader "<SPC>")
    (evil-leader/set-key
      "v" 'split-window-horizontally
      "s" 'split-window-vertically
      "U" 'winner-undo
      "R" 'winner-redo
      "d" 'delete-window
      "o" 'other-window
      "w" 'ace-window
      "W" 'whitespace-mode
      "q" 'treemacs-toggle
      "SPC" 'compile
      "RET" 'sublimity-mode
      "a" 'counsel-projectile-switch-project
      "c" 'projectile-invalidate-cache
      "g" 'magit-status))
  (use-package evil-org :demand t)
  (use-package evil-numbers :demand t)
  :config
  ;; enable evil-mode globally,
  ;; good for ex-vimmers like me
  (evil-mode 1)
  (rc/setup-esc-quits)
  ;; comment region / uncomment region
  (define-key evil-motion-state-map (kbd "C-c C-c") 'comment-region)
  (define-key evil-motion-state-map (kbd "C-c C-u") 'uncomment-region)
  ;; jumping like in vim
  (define-key evil-normal-state-map (kbd "C-]") (kbd "\\ M-."))
  (global-set-key [escape] 'evil-exit-emacs-state)
  ;; swap : and ; to make colon commands easier to type in Emacs
  (define-key evil-motion-state-map ";" 'evil-ex)
  (define-key evil-motion-state-map ":" 'evil-repeat-find-char))

(use-package powerline
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

(use-package undo-tree
  :defer t
  :init
  (setq undo-tree-visualizer-diff t)
  (setq undo-tree-visualizer-timestamps t)
  (setq undo-tree-auto-save-history t)
  :config
  (undo-tree-mode)
  :diminish undo-tree-mode)

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
  :config (add-hook 'c-mode-common-hook 'ggtags-mode)
  :diminish ggtags-mode)

(use-package treemacs
  :init
  (setq
   treemacs-follow-after-init t
   treemacs-width 25
   treemacs-indentation 2
   treemacs-git-integration t
   treemacs-change-root-without-asking nil
   treemacs-sorting 'alphabetic-desc
   treemacs-show-hidden-files t
   treemacs-never-persist nil
   treemacs-goto-tag-strategy 'refetch-index)
  :config
  (use-package treemacs-evil :demand t)
  (setq treemacs-header-function #'treemacs--create-header-projectile)
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  :bind
  (:map treemacs-mode-map
        ("c" . treemacs-create-file)
        ("C" . treemacs-create-dir)
        ("d" . treemacs-delete)
        ("i" . treemacs-visit-node-vertical-split)
        ("o" . treemacs-visit-node-horizontal-split)
        ("u" . treemacs-uproot)
        ("h" . treemacs-toggle-show-dotfiles)
        ("M-f" . treemacs-follow-mode)
        ("M-W" . treemacs-toggle-fixed-width)
        ("M-w" . treemacs-reset-width)
        ("x" . treemacs-change-root)))

(use-package projectile
  :preface
  (defvar rc/projectile/ignored-dirs
    '(".git" ".svn" "out" "repl" "project" "target" "venv"))
  (defvar rc/projectile/ignored-files
    '(".DS_Store" "TAGS" "*.gz" "*.pyc" "*.jar" "*.tar.gz" "*.tgz" "*.zip"))
  :init
  ;; projectile requires this setting for ivy completion
  (setq projectile-completion-system 'ivy)
  ;; useful for very large projects
  (setq projectile-enable-caching t)
  (setq projectile-require-project-root nil)
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
        ("C-x C-q" . projectile-find-file-in-known-projects)
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

(use-package flycheck
  :defer t
  :init
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
  :config
  (global-flycheck-mode 1)
  :diminish flycheck-mode)

(use-package flycheck-rust)
(use-package flycheck-clojure)
(use-package flycheck-irony)
(use-package flycheck-purescript)
(use-package flycheck-flow)
(use-package flycheck-dialyzer)
(use-package flycheck-dialyxir)

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
  ;; add 'recentf-mode' and bookmarks to 'ivy-switch-buffer'
  (setq ivy-use-virtual-buffers t)
  ;; number of result lines to display
  (setq ivy-height 14)
  (setq ivy-count-format "(%d/%d) ")
  ;; omit ^ at the beginning of regexp
  (setq ivy-initial-inputs-alist nil)
  :config
  (ivy-mode 1)
  ;; enable fuzzy matching
  ;; see: https://oremacs.com/2016/01/06/ivy-flx/
  (setq ivy-re-builders-alist
        '((ivy-switch-buffer . ivy--regex-plus)
          (t . ivy--regex-fuzzy)))
  :diminish ivy-mode)

(use-package flx)

(use-package counsel
  :config
  ;; install projectile replacements (counsel-projectile)
  (counsel-projectile-on)
  :bind
  (:map global-map
        ("M-x" . counsel-M-x)
        ("C-x C-f" . counsel-find-file)
        ("C-x f" . counsel-describe-function)
        ("C-x v" . counsel-describe-variable)
        ("C-c g" . counsel-git)
        ("C-c j" . counsel-git-grep)
        ("C-c k" . counsel-rg)))

(use-package swiper
  :bind
  (:map global-map
        ("C-s" . swiper)))

(use-package counsel-projectile
  :bind
  (:map global-map
        ("C-q" . counsel-projectile-find-file)
        ("C-a" . counsel-projectile-switch-to-buffer)))

(use-package hydra)
(use-package ivy-hydra)

(use-package dired+
  :bind
  (:map global-map
        ;; instantly teleports to the currently
        ;; edited file's position in a dired buffer
        ("C-x C-j" . dired-jump)))

(use-package ace-window)
(use-package ripgrep)
(use-package projectile-ripgrep)

(use-package multiple-cursors
  :bind
  (:map global-map
        ("C-M-n" . mc/mark-next-like-this)
        ("C-M-p" . mc/mark-previous-like-this)
        ("C-M-m" . mc/mark-all-like-this)
        ("C-M->" . mc/skip-to-next-like-this)
        ("C-M-<" . mc/skip-to-previous-like-this)))

(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(use-package idle-highlight-mode
  :config
  (add-hook 'prog-mode-hook 'idle-highlight-mode))

(use-package solidity-mode)

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

(use-package emmet-mode)

(use-package magit
  :after ivy
  :init
  ;; magit requires this setting for ivy completion
  (setq magit-completing-read-function 'ivy-completing-read))

(use-package dockerfile-mode)
(use-package purescript-mode)

(use-package d-mode)

(use-package nginx-mode)
(use-package yaml-mode
  :delight " yaml")
(use-package toml-mode)
(use-package kotlin-mode)
(use-package glsl-mode)
(use-package jade-mode)
(use-package lua-mode)
(use-package go-mode)

(use-package typescript-mode)
(use-package tide)

(use-package json-mode)
(use-package erlang)

(use-package elixir-mode
  :after evil-leader
  :init
  (use-package alchemist
    :demand t
    :init
    (setq
     alchemist-goto-elixir-source-dir "~/projects/github/elixir"
     alchemist-goto-erlang-source-dir "/usr/local/Cellar/erlang/19.2.3")
    :config
    ;; evil-leader/set-key-for-mode doesn't work here for some reason
    ;; elixir general key bindings
    (evil-define-minor-mode-key 'normal 'alchemist-mode " t" 'alchemist-mix-test)
    (evil-define-minor-mode-key 'normal 'alchemist-mode " T" 'alchemist-project-run-tests-for-current-file)
    (evil-define-minor-mode-key 'normal 'alchemist-mode " ," 'alchemist-test-toggle-test-report-display)
    (evil-define-minor-mode-key 'normal 'alchemist-mode " h" 'alchemist-help-search-at-point)
    (evil-define-minor-mode-key 'normal 'alchemist-mode " H" 'alchemist-help)
    (evil-define-minor-mode-key 'normal 'alchemist-mode " a" 'alchemist-project-toggle-file-and-tests)
    (evil-define-minor-mode-key 'normal 'alchemist-mode " A" 'alchemist-project-toggle-file-and-tests-other-window)
    (evil-define-minor-mode-key 'normal 'alchemist-mode " m" 'alchemist-mix)
    ;; elixir IEx-specific key bindings
    (evil-define-minor-mode-key 'normal 'alchemist-mode " e" 'alchemist-iex-project-run)
    (evil-define-minor-mode-key 'normal 'alchemist-mode " r" 'alchemist-iex-reload-module)
    (evil-define-minor-mode-key 'visual 'alchemist-mode " e" 'alchemist-iex-send-current-line)
    (evil-define-minor-mode-key 'visual 'alchemist-mode " E" 'alchemist-iex-send-current-line-and-go)
    (evil-define-minor-mode-key 'visual 'alchemist-mode " r" 'alchemist-iex-send-region)
    (evil-define-minor-mode-key 'visual 'alchemist-mode " R" 'alchemist-iex-send-region-and-go)
    ;; elixir HEX-specific key bindings
    (evil-define-minor-mode-key 'normal 'alchemist-hex-mode " i" 'alchemist-hex-info-at-point)
    (evil-define-minor-mode-key 'normal 'alchemist-hex-mode " I" 'alchemist-hex-info)
    (evil-define-minor-mode-key 'normal 'alchemist-hex-mode " r" 'alchemist-hex-releases-at-point)
    (evil-define-minor-mode-key 'normal 'alchemist-hex-mode " R" 'alchemist-hex-releases)
    (evil-define-minor-mode-key 'normal 'alchemist-hex-mode " f" 'alchemist-hex-search))
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
  :commands (haskell-indent-mode
             interactive-haskell-mode
             haskell-doc-mode)
  :config
  (add-hook 'haskell-mode-hook 'haskell-indent-mode)
  (add-hook 'haskell-mode-hook 'interactive-haskell-mode)
  (add-hook 'haskell-mode-hook 'haskell-doc-mode))

(use-package idris-mode)

(use-package bookmark
  :config
  (bookmark-bmenu-list)
  ;; instead of a splash screen, let's start with the Bookmark List
  (switch-to-buffer "*Bookmark List*"))

;; ad-handle-definition warning are generated when functions are redefined
;; with defadvice in a third-party packages and they aren't helpful
(setq ad-redefinition-action 'accept)

;; what the fuck is this shit ?
;; (rich-minority-mode 1)
;; (setq rm-blacklist '(" GitGutter" " MRev" " company" " mate" " Projectile"))

(use-package winner
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
(load "~/.opam/system/share/emacs/site-lisp/tuareg-site-file")

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
(add-hook 'c++-mode-hook
          (lambda () (setq
                      flycheck-gcc-language-standard "c++17"
                      flycheck-clang-language-standard "c++17")))

(with-eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook 'flycheck-irony-setup))

(use-package web-mode
  :after (flycheck company)
  :preface
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
  (add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode)))

;; enable JavaScript completion between <script>...</script> etc.
(defadvice company-tern (before web-mode-set-up-ac-sources activate)
  "Set `tern-mode' based on current language before running company-tern."
  (message "advice")
  (if (equal major-mode 'web-mode)
      (let ((web-mode-cur-language
             (web-mode-language-at-pos)))
        (if (or (string= web-mode-cur-language "javascript")
                (string= web-mode-cur-language "jsx")
                )
            (unless tern-mode (tern-mode))
          (if tern-mode (tern-mode -1))))))


(use-package js2-mode
  :init
  ;; indent step is 2 spaces
  (setq-default js2-basic-offset 2)
  :commands js2-mode
  :config
  (use-package js2-refactor
    :config
    ;; enable minor mode for js refactoring
    ;; see: https://github.com/magnars/js2-refactor.el#refactorings
    (js2r-add-keybindings-with-prefix "C-c C-j")
    (add-hook 'js2-mode-hook 'js2-refactor-mode))
  (add-to-list 'auto-mode-alist (cons (rx ".js" eos) 'js2-mode)))

(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))

;; typescript, tide ;;

(setq typescript-indent-level 2)

(defun setup-tide-mode ()
  (tide-setup)
  (flycheck-mode +1)
  (setq
    flycheck-check-syntax-automatically '(save mode-enabled)
    flycheck-tslint-args . ("--type-check"))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (add-to-list 'compilation-error-regexp-alist
               '("ERROR in \\(.*\\)\n(\\([0-9]+\\),\\([0-9]+\\)):" 1 2 3))
  (company-mode +1))

(add-hook 'typescript-mode-hook 'setup-tide-mode)

;; enable tide for .tsx files
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
    (lambda ()
      (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))

;; prevent quelpa from doing anyting
;; that requires network connection
(setq
  quelpa-update-melpa-p nil    ;; don't update MELPA git repo
  quelpa-checkout-melpa-p nil  ;; don't clone MELPA git repo
  quelpa-upgrade-p nil         ;; don't try to update packages
  quelpa-self-upgrade-p nil)   ;; don't upgrade quelpa automatically

;; bootstrap quelpa ;;
(if (require 'quelpa nil t)
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
