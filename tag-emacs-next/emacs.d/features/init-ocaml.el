(require 'init-osx)
(require 'init-company)
(require 'init-flycheck)

(load "~/.opam/4.02.3/share/emacs/site-lisp/tuareg-site-file")

;; setup / init merlin
(let ((opam-share (ignore-errors (car (process-lines "opam" "config" "var" "share")))))
 (when (and opam-share (file-directory-p opam-share))
  ;; register Merlin
  (add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share))
  (autoload 'merlin-mode "merlin" nil t nil)
  ;; automatically start it in OCaml buffers
  (add-hook 'tuareg-mode-hook 'merlin-mode)
  (add-hook 'caml-mode-hook 'merlin-mode)
  ;; use opam switch to lookup ocamlmerlin binary
  (setq merlin-command 'opam)))

(with-eval-after-load 'company
  (add-to-list 'company-backends 'merlin-company-backend))

(add-to-list 'dash-at-point-mode-alist '(merlin-mode . "ocaml"))

(use-package flycheck-ocaml
  :requires init-flycheck
  :after flycheck
  :config
  (with-eval-after-load 'merlin
    ;; disable merlin's own error checking
    (setq merlin-error-after-save nil)
    ;; enable flycheck checker
    (flycheck-ocaml-setup)))

(provide 'init-ocaml)
