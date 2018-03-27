(require 'init-general)
(require 'init-quelpa)
(require 'init-evil)

(use-package frame-fns
  :demand t
  :quelpa (frame-fns :fetcher github :repo "emacsmirror/frame-fns"))

(use-package frame-cmds
  :demand t
  :quelpa (frame-cmds :fetcher github :repo "emacsmirror/frame-cmds"))

;; text-scale-increase/decrease doesn't play well with
;; company (suggestions popup alignment issue)
;; more info: https://github.com/company-mode/company-mode/issues/299#issuecomment-115056397
(use-package zoom-frm
  :requires init-general
  :quelpa (zoom-frm :fetcher github :repo "emacsmirror/zoom-frm")
  :config
  (nmap
   "C-=" 'zoom-frm-in
   "C--" 'zoom-frm-out
   "<s-triple-wheel-up>" 'zoom-frm-in
   "<s-triple-wheel-down>" 'zoom-frm-out))

(use-package seethru
  :config
  ;; C-c 8, C-c 9
  (seethru-recommended-keybinds))

(use-package ace-window
  :requires init-general
  :config
  (nmap
   :prefix rc/leader
   "w" 'ace-window))

(use-package popwin
  :config
  (popwin-mode))

(use-package fullframe
  :config
  (fullframe list-packages quit-window)
  (fullframe package-list-packages quit-window))

;; restore split pane config, winner-undo, winner-redo
(use-package winner
  :requires init-general
  :demand t
  :defer 1
  :init
  (setq winner-dont-bind-my-keys t)
  :config
  (winner-mode 1)
  :config
  (nmap
    :prefix rc/leader
    "U" 'winner-undo
    "R" 'winner-redo))

(use-package helpful)

(use-package with-editor
  :requires init-evil
  :demand t
  :config
  (nmap 'with-editor-mode-map
    "RET" 'with-editor-finish
    [escape] 'with-editor-cancel)
  (evil-set-initial-state 'with-editor-mode 'insert))

(provide 'init-editor)
