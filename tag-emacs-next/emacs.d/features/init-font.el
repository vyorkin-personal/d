(use-package faces
  :ensure nil
  :init
  (let ((preferred-font-families
         '("Fira Code"
           "Consolas"
           "Monospace"
           "DejaVu Sans Mono"
           "Monaco"
           "Hack")))
    (add-to-list 'face-font-family-alternatives preferred-font-families)
    (internal-set-alternative-font-family-alist face-font-family-alternatives)
    (set-face-attribute
     'default nil
     :family (car preferred-font-families)
     :weight 'regular
     :height 170
     :width 'semi-condensed)
    (set-fontset-font
     "fontset-default"
     'cyrillic
     (font-spec :registry "iso10646-1" :script 'cyrillic))))

(provide 'init-font)
