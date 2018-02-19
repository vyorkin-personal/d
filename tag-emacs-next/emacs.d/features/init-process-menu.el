(require 'init-general)

(general-define-key
   :keymaps 'process-menu-mode-map
   "M-d" 'process-menu-delete-process)

(provide 'init-process-menu)
