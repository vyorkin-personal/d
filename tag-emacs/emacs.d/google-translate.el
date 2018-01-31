(use-package google-translate
  :init
  (setq google-translate-default-source-language "en")
  (setq google-translate-default-target-language "ru")
  :config
  (paradox-require 'google-translate-default-ui)
  :bind
  (("C-c t" . google-translate-at-point)
   ("C-c q" . google-translate-query-translate)))
