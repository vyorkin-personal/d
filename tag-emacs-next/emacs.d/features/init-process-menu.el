(require 'init-general)

(nmap 'process-menu-mode-map
   "M-d" 'process-menu-delete-process)

(provide 'init-process-menu)
