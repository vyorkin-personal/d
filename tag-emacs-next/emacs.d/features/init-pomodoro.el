(require 'init-general)

(use-package pomidor
  :requires init-general
  :after general
  ;; :init
  ;; (setq
   ;; pomidor-sound-overwork nil
   ;; pomidor-sound-tick nil
   ;; pomidor-sound-tack nil)
  :config
  (nmap
    :prefix rc/leader
    "G" #'pomidor))

(provide 'init-pomodoro)
