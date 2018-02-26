(require 'init-general)
(require 'init-company)
(require 'init-flycheck)
(require 'init-org)

(use-package clojure-mode :ensure t
  :requires (init-general init-company init-org)
  :after (general company org)
  :mode (("\\.clj\\'" . clojure-mode)
         ("\\.edn\\'" . clojure-mode)
         ("\\.boot\\'" . clojure-mode)
         ("\\.cljs.*\\'" . clojure-mode))
  :init
  (setq inferior-lisp-program "lein repl")
  :config
  (add-to-list 'org-babel-load-languages '(clojure . t))
  (nmap 'clojure-mode-map
    :prefix rc/leader
    "c s" 'cider-start-http-server
    "c r" 'cider-refresh
    "c u" 'cider-user-ns)
  (use-package clojure-mode-extra-font-locking
    :init
    (font-lock-add-keywords
     nil
     '(("(\\(facts?\\)"
        (1 font-lock-keyword-face))
       ("(\\(background?\\)"
        (1 font-lock-keyword-face)))))
  (define-clojure-indent (fact 1))
  (define-clojure-indent (facts 1)))

(use-package cider
  :after clojure-mode
  :commands cider-mode
  :init
  (setq
   ;; go right to the REPL buffer when it's finished connecting
   cider-repl-pop-to-buffer-on-connect t
   ;; when there's a cider error, show its buffer and switch to it
   cider-show-error-buffer t
   cider-auto-select-error-buffer t
   cider-repl-history-file "~/.emacs.d/cider-history"
   cider-repl-wrap-history t)
  :config
  (add-hook 'cider-mode #'clojure-mode-hook)
  (add-hook 'eldoc-mode #'cider-mode-hook))

(use-package flycheck-clojure
  :requires init-flycheck
  :after (flycheck clojure-mode))

(use-package 4clojure)

(provide 'init-clojure)
