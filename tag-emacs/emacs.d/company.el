;; see http://company-mode.github.io/
(use-package company
  :preface
  ;; company interferes with yasnippet's native behaviour
  (defun rc/company/check-expansion ()
    (save-excursion
      (if (looking-at "\\_>") t
        (backward-char 1)
        (if (looking-at "\\.") t
          (backward-char 1)
          (if (looking-at "->") t nil)))))
  (defun rc/company/do-yas-expand ()
    (let ((yas/fallback-behavior 'return-nil))
      (yas/expand)))
  (defun rc/company/tab-indent-or-complete ()
    (interactive)
    (if (minibufferp)
        (minibuffer-complete)
      (if (or (not yas/minor-mode)
              (null (rc/company/do-yas-expand)))
          (if (rc/company/check-expansion)
              (company-complete-common)
            (indent-for-tab-command)))))
  :init
  ;; adjust this setting according to your typing speed
  (setq company-idle-delay 0.4)
  (setq company-minimum-prefix-length 1)
  ;; (setq company-show-numbers t)
  ;; aligns annotation to the right hand side
  (setq company-tooltip-align-annotations t)
  ;; (setq company-tern-meta-as-single-line t)
  ;; (setq company-tooltip-align-annotations t)
  :config
  (use-package company-quickhelp :demand t)
  (use-package company-web :demand t)
  (use-package company-tern :demand t)
  (use-package company-irony :demand t)
  (use-package company-irony-c-headers :demand t)
  ;; use company-mode in all buffers
  (add-hook 'after-init-hook 'global-company-mode)
  (with-eval-after-load 'company
    '(add-to-list 'company-backends
                  '(company-tern
                    company-robe
                    company-irony-c-headers
                    company-irony
                    merlin-company-backend))
    '(define-key company-active-map (kbd "C-c h")
       'company-quickhelp-manual-begin))
  (general-define-key
   :keymaps 'company-active-map
   "C-j" 'company-select-next-or-abort
   "C-k" 'company-select-previous-or-abort)
  :bind
  (([tab] . rc/company/tab-indent-or-complete))
  :diminish company-mode)
