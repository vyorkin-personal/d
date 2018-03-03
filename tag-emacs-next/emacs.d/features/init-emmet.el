(require 'init-general)

(use-package emmet-mode
  :requires init-general
  :after (general sgml-mode)
  :preface
  (defvar rc/emmet/modes
    '(sgml-mode-hook
      css-mode-hook
      jade-mode-hook))
  :commands emmet-mode
  :config
  (dolist (mode rc/emmet/modes)
    (add-hook mode 'emmet-mode))
  (imap
    "C-x C-o" 'emmet-expand-line)
  :delight "emmet")

(provide 'init-emmet)
