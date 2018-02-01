(use-package delight
  :config
  (delight '((emacs-lisp-mode "[elisp]" :major)
             (elixir-mode "[ex]" elixir)
             (alchemist-mode "[al]" alchemist)
             (alchemist-hex-mode "[alhex]" alchemist)
             (alchemist-test-mode "[altest]" alchemist)
             (rust-mode "[rs]" rust)
             (purescript-mode "[purs]" purescript)
             (javascript-mode "[js]" js)
             (eldoc-mode "[eldoc]" eldoc)
             (auto-revert-mode "[ar]" autorevert)
             (hi-lock-mode "[hi]" hi-lock))))

(use-package diminish
  :config
  (eval-after-load "purescript-indentation" '(diminish 'purescript-indentation-mode))
  (eval-after-load "simple" '(diminish 'overwrite-mode))
  (eval-after-load "dired" '(diminish 'dired-omit-mode))
  (eval-after-load "hideshow" '(diminish 'hs-minor-mode))
  (eval-after-load "autorevert" '(diminish 'auto-revert-mode))
  (eval-after-load "eldoc" '(diminish 'eldoc-mode)))
