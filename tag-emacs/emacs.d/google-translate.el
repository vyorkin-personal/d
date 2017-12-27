(use-package google-translate
  :init
  (setq google-translate-default-source-language "en")
  (setq google-translate-default-target-language "ru")
  :config
  (paradox-require 'google-translate-default-ui)
  :bind
  (("C-c C-t" . google-translate-at-point)
   ("C-c C-q" . google-translate-query-translate)))
