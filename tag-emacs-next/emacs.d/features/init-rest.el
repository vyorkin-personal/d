(require 'init-company)
(require 'init-org)

(use-package company-restclient)

(use-package restclient
  :requires (init-company init-org)
  :after (company company-restclient org)
  :defer 2
  :commands restclient-mode
  :config
  (add-to-list 'company-backends 'company-restclient)
  (add-to-list 'org-babel-load-languages '(restclient . t)))

(use-package ob-restclient :ensure t
  :requires init-org
  :after (org restclient)
  :commands org-babel-execute:restclient)

(provide 'init-rest)
