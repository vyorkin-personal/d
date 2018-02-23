(require 'init-general)
(require 'init-navigation)

(use-package projectile
  :requires (init-general init-navigation)
  :after (general ivy)
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
  :diminish projectile-mode)

(provide 'init-projectile)
