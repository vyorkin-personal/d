;; -*- lexical-binding: t -*-

;; save customizations somewhere other than your initialization file
(setq custom-file "~/.emacs-custom.el")
(load custom-file)

(add-to-list 'load-path (expand-file-name "features" user-emacs-directory))

(defvar rc/gc-threshold-increased 402653184)
(defvar rc/gc-percentage-increased 0.6)

;; see why its set to 20000000:
;; https://github.com/lewang/flx/tree/9c5cb5de0202b4eaac9359c84ca7ce9cbd7ee835#gc-optimization
(defvar rc/gc-threshold-normal 20000000)
(defvar rc/gc-percentage-normal 0.2)

(defun rc/disable-gc ()
  (setq
    gc-cons-threshold rc/gc-threshold-increased
    gc-cons-percentage rc/gc-percentage-increased))

(defun rc/restore-gc ()
  (setq
    gc-cons-threshold rc/gc-threshold-normal
    gc-cons-percentage rc/gc-percentage-normal))

;; disable GC during startup
(rc/disable-gc)
;; don't keep gc-cons-threshold too high. It helps to stave off the GC while
;; emacs starts up, but afterwards it causes stuttering and random freezes. So
;; Reset it to a reasonable default.
(add-hook 'after-init-hook #'rc/restore-gc)

;; disable garbage collection in minibuffer
;; see: http://tiny.cc/7wd7ay
(add-hook 'minibuffer-setup-hook #'rc/disable-gc)
(add-hook 'minibuffer-exit-hook #'rc/restore-gc)

;; enable with t if you prefer
(defconst *spell-check-support-enabled* nil)

(require 'init-defaults)
(require 'init-ui)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.milkbox.net/packages/") t)
;; include the org repository for completeness,
;; but don't normally use it
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/"))
;; elpy (emacs python dev env) packages
;; (add-to-list 'package-archives
;;              '("elpy" . "http://jorgenschaefer.github.io/packages/"))

;; its ok to use both package-initialize and
;; use-package for a well behaved package:
;; package-initialize will not load the whole package,
;; but only autoload functions selected by the package author
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(setq
  ;; install missing packages by default
  use-package-always-ensure t
  use-package-verbose nil)

(use-package shut-up
  :config
  (when noninteractive
    (shut-up-silence-emacs)))

(require 'init-benchmarking)
(require 'init-utils)

;; user-specific settings to load before others
(require 'init-preload-local nil t)

(require 'init-quelpa)
(require 'init-font)
(require 'init-general)
(require 'init-evil)
(require 'init-hydra)
(require 'init-appearance)
(require 'init-themes)
(require 'init-osx-keys)
(require 'init-system)
(require 'init-osx)
(require 'init-behavior)
(require 'init-editor)
(require 'init-diff)
(require 'init-bookmarks)
(require 'init-dashboard)
(require 'init-mode-line)
(require 'init-helm)
(require 'init-process-menu)
(require 'init-company)
(require 'init-fill-column)
(require 'init-flycheck)
(require 'init-flyspell)
(require 'init-dired)
(require 'init-navigation)
(require 'init-projectile)
(require 'init-git)
(require 'init-shell)
(require 'init-undo-tree)
(require 'init-neotree)
(require 'init-ssh)
(require 'init-smartparens)
(require 'init-yasnippet)
(require 'init-org)
(require 'init-translate)
(require 'init-elisp)
(require 'init-markdown)
(require 'init-emmet)
(require 'init-web)
(require 'init-styles)
(require 'init-typescript)
(require 'init-flow)
(require 'init-javascript)
(require 'init-json)
(require 'init-geiser)
(require 'init-scheme)
(require 'init-racket)
(require 'init-sml)
(require 'init-clojure)
(require 'init-rust)
(require 'init-scala)
(require 'init-ocaml)
(require 'init-reason)
(require 'init-erlang)
(require 'init-elixir)
(require 'init-haskell)
(require 'init-idris)
(require 'init-purescript)
(require 'init-elm)
(require 'init-kotlin)
(require 'init-yaml)
(require 'init-ruby)
(require 'init-python)
(require 'init-go)
(require 'init-cxx)
(require 'init-coq)
(require 'init-brainfuck)
(require 'init-docker)
(require 'init-octave)
(require 'init-infra)
(require 'init-k8s)
(require 'init-prodigy)
(require 'init-rest)
(require 'init-irc)
(require 'init-email)
(require 'init-ticker)
(require 'init-transmission)
(require 'init-pomodoro)
(require 'init-stats)
(require 'init-entertainment)
(require 'init-misc)

;; USER-specific settings
(require 'init-local nil t)

(provide 'init)
