(use-package whitespace
  :disabled
  :init
  (setq whitespace-style '(face spaces tabs newline space-mark tab-mark))
  (setq whitespace-display-mappings
        '((space-mark 32 [183] [46])
          (newline-mark 10 [182 10])
          (tab-mark 9 [9655 9] [92 9])))
  :preface
  (defvar rc/whitespace/modes
    '(tuareg-mode-hook
      c++-mode-hook
      emacs-lisp-mode-hook
      java-mode-hook
      lua-mode-hook
      rust-mode-hook
      scala-mode-hook
      markdown-mode-hook
      web-mode-hook
      j2-mode-hook
      typescript-mode-hook
      reason-mode-hook
      elixir-mode-hook
      idris-mode-hook
      haskell-mode-hook))
  (defvar rc/whitespace/prev-mode nil)
  (defun rc/whitespace/setup ()
    ;; comment out if you don't want
    ;; hidden chars to be visible by default
    (whitespace-mode 1)
    (add-to-list 'write-file-functions 'delete-trailing-whitespace))
  (make-variable-buffer-local 'rc/whitespace/prev-mode)
  (defun rc/whitespace/pre-popup-draw ()
    "Turn off whitespace mode before showing company complete tooltip"
    (if whitespace-mode
        (progn
          (setq rc/whitespace/prev-mode t)
          (whitespace-mode -1)
          (setq rc/whitespace/prev-mode t))))
  (defun rc/whitespace/post-popup-draw ()
    "Restore previous whitespace mode after showing company tooltip"
    (if rc/whitespace/prev-mode
        (progn
          (whitespace-mode 1)
          (setq rc/whitespace/prev-mode nil))))
  :commands whitespace-mode
  :config
  (dolist (mode rc/whitespace/modes)
    (add-hook mode 'rc/whitespace/setup))
  ;; disable whitespace while popup is displayed
  ;; see: https://github.com/company-mode/company-mode/pull/245#issuecomment-232943098
  (advice-add 'company-pseudo-tooltip-unhide :before 'rc/whitespace/pre-popup-draw)
  (advice-add 'company-pseudo-tooltip-hide :after 'rc/whitespace/post-popup-draw)
  ;; (general-define-key
  ;;  :prefix "SPC"
  ;;  "W" 'whitespace-mode)
  :diminish whitespace-mode)
