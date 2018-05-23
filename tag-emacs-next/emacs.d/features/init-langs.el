(require 'init-appearance)

(use-package nginx-mode)

(use-package d-mode)

(use-package toml-mode)

(use-package ansible)

(use-package arduino-mode)

(use-package bison-mode)

(use-package toml-mode)

(use-package editorconfig
  :config
  (editorconfig-mode 1))

(use-package peg)

(use-package glsl-mode)

(use-package pug-mode)

(use-package jade-mode)

(use-package haml-mode)

(use-package lua-mode
  :if (executable-find "lua")
  :mode "\\.lua\\'"
  :init
  (setq lua-indent-level 2)
  :config
  (use-package lua-block
    :requires lua-mode init-quelpa
    :quelpa
    (lua-block
     :fetcher url
     :url "http://www.emacswiki.org/emacs/download/lua-block.el")
    :init
    (autoload 'lua-block-mode "lua-block" nil t)))

(use-package dotenv-mode
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
