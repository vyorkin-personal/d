(require 'init-osx)
(require 'init-appearance)

(use-package nginx-mode
  :config
  (add-to-list 'dash-at-point-mode-alist '(nginx-mode . "nginx")))

(use-package yaml-mode
  :config
  (add-to-list 'dash-at-point-mode-alist '(yaml-mode . "yaml"))
  :delight "yaml")

(use-package d-mode
  :config
  (add-to-list 'dash-at-point-mode-alist '(d-mode . "d")))

(use-package toml-mode
  :config
  (add-to-list 'dash-at-point-mode-alist '(toml-mode . "toml"))
  )

(use-package kotlin-mode
  :config
  (add-to-list 'dash-at-point-mode-alist '(kotlin-mode . "kot"))
  )

(use-package glsl-mode
  :config
  (add-to-list 'dash-at-point-mode-alist '(glsl-mode . "glsl")))

(use-package jade-mode
  :config
  (add-to-list 'dash-at-point-mode-alist '(jade-mode . "jade")))

(use-package haml-mode
  :config
  (add-to-list 'dash-at-point-mode-alist '(haml-mode . "haml")))

(use-package scss-mode
  :config
  (add-to-list 'dash-at-point-mode-alist '(scss-mode . "scss"))
  :delight "scss")

(use-package lua-mode
  :config
  (add-to-list 'dash-at-point-mode-alist '(lua-mode . "lua")))

(provide 'init-langs)
