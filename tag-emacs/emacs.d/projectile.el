(require 'init-general)

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
  ;; :delight '(:eval (concat " " (projectile-project-name)))
  (general-define-key
   :keymaps 'normal
   :prefix rc/leader
   "c" 'projectile-invalidate-cache)
  :diminish projectile-mode)

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
