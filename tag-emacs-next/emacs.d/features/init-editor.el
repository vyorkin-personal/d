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
  :custom
  (aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l) "Use home row for selecting.")
  (aw-scope 'frame "Highlight only current frame.")
  :config
  (nmap
    :prefix rc/leader
    "w" 'ace-window))

(use-package ace-link
  :config
  (nmap
    "C-c C-l" 'counsel-ace-link)
  :config
  (ace-link-setup-default))

(use-package clipmon
  :config
  (clipmon-mode))

(use-package copy-as-format
  :requires init-general
  :after general
  :config
  (vmap
    :prefix "C-c f"
    "f" 'copy-as-format
    "a" 'copy-as-format-asciidoc
    "b" 'copy-as-format-bitbucket
    "d" 'copy-as-format-disqus
    "g" 'copy-as-format-github
    "l" 'copy-as-format-gitlab
    "h" 'copy-as-format-html
    "j" 'copy-as-format-jira
    "m" 'copy-as-format-markdown
    "w" 'copy-as-format-mediawiki
    "o" 'copy-as-format-org-mode
    "p" 'copy-as-format-pod
    "r" 'copy-as-format-rst
    "s" 'copy-as-format-slack))

(use-package link-hint
  :requires init-general
  :after general
  :config
  (nmap
    "C-c l o" 'link-hint-open-link
    "C-c l c" 'link-hint-copy-link))

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
