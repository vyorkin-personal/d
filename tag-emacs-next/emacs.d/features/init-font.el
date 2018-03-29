(use-package faces
  :ensure nil
  :custom
  (face-font-family-alternatives
   '(("Fira Code" "Consolas" "Monaco" "Monospace")))
  :init
  (set-face-attribute
   'default nil
   :family (caar face-font-family-alternatives)
   :weight 'regular
   :height 170
   :width 'semi-condensed)
  (set-fontset-font
   "fontset-default"
   'cyrillic
   (font-spec :registry "iso10646-1" :script 'cyrillic)))

(provide 'init-font)
