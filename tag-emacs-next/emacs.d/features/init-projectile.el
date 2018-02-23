(require 'init-general)
(require 'init-navigation)

(use-package projectile
  :requires (init-general init-navigation)
  :after (general ivy)
  :preface
  (defconst rc/projectile/ignored-dirs
    '(".git" ".svn" ".hg" "_darcs"
      "out" "output" "repl" "dist" ".vagrant"
      "project" "target" "compiled" ".bundle"
      "project/target" "build" "jar"
      "venv" ".virtualenv"
      "*__pycache__*" "*.egg-info"
      ".tox" ".cache" ".cabal-sandbox" ".stack-work"
      ".emacs.d" "elpa" "site-lisp"
      "bin" "eclipse-bin" ".ensime_cache" ".idea"
      ".eunit" ".bzr"
      "vendor" "uploads" "assets"
      "node_modules" "bower_components"
      ".psci_modules" ".purs-repl" ".pulp-cache")
    "Ignored dirs")
  (defconst rc/projectile/ignored-files
    '(".DS_Store" "TAGS" ".nrepl-port" "*.gz" "*.pyc"
      "*.jar" "*.tar.gz" "*.tgz" "*.zip" "package-lock.json")
    "Ignored files")
  :init
  ;; projectile requires this setting for ivy completion
  (setq
   projectile-indexing-method 'alien
   projectile-completion-system 'ivy
   ;; useful for very large projects
   projectile-enable-caching t
   projectile-file-exists-remote-cache-expire (* 10 60)
   projectile-file-exists-local-cache-expire (* 5 60)
   projectile-require-project-root nil
   projectile-globally-ignored-directories rc/projectile/ignored-dirs
   projectile-globally-ignored-files rc/projectile/ignored-files)
  :config
  ;; use projectile everywhere
  (projectile-mode)
  ;; remove the mode name for projectile-mode, but show the project name
  ;; :delight '(:eval (concat " " (projectile-project-name)))
  :diminish projectile-mode)

(provide 'init-projectile)
