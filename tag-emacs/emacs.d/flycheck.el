(use-package flycheck
  :defer t
  :init
  (setq-default
   flycheck-disabled-checkers
   '(emacs-lisp-checkdoc javascript-jshint))
  (setq
   flycheck-mode-line-prefix "fly"
   flycheck-javascript-eslint-executable "eslint_d")
  (use-package flycheck-rust)
  (use-package flycheck-clojure)
  (use-package flycheck-irony)

  ;; should be superseeded by psc-ide-mode's flycheck integration
  ;; https://github.com/dysinger/purescript-mode/pull/8
  (use-package flycheck-purescript
    :disabled
    :preface
    (defun rc/flycheck-purescript/setup ()
      (setq default-directory (locate-dominating-file default-directory "node_modules")))
    :after purescript-mode
    :init
    (eval-after-load 'flycheck
      '(add-hook 'flycheck-mode-hook 'flycheck-purescript-setup))
    :config
    (add-hook 'purescript-mode-hook 'rc/flycheck-purescript/setup))

  (use-package flycheck-flow)
  (use-package flycheck-elixir)
  (use-package flycheck-mix
    :config
    (flycheck-mix-setup))
  (use-package flycheck-dialyzer) ;; for erlang
  (use-package flycheck-dialyxir) ;; for elixir
  (use-package flycheck-color-mode-line
    ;; seems to work only with powerline,
    ;; not with telephone-line that I currently use
    :disabled
    :config
    (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))
  :config
  ;; make the error list display like similar lists in contemporary IDEs
  ;; like VisualStudio, Eclipse, etc.
  (add-to-list
   'display-buffer-alist
   `(,(rx bos "*Flycheck errors*" eos)
     (display-buffer-reuse-window display-buffer-in-side-window)
     (side . bottom)
     (reusable-frames . visible)
     (window-height . 0.33)))
  (global-flycheck-mode 1)
  :bind
  (([f10] . flycheck-list-errors)))

;; flycheck-error-list-goto-error

(setq flyspell-use-meta-tab nil
      flyspell-mode-line-string ""
      flyspell-auto-correct-binding (kbd ""))

;; for programming modes, enable flyspell-prog-mode for
;; spell checking in comments and strings.
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

(use-package flyspell-correct-ivy
  :demand t
  :config
  (setq flyspell-correct-interface 'flyspell-correct-ivy)
  :bind
  (:map flyspell-mode-map
        ("C-;" . flyspell-correct-previous-word-generic)))
