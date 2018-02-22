(require 'init-general)

(use-package flyspell
  :after general
  :config
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
