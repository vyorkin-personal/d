(require 'init-general)
(require 'init-quelpa)

(use-package pomidor
  :requires (init-quelpa init-general)
  :after general
  :quelpa
  (pomidor
   :fetcher github
   :repo "TatriX/pomidor"
   :branch "sound")
  :init
  (setq pomidor-play-sound-file
        (lambda (file)
          (start-process "my-pomidor-play-sound"
                         nil
                         "mplayer"
                         file)))
  ;; (setq
  ;;  pomidor-sound-overwork nil
  ;;  pomidor-sound-tick nil
  ;;  pomidor-sound-tack nil)
  :config
  (nmap
    :prefix rc/leader
    "G" #'pomidor))

(provide 'init-pomodoro)
