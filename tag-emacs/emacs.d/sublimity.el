(use-package sublimity
  :defer t
  :init
  (setq
    sublimity-scroll-weight 12
    sublimity-scroll-drift-length 0.5
    sublimity-map-size 20
    sublimity-map-fraction 0.3
    sublimity-map-text-scale -10)
  :config
  (paradox-require 'sublimity-scroll)
  (paradox-require 'sublimity-map) ;; experimental
  (paradox-require 'sublimity-attractive)
  (sublimity-map-set-delay 1))
