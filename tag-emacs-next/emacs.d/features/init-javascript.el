(require 'init-osx)
(require 'init-company)

(use-package tern
  :ensure-system-package (tern . "npm i -g tern")
  :commands tern-mode
  :config
  ;; enable js completion between <script>...</script> etc
  (defadvice company-tern (before web-mode-set-up-ac-sources activate)
    "Set `tern-mode' based on current language before running company-tern."
    (message "advice")
    (if (equal major-mode 'web-mode)
        (let ((web-mode-cur-language (web-mode-language-at-pos)))
            (if (or (string= web-mode-cur-language "javascript")
                    (string= web-mode-cur-language "jsx"))
                (unless tern-mode (tern-mode))
            (if tern-mode (tern-mode -1)))))))

(use-package npm-mode
  :commands (npm-mode npm-global-mode)
  :config
  (npm-global-mode)
  :diminish npm-mode)

(use-package js2-mode
  :requires (init-osx)
  :after dash-at-point
  :init
  ;; indent step is 2 spaces
  (setq-default js2-basic-offset 2)
  (setq-default js-indent-level 2)
  (setq
   ;; configure indentation
   js2-enter-indents-newline t
   js2-auto-indent-p t
   ;; Idle timeout before reparsing buffer
   js2-idle-timer-delay 0.5
   ;; disable error parsing in favor of Flycheck
   js2-strict-missing-semi-warning nil)
  :commands js2-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (add-to-list 'dash-at-point-mode-alist '(js2-mode . "js"))
  :delight "js2")

(use-package xref-js2
  :preface
  (defun rc/xref-js2/add-backend ()
    (add-hook 'xref-backend-functions
              'xref-js2-xref-backend nil t))
  :config
  (unbind-key "M-." js2-mode-map)
  (add-hook 'js2-mode-hook 'rc/xref-js2/add-backend))

(use-package js2-refactor
  :config
  ;; enable minor mode for js refactoring
  ;; see: https://github.com/magnars/js2-refactor.el#refactorings
  (js2r-add-keybindings-with-prefix "C-c C-j")
  (add-hook 'js2-mode-hook 'js2-refactor-mode))

(use-package rjsx-mode
  :commands rjsx-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.jsx\\'" . rjsx-mode)))

(use-package prettier-js
  :preface
  (defvar rc/prettier-js/modes
    '(js2-mode-hook
      web-mode-hook))
  :config
  (dolist (mode rc/prettier-js/modes)
    (add-hook mode 'prettier-js-mode))
  :delight "pr")

(use-package company-tern
  :requires init-company
  :after (company tern)
  :demand t
  :config
  (add-to-list 'company-backends 'company-tern))

(provide 'init-javascript)
