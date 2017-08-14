(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; bootstrap quelpa ;;
(if (require 'quelpa nil t)
    ;; (quelpa-self-upgrade)
  (with-temp-buffer
    (url-insert-file-contents "https://raw.github.com/quelpa/quelpa/master/bootstrap.el")
    (eval-buffer)))

;; (setq quelpa-upgrade-p t)

;; packages ;;

(quelpa 'exec-path-from-shell)
(quelpa 'evil)
(quelpa 'all-the-icons)
(quelpa 'whitespace)
(quelpa 'google-translate)
(quelpa 'rtags)
(quelpa 'ggtags)
(quelpa 'neotree)
(quelpa 'projectile)
(quelpa 'irony)
(quelpa 'irony-eldoc)
(quelpa 'disaster)
(quelpa 'flycheck)
(quelpa 'flycheck-rust)
(quelpa 'flycheck-clojure)
(quelpa 'flycheck-irony)
(quelpa 'flycheck-purescript)
(quelpa 'flycheck-flow)
(quelpa 'flycheck-dialyzer)
(quelpa 'flycheck-dialyxir)
(quelpa 'yasnippet)
(quelpa 'company)
(quelpa 'company-web)
(quelpa 'company-tern)
(quelpa 'company-irony)
(quelpa 'company-irony-c-headers)
(quelpa 'rust-mode)
(quelpa 'clojure-mode)
(quelpa 'racer)
(quelpa 'ivy)
(quelpa 'flx)
(quelpa 'counsel)
(quelpa 'swiper)
(quelpa 'counsel-projectile)
(quelpa 'hydra)
(quelpa 'ivy-hydra)
(quelpa 'dired+)
(quelpa 'writeroom-mode)
(quelpa 'smart-mode-line)
(quelpa 'ace-window)
(quelpa 'ripgrep)
(quelpa 'projectile-ripgrep)
(quelpa 'multiple-cursors)
(quelpa 'highlight-indentation)
(quelpa 'rainbow-delimiters)
(quelpa 'idle-highlight-mode)
(quelpa 'solidity-mode)
(quelpa 'web-mode)
(quelpa 'rainbow-mode)
(quelpa 'emmet-mode)
(quelpa 'magit)
(quelpa 'evil-magit)
(quelpa 'evil-leader)
(quelpa 'evil-org)
(quelpa 'base16-themes)
(quelpa 'sublime-themes)
(quelpa 'dockerfile-mode)
(quelpa 'purescript-mode)
(quelpa 'd-mode)
(quelpa 'nginx-mode)
(quelpa 'yaml-mode)
(quelpa 'toml-mode)
(quelpa 'kotlin-mode)
(quelpa 'glsl-mode)
(quelpa 'jade-mode)
(quelpa 'lua-mode)
(quelpa 'go-mode)
(quelpa 'typescript-mode)
(quelpa 'tide)
(quelpa 'js2-mode)
(quelpa 'js2-refactor)
(quelpa 'json-mode)
(quelpa 'erlang-mode)
(quelpa 'elixir-mode)
(quelpa 'alchemist)
(quelpa 'ensime)
(quelpa 'scala-mode)
(quelpa 'haskell-mode)
(quelpa 'idris-mode)
(quelpa '(reason-mode :repo "arichiardi/reason-mode" :fetcher github :stable t))

(add-to-list 'default-frame-alist '(font . "Source Code Pro 12"))
;; (add-to-list 'default-frame-alist '(font . "VT220-mod 28"))

(set-frame-font "Source Code Pro 12" nil t)
;;(set-frame-font "VT220-mod 28" nil t)

;; disable *GNU Emacs* buffer on startup
(setq inhibit-startup-screen t)

;; disable native fullscreen support
;; I don't like sliding animation on Mac OS X
(setq ns-use-native-fullscreen nil)

;; (require 'bookmark)
;; (bookmark-bmenu-list)

;; instead of a splash screen, let's start with the Bookmark List
;; (switch-to-buffer "*Bookmark List*")

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

;; disable annoying warning message about environment variables setting
(setq exec-path-from-shell-check-startup-files nil)
;; make Emacs use the $PATH set up by the user's shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; don't wrap long lines
(setq-default truncate-lines t)

;; set left and right margins for every window
(setq-default left-margin-width 2 right-margin-width 2)
(set-window-buffer nil (current-buffer))

;; rainbow ;;

(require 'rainbow-mode)

(defun rc/setup-rainbow-mode ()
  (interactive)
  (rainbow-mode 1))

(let ((rainbow-enabled-modes
       '(
         html-mode-hook
         web-mode-hook
         js2-mode-hook
         typescript-mode-hook
         css-mode-hook)))
  (dolist (mode rainbow-enabled-modes)
    (add-hook mode 'rc/setup-rainbow-mode)))

;; whitespace ;;

(require 'whitespace)

(setq whitespace-display-mappings
      '((space-mark 32 [183] [46])
        (newline-mark 10 [182 10])
        (tab-mark 9 [9655 9] [92 9])))

(defun rc/setup-whitespace-handling ()
  (interactive)
  (whitespace-mode 1)
  (add-to-list 'write-file-functions 'delete-trailing-whitespace))

(let ((whitespace-enabled-modes
       '(
         tuareg-mode-hook
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
         haskell-mode-hook)))
  (dolist (mode whitespace-enabled-modes)
    (add-hook mode 'rc/setup-whitespace-handling)))

;; disable whitespace white popup is displayed
;; see: https://github.com/company-mode/company-mode/pull/245#issuecomment-232943098
(defvar my-prev-whitespace-mode nil)
(make-variable-buffer-local 'my-prev-whitespace-mode)
(defun pre-popup-draw ()
  "Turn off whitespace mode before showing company complete tooltip"
  (if whitespace-mode
      (progn
        (setq my-prev-whitespace-mode t)
        (whitespace-mode -1)
        (setq my-prev-whitespace-mode t))))
(defun post-popup-draw ()
  "Restore previous whitespace mode after showing company tooltip"
  (if my-prev-whitespace-mode
      (progn
        (whitespace-mode 1)
        (setq my-prev-whitespace-mode nil))))
(advice-add 'company-pseudo-tooltip-unhide :before #'pre-popup-draw)
(advice-add 'company-pseudo-tooltip-hide :after #'post-popup-draw)

;; google-translate ;;

(require 'google-translate)
(require 'google-translate-default-ui)

(setq google-translate-default-source-language "en")
(setq google-translate-default-target-language "ru")

(global-set-key (kbd "C-c C-t") 'google-translate-at-point)
(global-set-key (kbd "C-c C-q") 'google-translate-query-translate)

;; mode line ;;

(setq sml/no-confirm-load-theme t)
(setq sml/name-width 20)
(setq sml/mode-width 'full)
(setq sml/shorten-directory t)
(setq sml/shorten-modes t)
(setq sml/theme 'dark)
;; (sml/setup)

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

;; (add-hook 'prog-mode-hook #'highlight-indentation-mode)
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
;; see: https://oremacs.com/2016/01/06/ivy-flx/
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

;; comment region / uncomment region
;; (define-key evil-window-map (kbd "C-c") 'comment-region)
;; (define-key evil-window-map (kbd "C-c C-u") 'uncomment-region)

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
  "q" 'neotree-toggle
  "r" 'neotree-toggle
  "SPC" 'compile
  "RET" 'writeroom-mode
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

;; turn off alarms completely
(setq ring-bell-function 'ignore)

;; use spaces instead of tabs everywhere
(setq-default indent-tabs-mode nil)
;; display tabs as 2 spaces
(setq-default tab-width 2)

;; y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; magit ;;

;; magit requires this setting for ivy completion
(setq magit-completing-read-function 'ivy-completing-read)

;; rtags ;;

(require 'rtags)

;; ggtags ;;

(require 'ggtags)

(defun rc/setup-ggtags ()
  (interactive)
  (ggtags-mode 1))

(add-hook 'c-mode-common-hook 'rc/setup-ggtags)

;; dired+ ;;

;; instantly teleports to the currently
;; edited file’s position in a dired buffer
(global-set-key (kbd "C-x C-j") 'dired-jump)

;; all-the-icons, neotree ;;

(require 'all-the-icons)
(require 'neotree)
;; (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(setq neo-theme 'arrow)
;; every time when the neotree window is opened, let it find current file and jump to node
(setq neo-smart-open t)
(setq neo-window-width 34)

;; when running ‘projectile-switch-project’, ‘neotree’ will change root automatically
;; (setq projectile-switch-project-action 'neotree-projectile-action)

(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)

(evil-define-key 'normal neotree-mode-map (kbd "i") 'neotree-enter-horizontal-split)
(evil-define-key 'normal neotree-mode-map (kbd "s") 'neotree-enter-vertical-split)
(evil-define-key 'normal neotree-mode-map (kbd "v") 'neotree-enter-vertical-split)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "h") 'neotree-hidden-file-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "a") 'neotree-stretch-toggle)

(evil-define-key 'normal neotree-mode-map (kbd "c") 'neotree-create-node)
(evil-define-key 'normal neotree-mode-map (kbd "r") 'neotree-rename-node)
(evil-define-key 'normal neotree-mode-map (kbd "d") 'neotree-delete-node)

(evil-define-key 'normal neotree-mode-map (kbd "U") 'neotree-select-up-node)
(evil-define-key 'normal neotree-mode-map (kbd "D") 'neotree-select-up-node)

;; undo-tree ;;

(setq undo-tree-auto-save-history t)

;; theme

;; customize-themes ;;

;; (load-theme 'monochrome t)
;; (load-theme 'quasi-monochrome t)
;; (load-theme 'abyss t)
;; (load-theme 'cyberpunk t)
;; (load-theme 'afternoon t)
;; (load-theme 'paganini t)
;; (load-theme 'gotham t)
;; (load-theme 'deeper-blue t)
;; (load-theme 'gruber-darker t)
(load-theme 'base16-grayscale-dark t)
;; (load-theme 'base16-tomorrow t)
;; (load-theme 'base16-atelier-forest-light t)
;; (load-theme 'base16-atelier-heath-light t)
;; (load-theme 'base16-default-light t)
;; (load-theme 'base16-eighties t)
;; (load-theme 'base16-eighties t)

;; additional customizations

(set-face-attribute 'vertical-border nil :foreground "#000000")

;; color-theme ;;

;; (color-theme-initialie)
;; (color-theme-euphoria)

;; projectile ;;

;; projectile requires this setting for ivy completion
(setq projectile-completion-system 'ivy)
;; useful for very large projects
(setq projectile-enable-caching t)

(setq projectile-require-project-root nil)

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

(setq projectile-globally-ignored-directories
      (append '(
        ".git"
        ".svn"
        "out"
        "repl"
        "project"
        "target"
        "venv") projectile-globally-ignored-directories))
(setq projectile-globally-ignored-files
      (append '(
        ".DS_Store"
        "TAGS"
        "*.gz"
        "*.pyc"
        "*.jar"
        "*.tar.gz"
        "*.tgz"
        "*.zip") projectile-globally-ignored-files))

;; use projectile everywhere
(projectile-mode)

;; flycheck ;;
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
(global-flycheck-mode 1)

;; yasnippet ;;

(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"
        "~/.emacs.d/yasnippet-snippets"))
(yas-global-mode 1)

;; rust ;;

(require 'rust-mode)

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)

(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)

(add-hook 'rust-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c <tab>") #'rust-format-buffer)))

(add-to-list 'auto-mode-alist '("\\.lalrpop\\'" . rust-mode))

;; ocaml, reason, merlin ;;

;; setup / init merlin
(let ((opam-share (ignore-errors (car (process-lines "opam" "config" "var" "share")))))
 (when (and opam-share (file-directory-p opam-share))
  ;; Register Merlin
  (add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share))
  (autoload 'merlin-mode "merlin" nil t nil)
  ;; Automatically start it in OCaml buffers
  (add-hook 'tuareg-mode-hook 'merlin-mode t)
  (add-hook 'caml-mode-hook 'merlin-mode t)
  ;; Use opam switch to lookup ocamlmerlin binary
  (setq merlin-command 'opam)))

(with-eval-after-load 'company
 (add-to-list 'company-backends 'merlin-company-backend))

;; setup / init tuareg
(load "~/.opam/system/share/emacs/site-lisp/tuareg-site-file")

;; haskell ;;

(require 'haskell-mode)

(add-hook 'haskell-mode-hook 'haskell-indent-mode)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(add-hook 'haskell-mode-hook 'haskell-doc-mode)

;; elixir, alchemist, alchemist-hex ;;

(setq alchemist-goto-elixir-source-dir "~/projects/github/elixir")
(setq alchemist-goto-erlang-source-dir "/usr/local/Cellar/erlang/19.2.3")

;; (add-to-list 'elixir-mode-hook (alchemist-mode +1))
(add-hook 'elixir-mode-hook 'alchemist-mode)
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

;; c, c++ ;;

(require 'cl)

;; running Make with the closest Makefile
(defun* get-closest-pathname (&optional (file "Makefile"))
  "Determine the pathname of the first instance of FILE starting from the current directory towards root.
This may not do the correct thing in presence of links. If it does not find FILE, then it shall return the name
of FILE in the current directory, suitable for creation"
  (let ((root (expand-file-name "/"))) ; the win32 builds should translate this correctly
    (expand-file-name file
          (loop
      for d = default-directory then (expand-file-name ".." d)
      if (file-exists-p (expand-file-name file d))
      return d
      if (equal d root)
      return nil))))

(require 'compile)
(add-hook 'c++-mode-hook
          (lambda () (set
                      (make-local-variable 'compile-command)
                      (format "make -f %s" (get-closest-pathname)))))

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(require 'company-irony-c-headers)
;; load with `irony-mode` as a grouped backend
(eval-after-load 'company
  '(add-to-list
    'company-backends '(company-irony-c-headers company-irony)))

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(add-hook 'irony-mode-hook #'irony-eldoc)

;; always use the latest & greatest
(add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard "c++17")))
(add-hook 'c++-mode-hook (lambda () (setq flycheck-clang-language-standard "c++17")))

(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

;; disassemble C/C++ code under cursor
;; TODO: https://github.com/jart/disaster/issues/13
;; (require 'disaster)
;; (define-key c-mode-base-map (kbd "C-c d") 'disaster)

;; javascript, json ;;

;; indent step is 2 spaces
(setq-default js2-basic-offset 2)

(add-to-list 'auto-mode-alist (cons (rx ".js" eos) 'js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))

(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))

;; enable minor mode for js refactoring
(add-hook 'js2-mode-hook #'js2-refactor-mode)
;; see: https://github.com/magnars/js2-refactor.el#refactorings
(js2r-add-keybindings-with-prefix "C-c C-j")

;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)

(defun my-web-mode-hook ()
  "Hook for `web-mode'."
    (set (make-local-variable 'company-backends)
         '(company-tern company-web-html company-yasnippet company-files)))

(add-hook 'web-mode-hook 'my-web-mode-hook)

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

;; typescript, tide ;;

(setq typescript-indent-level 2)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (setq flycheck-tslint-args . ("--type-check"))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (add-to-list 'compilation-error-regexp-alist
               '("ERROR in \\(.*\\)\n(\\([0-9]+\\),\\([0-9]+\\)):" 1 2 3))
  (company-mode +1))

(add-hook 'typescript-mode-hook #'setup-tide-mode)

;; enable tide for .tsx files
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
    (lambda ()
      (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))

;; company ;;
;; see http://company-mode.github.io/

(global-company-mode 1)
;; adjust this setting according to your typing speed
(setq company-idle-delay 0.4)
(setq company-minimum-prefix-length 1)
; (setq company-show-numbers t)
;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

(add-to-list 'company-backends 'company-tern)
;; (setq company-tern-meta-as-single-line t)
;; (setq company-tooltip-align-annotations t)

;; company interferes with Yasnippet’s native behaviour.
(defun check-expansion ()
  (save-excursion
        (if (looking-at "\\_>") t
        (backward-char 1)
        (if (looking-at "\\.") t
            (backward-char 1)
            (if (looking-at "->") t nil)))))

(defun do-yas-expand ()
    (let ((yas/fallback-behavior 'return-nil))
        (yas/expand)))

(defun tab-indent-or-complete ()
    (interactive)
    (if (minibufferp)
        (minibuffer-complete)
        (if (or (not yas/minor-mode)
                (null (do-yas-expand)))
            (if (check-expansion)
                (company-complete-common)
            (indent-for-tab-command)))))

(global-set-key [tab] 'tab-indent-or-complete)

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

;; multiple-cursors ;;

(require 'multiple-cursors)
;; multiple cursors key bindings
(global-set-key (kbd "C-M-n") 'mc/mark-next-like-this)
(global-set-key (kbd "C-M-p") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-M-m") 'mc/mark-all-like-this)
(global-set-key (kbd "C-M->") 'mc/skip-to-next-like-this)
(global-set-key (kbd "C-M-<") 'mc/skip-to-previous-like-this)

;; set initial window position
(when (window-system)
  (set-frame-position (selected-frame) 0 10)
  (set-frame-height (selected-frame) 80)
  (set-frame-width (selected-frame) 205))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#131513" "#e6193c" "#29a329" "#98981b" "#3d62f5" "#ad2bee" "#3d62f5" "#8ca68c"])
 '(ansi-term-color-vector
   [unspecified "#131513" "#e6193c" "#29a329" "#98981b" "#3d62f5" "#ad2bee" "#3d62f5" "#8ca68c"])
 '(custom-safe-themes
   (quote
    ("04790c9929eacf32d508b84d34e80ad2ee233f13f17767190531b8b350b9ef22" "f5f3a6fb685fe5e1587bafd07db3bf25a0655f3ddc579ed9d331b6b19827ea46" "9955cc54cc64d6c051616dce7050c1ba34efc2b0613d89a70a68328f34e22c8f" "542e6fee85eea8e47243a5647358c344111aa9c04510394720a3108803c8ddd1" "8578750fb94f908249a98dc14c3847d11863196f54de87a037b1374f2ae1f534" "3e34e9bf818cf6301fcabae2005bba8e61b1caba97d95509c8da78cff5f2ec8e" "0537901f4422f0d5f41ff43e51e39dc17d45d254fa36ce8d8d2786457759aef9" "cdd26fa6a8c6706c9009db659d2dffd7f4b0350f9cc94e5df657fa295fffec71" "38e64ea9b3a5e512ae9547063ee491c20bd717fe59d9c12219a0b1050b439cdd" "3de3f36a398d2c8a4796360bfce1fa515292e9f76b655bb9a377289a6a80a132" "7bef2d39bac784626f1635bd83693fae091f04ccac6b362e0405abf16a32230c" "907bacbe973888e44b057b32439bd51795d38034dceb71876958ffccc808a010" "0c3b1358ea01895e56d1c0193f72559449462e5952bded28c81a8e09b53f103f" "5b8eccff13d79fc9b26c544ee20e1b0c499587d6c4bfc38cabe34beaf2c2fc77" "8543b328ed10bc7c16a8a35c523699befac0de00753824d7e90148bca583f986" "ad16a1bf1fd86bfbedae4b32c269b19f8d20d416bd52a87cd50e355bf13c2f23" "fee4e306d9070a55dce4d8e9d92d28bd9efe92625d2ba9d4d654fc9cd8113b7f" "1263771faf6967879c3ab8b577c6c31020222ac6d3bac31f331a74275385a452" "ccde32eaf485eb7579412cd756d10b0f20f89bff07696972d7ee46cb2e10b89d" "88181ee5c706189948fa90e92cc84ff18b0007ce59fb878d626da8ba291c8943" "39dd7106e6387e0c45dfce8ed44351078f6acd29a345d8b22e7b8e54ac25bac4" "25c242b3c808f38b0389879b9cba325fb1fa81a0a5e61ac7cae8da9a32e2811b" "cab317d0125d7aab145bc7ee03a1e16804d5abdfa2aa8738198ac30dc5f7b569" "e8825f26af32403c5ad8bc983f8610a4a4786eb55e3a363fa9acb48e0677fe7e" "a85e40c7d2df4a5e993742929dfd903899b66a667547f740872797198778d7b5" "722e1cd0dad601ec6567c32520126e42a8031cd72e05d2221ff511b58545b108" "d9dab332207600e49400d798ed05f38372ec32132b3f7d2ba697e59088021555" "250268d5c0b4877cc2b7c439687f8145a2c85a48981f7070a72c7f47a2d2dc13" "d96587ec2c7bf278269b8ec2b800c7d9af9e22d816827639b332b0e613314dfd" "fec45178b55ad0258c5f68f61c9c8fd1a47d73b08fb7a51c15558d42c376083d" "36746ad57649893434c443567cb3831828df33232a7790d232df6f5908263692" "4605ce6e798971d215b01844ea39e993d683aa2fa118e02e263539298f9f3921" "52741e091463c2217af9327e2b2d74d0df861ecc3ad6131b6cbcb8d76b7a4d3d" "5228973368d5a1ac0cbea0564d0cd724937f52cc06a8fd81fc65a4fa72ff837b" "159aab698b9d3fb03b495ce3af2d298f4c6dfdf21b53c27cd7f472ee5a1a1de3" "8cf1002c7f805360115700144c0031b9cfa4d03edc6a0f38718cef7b7cabe382" "100eeb65d336e3d8f419c0f09170f9fd30f688849c5e60a801a1e6addd8216cb" "60e09d2e58343186a59d9ed52a9b13d822a174b33f20bdc1d4abb86e6b17f45b" "96998f6f11ef9f551b427b8853d947a7857ea5a578c75aa9c4e7c73fe04d10b4" "0c29db826418061b40564e3351194a3d4a125d182c6ee5178c237a7364f0ff12" "987b709680284a5858d5fe7e4e428463a20dfabe0a6f2a6146b3b8c7c529f08b" "e0d42a58c84161a0744ceab595370cbe290949968ab62273aed6212df0ea94b4" "3cd28471e80be3bd2657ca3f03fbb2884ab669662271794360866ab60b6cb6e6" "3cc2385c39257fed66238921602d8104d8fd6266ad88a006d0a4325336f5ee02" "e9776d12e4ccb722a2a732c6e80423331bcb93f02e089ba2a4b02e85de1cf00e" "b3775ba758e7d31f3bb849e7c9e48ff60929a792961a2d536edec8f68c671ca5" "9b59e147dbbde5e638ea1cde5ec0a358d5f269d27bd2b893a0947c4a867e14c1" "7997e0765add4bfcdecb5ac3ee7f64bbb03018fb1ac5597c64ccca8c88b1262f" "d9850d120be9d94dd7ae69053630e89af8767c36b131a3aa7b06f14007a24656" "85e6bb2425cbfeed2f2b367246ad11a62fb0f6d525c157038a0d0eaaabc1bfee" "c968804189e0fc963c641f5c9ad64bca431d41af2fb7e1d01a2a6666376f819c" "527df6ab42b54d2e5f4eec8b091bd79b2fa9a1da38f5addd297d1c91aa19b616" "78c1c89192e172436dbf892bd90562bc89e2cc3811b5f9506226e735a953a9c6" "5a7830712d709a4fc128a7998b7fa963f37e960fd2e8aa75c76f692b36e6cf3c" "6145e62774a589c074a31a05dfa5efdf8789cf869104e905956f0cbd7eda9d0e" "ffe80c88e3129b2cddadaaf78263a7f896d833a77c96349052ad5b7753c0c5a5" "cbd8e65d2452dfaed789f79c92d230aa8bdf413601b261dbb1291fb88605110c" "df21cdadd3f0648e3106338649d9fea510121807c907e2fd15565dde6409d6e9" "4bf5c18667c48f2979ead0f0bdaaa12c2b52014a6abaa38558a207a65caeb8ad" "eae831de756bb480240479794e85f1da0789c6f2f7746e5cc999370bbc8d9c8a" "50b64810ed1c36dfb72d74a61ae08e5869edc554102f20e078b21f84209c08d1" "f869a5d068a371532c82027cdf1feefdc5768757c78c48a7e0177e90651503ad" "986e7e8e428decd5df9e8548a3f3b42afc8176ce6171e69658ae083f3c06211c" "87d46d0ad89557c616d04bef34afd191234992c4eb955ff3c60c6aa3afc2e5cc" "ef04dd1e33f7cbd5aa3187981b18652b8d5ac9e680997b45dc5d00443e6a46e3" "8be07a2c1b3a7300860c7a65c0ad148be6d127671be04d3d2120f1ac541ac103" "aded4ec996e438a5e002439d58f09610b330bbc18f580c83ebaba026bbef6c82" "3380a2766cf0590d50d6366c5a91e976bdc3c413df963a0ab9952314b4577299" "cea3ec09c821b7eaf235882e6555c3ffa2fd23de92459751e18f26ad035d2142" "6271fc9740379f8e2722f1510d481c1df1fcc43e48fa6641a5c19e954c21cc8f" "50d07ab55e2b5322b2a8b13bc15ddf76d7f5985268833762c500a90e2a09e7aa" "4feee83c4fbbe8b827650d0f9af4ba7da903a5d117d849a3ccee88262805f40d" "6daa09c8c2c68de3ff1b83694115231faa7e650fdbb668bc76275f0f2ce2a437" "4a91a64af7ff1182ed04f7453bb5a4b0c3d82148d27db699df89a5f1d449e2a4" "12670281275ea7c1b42d0a548a584e23b9c4e1d2dabb747fd5e2d692bcd0d39b" "aea30125ef2e48831f46695418677b9d676c3babf43959c8e978c0ad672a7329" "93268bf5365f22c685550a3cbb8c687a1211e827edc76ce7be3c4bd764054bad" "73ad471d5ae9355a7fa28675014ae45a0589c14492f52c32a4e9b393fcc333fd" "9be1d34d961a40d94ef94d0d08a364c3d27201f3c98c9d38e36f10588469ea57" "b8929cff63ffc759e436b0f0575d15a8ad7658932f4b2c99415f3dde09b32e97" "2a998a3b66a0a6068bcb8b53cd3b519d230dd1527b07232e54c8b9d84061d48d" "16dd114a84d0aeccc5ad6fd64752a11ea2e841e3853234f19dc02a7b91f5d661" "dd4628d6c2d1f84ad7908c859797b24cc6239dfe7d71b3363ccdd2b88963f336" "9c4acf7b5801f25501f0db26ac3eee3dc263ed51afd01f9dcfda706a15234733" "85d609b07346d3220e7da1e0b87f66d11b2eeddad945cac775e80d2c1adb0066" "e1498b2416922aa561076edc5c9b0ad7b34d8ff849f335c13364c8f4276904f0" "5a39d2a29906ab273f7900a2ae843e9aa29ed5d205873e1199af4c9ec921aaab" "840db7f67ce92c39deb38f38fbc5a990b8f89b0f47b77b96d98e4bf400ee590a" "a62f0662e6aa7b05d0b4493a8e245ab31492765561b08192df61c9d1c7e1ddee" "ffac21ab88a0f4603969a24b96993bd73a13fe0989db7ed76d94c305891fad64" "45a8b89e995faa5c69aa79920acff5d7cb14978fbf140cdd53621b09d782edcf" "5f99055206ed6a1b9958f7dd5eaa9f884f8b5a8678bd0c5e2622aced5c4a1be7" "fc7fd2530b82a722ceb5b211f9e732d15ad41d5306c011253a0ba43aaf93dccc" "cabc32838ccceea97404f6fcb7ce791c6e38491fd19baa0fcfb336dcc5f6e23c" "1d079355c721b517fdc9891f0fda927fe3f87288f2e6cc3b8566655a64ca5453" "92192ea8f0bf04421f5b245d906701abaa7bb3b0d2b3b14fca2ee5ebb1da38d8" "760ce657e710a77bcf6df51d97e51aae2ee7db1fba21bbad07aab0fa0f42f834" "34ed3e2fa4a1cb2ce7400c7f1a6c8f12931d8021435bad841fdc1192bd1cc7da" "b3bcf1b12ef2a7606c7697d71b934ca0bdd495d52f901e73ce008c4c9825a3aa" "308eb04bfba22cd158a0927362d3a138653755eb7e82d626088df845c77b59c6" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "b51c2dda65e8e7e66ab1b06bc10b59e61c153b0cf928f296efab5a7574779fb6" "28ec8ccf6190f6a73812df9bc91df54ce1d6132f18b4c8fcc85d45298569eb53" "f9574c9ede3f64d57b3aa9b9cef621d54e2e503f4d75d8613cbcc4ca1c962c21" "db2ecce0600e3a5453532a89fc19b139664b4a3e7cbefce3aaf42b6d9b1d6214" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "b9e9ba5aeedcc5ba8be99f1cc9301f6679912910ff92fdf7980929c2fc83ab4d" "3ba81769ce9babc42d1e28e97c0909d48399df252ce76dbaf81f93f1879b5357" "715fdcd387af7e963abca6765bd7c2b37e76154e65401cd8d86104f22dd88404" "1e67765ecb4e53df20a96fb708a8601f6d7c8f02edb09d16c838e465ebe7f51b" "6c7db7fdf356cf6bde4236248b17b129624d397a8e662cf1264e41dab87a4a9a" "63dd8ce36f352b92dbf4f80e912ac68216c1d7cf6ae98195e287fd7c7f7cb189" "23ccf46b0d05ae80ee0661b91a083427a6c61e7a260227d37e36833d862ccffc" "01761172c43bd017296de3dcd9760e20aa1d39dd4f3822060815f9a3a21f8170" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default)))
 '(fci-rule-color "#F0F0F0")
 '(frame-brackground-mode (quote dark))
 '(hl-paren-colors
   (quote
    ("#B9F" "#B8D" "#B7B" "#B69" "#B57" "#B45" "#B33" "#B11")))
 '(ivy-count-format "(%d/%d) ")
 '(ivy-height 14)
 '(linum-format " %7i ")
 '(org-fontify-whole-heading-line t)
 '(package-selected-packages
   (quote
    (flx toml-mode erlang flycheck-dialyxir flycheck-dialyzer go-mode yaml-mode flycheck-clojure clojure-mode d-mode flycheck-flow flycheck-purescript purescript-mode dockerfile-mode ggtags google-translate haskell-mode rainbow-mode rtags quelpa package-build merlin irony-eldoc company-irony-c-headers disaster flycheck-irony company-irony irony flycheck-rust racer rust-mode company-web company-tern all-the-icons neotree solidity-mode json-mode js2-refactor js2-mode exec-path-from-shell heroku-theme gruber-darker-theme gotham-theme farmhouse-theme phoenix-dark-pink-theme cyberpunk-theme calmer-forest-theme sublime-themes base16-theme kooten-theme afternoon-theme abyss-theme arjen-grey-theme danneskjold-theme paganini-theme hamburg-theme default-text-scale flycheck-elixir idle-highlight-mode rainbow-delimiters highlight-indentation dired+ smart-mode-line darkroom writeroom-mode evil-anzu ace-window yoshi-theme monochrome-theme quasi-monochrome-theme ivy-hydra counsel-projectile counsel ivy idris-mode projectile-ripgrep ripgrep multiple-cursors emmet-mode evil-org alchemist evil-magit magit web-mode tide projectile evil eldoc-overlay-mode company color-theme)))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#d54e53")
     (40 . "goldenrod")
     (60 . "#e7c547")
     (80 . "DarkOliveGreen3")
     (100 . "#70c0b1")
     (120 . "DeepSkyBlue1")
     (140 . "#c397d8")
     (160 . "#d54e53")
     (180 . "goldenrod")
     (200 . "#e7c547")
     (220 . "DarkOliveGreen3")
     (240 . "#70c0b1")
     (260 . "DeepSkyBlue1")
     (280 . "#c397d8")
     (300 . "#d54e53")
     (320 . "goldenrod")
     (340 . "#e7c547")
     (360 . "DarkOliveGreen3"))))
 '(vc-annotate-very-old-color "#161616")
 '(when
      (or
       (not
        (boundp
         (quote ansi-term-color-vector)))
       (not
        (facep
         (aref ansi-term-color-vector 0)))))
 '(whitespace-style
   (quote
    (face tabs spaces trailing space-before-tab newline indentation empty space-after-tab space-mark tab-mark)))
 '(window-divider-default-right-width 1)
 '(window-divider-mode t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(whitespace-line ((t (:background "gray6" :foreground "gray15"))))
 '(whitespace-space ((t (:background "gray6" :foreground "gray15"))))
 '(whitespace-tab ((t (:background "gray6" :foreground "gray15")))))
