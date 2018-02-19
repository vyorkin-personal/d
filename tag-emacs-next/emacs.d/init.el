;; -*- lexical-binding: t -*-

;; save customizations somewhere other than your initialization file
(setq custom-file "~/.emacs-custom.el")
(load custom-file)

(add-to-list 'load-path (expand-file-name "features" user-emacs-directory))

(defvar rc/gc-threshold-increased 402653184)
(defvar rc/gc-percentage-increased 0.6)

(defvar rc/gc-threshold-normal 16777216)
(defvar rc/gc-percentage-normal 0.1)

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
(defconst *is-a-mac* (eq system-type 'darwin))

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
(add-to-list 'package-archives
             '("elpy" . "http://jorgenschaefer.github.io/packages/"))

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

;; user-specific settings to load before others
(require 'init-preload-local nil t)

(require 'init-fira-code)
(require 'init-appearance)
(require 'init-themes)
(require 'init-utils)
(require 'init-osx-keys)
(require 'init-system)
(require 'init-general)
(require 'init-evil)
(require 'init-process-menu)
(require 'init-dired)
(require 'init-magit)

;; user-specific settings
(require 'init-local nil t)

(provide 'init)
