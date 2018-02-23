(use-package emmet-mode
  :after sgml-mode
  :preface
  (defvar rc/emmet/modes
    '(sgml-mode-hook
      css-mode-hook
      jade-mode-hook))
  :commands emmet-mode
  :init
  (setq
   emmet-move-cursor-between-quotes t
   emmet-self-closing-tag-style "")
  :config
  (dolist (mode rc/emmet/modes)
    (add-hook mode 'emmet-mode))
  :delight "emmet")
