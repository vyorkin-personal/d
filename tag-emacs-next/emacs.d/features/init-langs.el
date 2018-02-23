(require 'init-osx)
(require 'init-appearance)

(use-package nginx-mode
  :requires (init-osx)
  :after dash-at-point
  :config
  (add-to-list 'dash-at-point-mode-alist '(nginx-mode . "nginx")))

(use-package d-mode
  :requires (init-osx)
  :after dash-at-point
  :config
  (add-to-list 'dash-at-point-mode-alist '(d-mode . "d")))

(use-package toml-mode
  :requires (init-osx)
  :after dash-at-point
  :config
  (add-to-list 'dash-at-point-mode-alist '(toml-mode . "toml")))

(use-package nix-mode)

(use-package ansible)

(use-package arduino-mode)

(use-package bison-mode)

(use-package editorconfig
  :config
  (editorconfig-mode 1))

(use-package peg)

(use-package glsl-mode
  :requires (init-osx)
  :after dash-at-point
  :config
  (add-to-list 'dash-at-point-mode-alist '(glsl-mode . "glsl")))

(use-package pug-mode
  :requires (init-osx)
  :after dash-at-point
  :config
  (add-to-list 'dash-at-point-mode-alist '(pug-mode . "pug")))

(use-package jade-mode
  :requires (init-osx)
  :after dash-at-point
  :config
  (add-to-list 'dash-at-point-mode-alist '(jade-mode . "jade")))

(use-package haml-mode
  :requires (init-osx)
  :after dash-at-point
  :config
  (add-to-list 'dash-at-point-mode-alist '(haml-mode . "haml")))

(use-package lua-mode
  :requires (init-osx)
  :after dash-at-point
  :if (executable-find "lua")
  :mode "\\.lua\\'"
  :init
  (setq lua-indent-level 2)
  :config
  (add-to-list 'dash-at-point-mode-alist '(lua-mode . "lua"))
  (use-package lua-block
    :requires lua-mode init-quelpa
    :quelpa
    (lua-block
     :fetcher url
     :url "http://www.emacswiki.org/emacs/download/lua-block.el")
    :init
    (autoload 'lua-block-mode "lua-block" nil t)))

(use-package dotenv-mode
  :requires (init-osx)
  :after dash-at-point
  :config
  (add-to-list 'auto-mode-alist '("\\.env\\..*\\'" . dotenv-mode)))

(use-package csv-mode
  :mode "\\.[Cc][Ss][Vv]$"
  :init
  (setq
   ;; default separators for CSV files.
   csv-separators '("," ";" "|" " " "\t")
   ;; number of lines to consider part of header.
   csv-header-lines 1))

(use-package nasm-mode)
(use-package iasm-mode)

(provide 'init-langs)
