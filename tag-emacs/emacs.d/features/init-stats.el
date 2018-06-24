(require 'init-system)

(use-package wakatime-mode
  :requires init-system
  :init
  (setq
   wakatime-api-key (getenv "WAKATIME_API_KEY")
   wakatime-cli-path "/usr/local/bin/wakatime")
  :config
  (global-wakatime-mode)
  :diminish wakatime-mode)

(provide 'init-stats)
