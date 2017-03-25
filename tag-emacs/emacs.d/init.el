;; - evil
;; - color-theme
;; - sr-speedbar
;; - projectile
;; - flycheck
;; - company
;; - ripgrep
;; - projetile-ripgrep
;; - multiple-cursors
;; - web-mode
;; - emmet-mode
;; - magit
;; - evil-magit
;; - evil-leader
;; - evil-org
;;
;; - typescript-mode:
;;   Basic font-lock/syntax-highlighting and indentation.
;;   https://github.com/ananthakumaran/typescript.el
;;
;; - tide:
;;   TypeScript Interactive Development Environment for Emacs.
;;   https://github.com/ananthakumaran/tide

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(add-to-list 'default-frame-alist '(font . "Source Code Pro 12"))
(set-frame-font "Source Code Pro 16" nil t)

;; ad-handle-definition warning are generated when functions are redefined
;; with defadvice in a third-party packages and they aren't helpful
(setq ad-redefinition-action 'accept)

;; EVIL

;; to restore missing C-u in evil
(setq evil-want-C-u-scroll t)

(require 'evil)

;; swap : and ; to make colon commands easier to type in Emacs
(define-key evil-motion-state-map ";" 'evil-ex)
(define-key evil-motion-state-map ":" 'evil-repeat-find-char)

;; evilify everyting
(require 'evil-leader)
(require 'evil-magit)
(require 'evil-org)

;; enable leader key
(global-evil-leader-mode)
;; use your thumbs!
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "q" 'sr-speedbar-toggle
  "a" 'projectile-switch-project
  "g" 'magit-status)

;; enable evil-mode globally,
;; good for ex-vimmers like me
(evil-mode 1)

;; highlight parens
(setq show-paren-style 'parenthesis)
(show-paren-mode 1)

;; remove menu bars, toolbars, scrollbars
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(when (fboundp 'horizontal-scroll-bar-mode) (horizontal-scroll-bar-mode -1))

(setq make-backup-files nil)        ; disable backup files
(setq auto-save-list-file-name nil) ; disable .saves files
(setq auto-save-default nil)        ; disable auto saving

;; undo-tree
(setq undo-tree-auto-save-history t)

;; enable basic ido support for files and buffers
(setq ido-enable-flex-matching t)
(ido-mode t)
;; don't ask my permission to create a new buffer
;; (if the file name doesn't exist)
(setq ido-create-new-buffer 'always)
;; customize order in which files are sorted
;; when ido shows them in the minibuffer
(setq ido-file-extensioins-order '(".org" ".txt"))
;; make ido use completion-ignore-extensions
(setq ido-ignore-extensions t)

;; sr-speedbar
(setq sr-speedbar-right-side nil)
(setq speedbar-use-images nil)
(setq speedbar-show-unknown-files t)
(setq sr-speedbar-width 25)
(make-face 'speedbar-face)
(set-face-font 'speedbar-face "Source Code Pro 10")
(setq speedbar-mode-hook '(lambda () (buffer-face-set 'speedbar-face)))

;; color-theme
(color-theme-initialize)
(color-theme-euphoria)

;; PROJECTILE

(setq projectile-enable-caching t)
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
      (advice-add 'projectile-get-ext-command :override #'advice-projectile-use-rg)))

;; use projectile everywhere
(projectile-mode)

;; flycheck
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
(global-flycheck-mode 1)

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; elixir, alchemist, alchemist-hex
(setq alchemist-goto-elixir-source-dir "~/projects/github/elixir")
(setq alchemist-goto-erlang-source-dir "/usr/local/Cellar/erlang/19.2.3")

(add-to-list 'elixir-mode-hook (alchemist-mode +1))
(add-hook 'elixir-mode-hook
	  (lambda ()
	    (when (and
		    (string-equal "exs" (file-name-extension buffer-file-name))
		    (string-equal "mix" (file-name-base buffer-file-name)))
              (alchemist-hex-mode 1))))

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
(evil-define-minor-mode-key 'normal 'alchemist-hex-mode " s" 'alchemist-hex-search)

;; CAREFUL: this is for evil-leader/set-local-mode, which isn't merged yet,
;; see:https://github.com/cofi/evil-leader/pull/35

;; (defun alchemist-hex-local-keys (&rest args)
;;  (evil-leader/set-local-key
;;    "i" 'alchemist-hex-info-at-point))
;; (advice-add 'alchemist-hex-mode :after #'alchemist-hex-local-keys)

;; typescript, tide

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (setq flycheck-tslint-args . ("--type-check"))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

(add-hook 'typescript-mode-hook #'setup-tide-mode)

;; enable tide for .tsx files
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
	  (lambda ()
	    (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))

;; company
(global-company-mode 1)
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 1)

;; global hotkeys
(global-set-key (kbd "<f11>") 'toggle-frame-fullscreen)
(global-set-key (kbd "C-x C-g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)
(global-set-key (kbd "C-q") 'projectile-find-file)
(global-set-key (kbd "C-s") 'projectile-ripgrep)

;; jumping like in vim
(define-key evil-normal-state-map (kbd "C-]") (kbd "\\ M-."))

(require 'multiple-cursors)
;; multiple cursors key bindings
(global-set-key (kbd "C-M-n") 'mc/mark-next-like-this)
(global-set-key (kbd "C-M-p") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-M-m") 'mc/mark-all-like-this)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (projectile-ripgrep ripgrep multiple-cursors emmet-mode evil-org alchemist evil-magit magit web-mode tide sr-speedbar projectile evil eldoc-overlay-mode company color-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved)
;; End:
