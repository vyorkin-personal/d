;; - evil
;; - color-theme
;; - sr-speedbar
;; - projectile
;; - flycheck
;; - company
;; - ivy
;; - counsel
;; - swiper
;; - counsel-projectile
;; - hydra
;; - ivy-hydra
;; - dired+
;; - writeroom-mode
;; - smart-mode-line
;; - smart-mode-line-powerline-theme
;; - ace-window
;; - ripgrep
;; - projectile-ripgrep
;; - multiple-cursors
;; - highlight-indentation
;; - rainbow-delimiters
;; - idle-highlight-mode
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
;;
;; - idris-mode

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(add-to-list 'default-frame-alist '(font . "Source Code Pro 12"))
(set-frame-font "Source Code Pro 12" nil t)

;; disable *GNU Emacs* buffer on startup
(setq inhibit-startup-screen t)
;; disable native fullscreen support
(setq ns-use-native-fullscreen nil)

;; instead of a splash screen,
;; let's start with the Bookmark List
(require 'bookmark)
(bookmark-bmenu-list)
(switch-to-buffer "*Bookmark List*")

;; ad-handle-definition warning are generated when functions are redefined
;; with defadvice in a third-party packages and they aren't helpful
(setq ad-redefinition-action 'accept)

;; highlight the current line in the buffer
(global-hl-line-mode 1)

;; hide the fringe
(set-fringe-style 0)

;; over-write selection to make things
;; slightly less uncomfortable to others
(delete-selection-mode t)

;; mode line ;;

(setq sml/no-confirm-load-theme t)
(setq sml/name-width 20)
(setq sml/mode-width 'full)
(setq sml/shorten-directory t)
(setq sml/shorten-modes t)
(setq sml/theme 'dark)
(sml/setup)

;; (rich-minority-mode 1)
;; (setq rm-blacklist '(" GitGutter" " MRev" " company" " mate" " Projectile"))

;; show the current time
(setq display-time-24hr-format t)
(display-time-mode 1)

;; show column number
(column-number-mode t)

;; enable automatic line breaking
(auto-fill-mode t)

;; automatically save place in each file
(save-place-mode t)

(add-hook 'prog-mode-hook #'highlight-indentation-mode)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook #'idle-highlight-mode)

;; ivy ;;

(ivy-mode 1)

;; add ‘recentf-mode’ and bookmarks to ‘ivy-switch-buffer’.
(setq ivy-use-virtual-buffers t)
;; number of result lines to display
(setq ivy-height 14)
(setq enable-recursive-minibuffers t)
(setq ivy-count-format "(%d/%d) ")
;; enable fuzzy matching
(setq ivy-re-builders-alist
      '((ivy-switch-buffer . ivy--regex-plus)
        (t . ivy--regex-fuzzy)))
;; omit ^ at the beginning of regexp
(setq ivy-initial-inputs-alist nil)

;; install projectile replacements (counsel-projectile)
(counsel-projectile-on)

;; winner-mode ;;

;; restore split pane config, winner-undo, winner-redo
(winner-mode 1)

;; evil ;;

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
  "v" 'split-window-horizontally
  "s" 'split-window-vertically
  "U" 'winner-undo
  "R" 'winner-redo
  "d" 'delete-window
  "o" 'other-window
  "w" 'ace-window
  "SPC" 'delete-other-windows
  "TAB" 'sr-speedbar-toggle
  "a" 'counsel-projectile-switch-project
  "c" 'projectile-invalidate-cache
  "g" 'magit-status)

;; enable evil-mode globally,
;; good for ex-vimmers like me
(evil-mode 1)

;; highlight parens
(setq show-paren-style 'parenthesis)
(show-paren-mode 1)

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

;; use spaces instead of tabs everywhere
(setq-default indent-tabs-mode nil)
;; y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; magit ;;

;; magit requires this setting for ivy completion
(setq magit-completing-read-function 'ivy-completing-read)

;; undo-tree ;;

(setq undo-tree-auto-save-history t)

;; sr-speedbar ;;
(setq sr-speedbar-right-side nil)
(setq speedbar-use-images nil)
(setq speedbar-show-unknown-files t)
(setq sr-speedbar-width 25)
(make-face 'speedbar-face)
(set-face-font 'speedbar-face "Source Code Pro 10")
(setq speedbar-mode-hook '(lambda () (buffer-face-set 'speedbar-face)))

;; theme

;; customize-themes ;;

;; (load-theme 'monochrome t)
(load-theme 'quasi-monochrome t)

(require 'color)
(let ((bg (face-attribute 'default :background)))
    (custom-set-faces
     `(company-tooltip ((t (:inherit default :background ,(color-lighten-name bg 2)))))
     `(company-scrollbar-bg ((t (:background ,(color-lighten-name bg 10)))))
     `(company-scrollbar-fg ((t (:background ,(color-lighten-name bg 5)))))
     `(company-tooltip-selection ((t (:inherit font-lock-function-name-face :background ,(color-lighten-name bg 24))))))
     `(company-tooltip-common ((t (:inherit font-lock-constant-face)))))

;; color-theme ;;
;; (color-theme-initialie)
;; (color-theme-euphoria)

;; projectile ;;

;; projectile requires this setting for ivy completion
(setq projectile-completion-system 'ivy)
;; useful for very large projects
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

;; flycheck ;;
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
(global-flycheck-mode 1)

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; elixir, alchemist, alchemist-hex ;;

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
(evil-define-minor-mode-key 'normal 'alchemist-hex-mode " f" 'alchemist-hex-search)

;; CAREFUL: this is for evil-leader/set-local-mode, which isn't merged yet,
;; see: https://github.com/cofi/evil-leader/pull/35

;; (defun alchemist-hex-local-keys (&rest args)
;;  (evil-leader/set-local-key
;;    "i" 'alchemist-hex-info-at-point))
;; (advice-add 'alchemist-hex-mode :after #'alchemist-hex-local-keys)

;; typescript, tide ;;

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

;; company ;;

(global-company-mode 1)
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 1)

;; global hotkeys

(global-set-key (kbd "<f11>") 'toggle-frame-fullscreen)

(global-set-key (kbd "C-h") 'windmove-left)
(global-set-key (kbd "C-l") 'windmove-right)
(global-set-key (kbd "C-k") 'windmove-up)
(global-set-key (kbd "C-j") 'windmove-down)

(global-set-key (kbd "C-x C-m") 'magit-status)
(global-set-key (kbd "C-x C-y") 'magit-dispatch-popup)

(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-x f") 'counsel-describe-function)
(global-set-key (kbd "C-x v") 'counsel-describe-variable)

(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-rg)

(global-set-key (kbd "C-x C-q") 'projectile-find-file-in-known-projects)
(global-set-key (kbd "C-x C-g") 'projectile-ripgrep)
(global-set-key (kbd "C-q") 'counsel-projectile-find-file)
(global-set-key (kbd "C-a") 'counsel-projectile-switch-to-buffer)

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
 '(custom-safe-themes
   (quote
    ("a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default)))
 '(package-selected-packages
   (quote
    (idle-highlight-mode rainbow-delimiters highlight-indentation dired+ smart-mode-line-powerline-theme smart-mode-line darkroom writeroom-mode evil-anzu ace-window yoshi-theme tao-theme monochrome-theme quasi-monochrome-theme ivy-hydra counsel-projectile counsel ivy idris-mode projectile-ripgrep ripgrep multiple-cursors emmet-mode evil-org alchemist evil-magit magit web-mode tide sr-speedbar projectile evil eldoc-overlay-mode company color-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-scrollbar-bg ((t (:background "#191919"))))
 '(company-scrollbar-fg ((t (:background "#0c0c0c"))))
 '(company-tooltip ((t (:inherit default :background "#050505"))))
 '(company-tooltip-common ((t (:inherit font-lock-constant-face))))
 '(company-tooltip-selection ((t (:inherit font-lock-function-name-face :background "#3d3d3d"))))
 '(idle-highlight ((t (:inherit default :background "controlColor" :foreground "Magenta"))))
 '(ivy-minibuffer-match-face-1 ((t (:background "#333333"))))
 '(ivy-minibuffer-match-face-2 ((t (:background "#444444" :weight bold))))
 '(swiper-line-face ((t (:inherit black :background "black")))))

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved)
;; End:
