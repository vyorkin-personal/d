(require 'init-general)
(require 'init-flycheck)

(use-package erlang
  :config
  (add-to-list 'dash-at-point-mode-alist '(erlang-mode . "erl")))

(use-package flycheck-dialyzer)

(provide 'init-erlang)
