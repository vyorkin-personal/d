(require 'init-general)

(use-package pomidor
  :init
  (setq
;; pomidor-sound-overwork nil
   pomidor-sound-tick nil
   pomidor-sound-tack nil)
  :config
  (nmap
    :prefix rc/leader
    "g" #'pomidor))

(provide 'init-pomodoro)
