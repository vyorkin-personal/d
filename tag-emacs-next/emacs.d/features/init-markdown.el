(require 'init-osx)
(require 'init-appearance)
(require 'init-general)

(use-package markdown-mode
  :disabled
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown")
  :config
  (add-to-list 'dash-at-point-mode-alist '(markdown-mode . "md"))
  :delight "md")

(use-package markdown-mode+
  :after markdown-mode)

(use-package markdown-toc
  ;; issue: https://github.com/ardumont/markdown-toc/issues/40
  :disabled
  :after markdown-mode)

(use-package gh-md
  :after markdown-mode
  :config
  (nmap 'markdown-mode
    :prefix rc/leader
    "r" 'gh-md-render-region
    "b" 'gh-md-render-buffer))

(provide 'init-markdown)
