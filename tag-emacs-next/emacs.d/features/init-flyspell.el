(require 'init-general)

(use-package flyspell
  :requires init-general
  :after general
  :init
  (setq
   flyspell-use-meta-tab nil
   flyspell-mode-line-string ""
   flyspell-auto-correct-binding (kbd ""))
  :config
  ;; for programming modes, enable flyspell-prog-mode for
  ;; spell checking in comments and strings
  (add-hook 'text-mode-hook 'flyspell-prog-mode)
  (nmap
    "C-c i b" 'flyspell-buffer
    "C-c i f" 'flyspell-mode)
  (use-package ispell
    :config
    (unbind-key "C-." flyspell-mode-map)
    (nmap
      "C-c i c" 'ispell-comments-and-strings
      "C-c i d" 'ispell-change-dictionary
      "C-c i k" 'ispell-kill-ispell
      "C-c i m" 'ispell-message
      "C-c i r" 'ispell-region)))

(provide 'init-flyspell)
