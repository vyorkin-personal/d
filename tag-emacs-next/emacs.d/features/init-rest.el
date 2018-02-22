(require 'init-company)
(require 'init-org)

(use-package restclient :defer t
  :after company
  :commands restclient-mode
  :config
  (with-eval-after-load 'org
    (add-to-list 'company-backends 'company-restclient)
    (add-to-list 'org-babel-load-languages '(restclient . t))))

(use-package ob-restclient :ensure t
  :after (:both org restclient)
  :commands org-babel-execute:restclient)

(provide 'init-rest)
