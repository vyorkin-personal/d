(require 'init-general)

(use-package yasnippet
  :requires init-general
  :defer 1.2
  :init
  (setq
   yas-wrap-around-region t
   yas-indent-line t
   yas-snippet-dirs '("~/.emacs.d/yasnippet-snippets/snippets"))
  :config
  (yas-global-mode 1)
  :diminish yas-minor-mode)

;; I use my fork of yasnippet-snippets instead

;; (use-package aws-yasnippets :after yasnippet)
;; (use-package clojure-snippets :after yasnippet)
;; (use-package common-lisp-snippets :after yasnippet)
;; (use-package elixir-yasnippets :after yasnippet)
;; (use-package elm-yasnippets :after yasnippet)
;; (use-package go-snippets :after yasnippet)
;; (use-package haskell-snippets :after yasnippet)
;; (use-package java-snippets :after yasnippet)
;; (use-package pony-snippets :after yasnippet)
;; (use-package react-snippets :after yasnippet)

(provide 'init-yasnippet)
