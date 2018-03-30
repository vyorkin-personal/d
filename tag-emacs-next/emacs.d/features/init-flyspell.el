(require 'init-general)

(use-package ispell
  :ensure nil
  :custom
  (ispell-local-dictionary-alist
   '(("russian"
      "[АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЫЪЭЮЯабвгдеёжзийклмнопрстуфхцчшщьыъэюя’A-Za-z]"
      "[^АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЫЪЭЮЯабвгдеёжзийклмнопрстуфхцчшщьыъэюя’A-Za-z]"
      "[-']" nil ("-d" "ru_RU,en_US") nil utf-8)))
  ;; (ispell-program-name "hunspell")
  (ispell-dictionary "russian")
  (ispell-really-aspell nil)
  (ispell-really-hunspell t)
  (ispell-encoding8-command t)
  (ispell-silently-savep t)
  :config
  (nmap
    "C-c i c" 'ispell-comments-and-strings
    "C-c i d" 'ispell-change-dictionary
    "C-c i k" 'ispell-kill-ispell
    "C-c i m" 'ispell-message
    "C-c i r" 'ispell-region))

(use-package flyspell
  :ensure nil
  :requires init-general
  :after (general ispell)
  :custom
  (flyspell-delay 1)
  :init
  (setq
   flyspell-use-meta-tab nil
   flyspell-mode-line-string ""
   flyspell-auto-correct-binding (kbd ""))
  :config
  ;; for programming modes, enable flyspell-prog-mode for
  ;; spell checking in comments and strings
  (add-hook 'text-mode-hook 'flyspell-prog-mode)
  (unbind-key "C-." flyspell-mode-map)
  (nmap
    "C-c i b" 'flyspell-buffer
    "C-c i f" 'flyspell-mode))

(provide 'init-flyspell)
