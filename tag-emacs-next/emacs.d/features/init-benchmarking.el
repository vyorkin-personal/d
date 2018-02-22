;; usage:
;; benchmark-init/show-durations-tabulated
;; or
;; benchmark-init/show-durations-tree

(use-package benchmark-init
  :config
  ;; to disable collection of benchmark data after init is done.
  (add-hook 'after-init-hook 'benchmark-init/deactivate))

(provide 'init-benchmarking)
