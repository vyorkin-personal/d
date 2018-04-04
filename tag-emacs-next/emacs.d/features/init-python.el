(require 'init-osx)
(require 'init-general)
(require 'init-lsp)

(use-package python-mode
  :preface
  (defun rc/python-mode/setup ()
    (mapc (lambda (pair) (push pair prettify-symbols-alist))
          '(("def" . "𝒇")
            ("class" . "𝑪")
            ("and" . "∧")
            ("or" . "∨")
            ("not" . "￢")
            ("in" . "∈")
            ("not in" . "∉")
            ("return" . "⟼")
            ("yield" . "⟻")
            ("for" . "∀")
            ("!=" . "≠")
            ("==" . "＝")
            (">=" . "≥")
            ("<=" . "≤")
            ("[]" . "⃞")
            ("=" . "≝"))))
  :config
  (add-hook 'python-mode-hook #'rc/python-mode/setup))

(use-package lsp-python
  :after python-mode)

(provide 'init-python)
