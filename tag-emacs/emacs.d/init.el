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

(load-file "~/.emacs.d/font.el")

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

(load-file "~/.emacs.d/functions.el")

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

(load-file "~/.emacs.d/whitespace.el")
(load-file "~/.emacs.d/company.el")

(load-file "~/.emacs.d/appearance.el")
(load-file "~/.emacs.d/deldim.el")
(load-file "~/.emacs.d/highlight.el")

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

(load-file "~/.emacs.d/evil.el")
(load-file "~/.emacs.d/general.el")

(load-file "~/.emacs.d/shell.el")

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
  :bind ("C-x C-/" . restart-emacs))

(load-file "~/.emacs.d/undo-tree.el")
;; (load-file "~/.emacs.d/anzu.el")
;; (load-file "~/.emacs.d/telephone-line.el")
;; (load-file "~/.emacs.d/powerline.el")
;; (load-file "~/.emacs.d/sublimity.el")
;; (load-file "~/.emacs.d/tags.el")
;; (load-file "~/.emacs.d/treemacs.el")

(use-package all-the-icons :demand t)
(use-package git-gutter+
  :config
  :diminish git-gutter+-mode)

(load-file "~/.emacs.d/yasnippet.el")

(use-package ripgrep)
(use-package projectile-ripgrep)

(use-package perspective
  :init
  (use-package persp-projectile
    :demand t)
  :config
  (persp-mode))

(load-file "~/.emacs.d/projectile.el")
(load-file "~/.emacs.d/navigation.el")
(load-file "~/.emacs.d/dired.el")
(load-file "~/.emacs.d/flycheck.el")
;; (load-file "~/.emacs.d/rust.el")

(use-package clojure-mode)
(use-package ace-window)

(use-package multiple-cursors
  ;; I use evil-mc and evil-multiedit instead
  :disabled
  :bind
  (("C-M-n" . mc/mark-next-like-this)
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

(load-file "~/.emacs.d/purescript.el")

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

(load-file "~/.emacs.d/elixir.el")
;; (load-file "~/.emacs.d/scala.el")
(load-file "~/.emacs.d/haskell.el")
(load-file "~/.emacs.d/coq.el")

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

;; (load-file "~/.emacs.d/ocaml.el")
;; (load-file "~/.emacs.d/cxx.el")
(load-file "~/.emacs.d/emmet.el")
(load-file "~/.emacs.d/web.el")
(load-file "~/.emacs.d/json.el")
(load-file "~/.emacs.d/javascript.el")
(load-file "~/.emacs.d/typescript.el")
(load-file "~/.emacs.d/google-translate.el")

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
