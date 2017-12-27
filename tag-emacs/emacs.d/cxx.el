;; setup / init tuareg
;; (load "~/.opam/system/share/emacs/site-lisp/tuareg-site-file")

;; c, c++ ;;

(use-package compile
  :preface
  (paradox-require 'cl)
  (defun rc/compile/closest-pathname (&optional (file "Makefile"))
    "Determine the pathname of the first instance of FILE starting from the current directory towards root.
    This may not do the correct thing in presence of links. If it does not find FILE, then it shall return the name
    of FILE in the current directory, suitable for creation"
    (let ((root (expand-file-name "/"))) ;; the win32 builds should translate this correctly
      (expand-file-name
       file
       (loop
        for d = default-directory then (expand-file-name ".." d)
        if (file-exists-p (expand-file-name file d))
        return d
        if (equal d root)
        return nil))))
  ;; need for running Make with the closest Makefile
  (defun rc/compile/setup-make ()
    (set
     (make-local-variable 'compile-command)
     (format "make -f %s" (rc/compile/closest-pathname))))
  :config
  (add-hook 'c++-mode-hook 'rc/compile/setup-make))

;; always use the latest & greatest
(add-hook
 'c++-mode-hook
 (lambda () (setq
        flycheck-gcc-language-standard "c++17"
        flycheck-clang-language-standard "c++17")))

(with-eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook 'flycheck-irony-setup))

(use-package irony
  :defer t
  :preface
  (defvar rc/irony/modes
    '(c++-mode-hook
      c-mode-hook
      objc-mode-hook))
  :commands irony-mode
  :config
  (use-package irony-eldoc
    :config
    (add-hook 'irony-mode-hook 'irony-eldoc))
  (dolist (mode rc/irony/modes)
    (add-hook mode 'irony-mode))
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

;; disassemble C/C++ code under cursor
(use-package disaster
  ;; here is why: https://github.com/jart/disaster/issues/13
  :disabled
  :config
  :bind
  (:map c-mode-base-map
        ("C-c d") 'disaster))
