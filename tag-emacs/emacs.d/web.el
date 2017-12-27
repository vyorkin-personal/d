(use-package web-mode
  :after (flycheck company)
  :preface
  (defvar rc/web-mode/extensions
    '("\\.tsx\\'"
      "\\.jsx\\'"))
  (defun rc/web-mode-hook ()
    "Hook for web-mode"
    (set (make-local-variable 'company-backends)
         '(company-tern
           company-web-html
           company-yasnippet
           company-files)))
  :commands web-mode
  :config
  ;; use eslint with web-mode for jsx files
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  (add-hook 'web-mode-hook 'rc/web-mode-hook)
  (dolist (ext rc/web-mode/extensions)
    (add-to-list 'auto-mode-alist `(,ext . web-mode))))
