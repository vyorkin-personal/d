(require 'init-general)
(require 'init-evil)
(require 'init-quelpa)

(use-package mu4e
  :defer 1.2
  :ensure nil
  :init
  (setq mu4e-maildir "~/Mail")
  (setq mu4e-drafts-folder "/Gmail/[Gmail].Drafts")
  (setq mu4e-sent-folder "/Gmail/[Gmail].Sent Mail")
  (setq mu4e-trash-folder "/Gmail/[Gmail].Trash")
  (setq mu4e-sent-messages-behavior 'delete)
  (setq mu4e-maildir-shortcuts
        '(("/Gmail/INBOX"              . ?i)
          ("/Gmail/[Gmail].Sent Mail"  . ?s)
          ("/Gmail/[Gmail].Trash"      . ?t)
          ("/Gmail/[Gmail].Drafts"      . ?d)
          ("/Gmail/[Gmail].All Mail"   . ?a)))
  (setq mu4e-bookmarks
        '(("flag:unread AND NOT flag:trashed" "Unread messages"  ?u)
          ("date:today..now" "Today's messages" ?t)
          ("date:7d..now" "Last 7 days" ?w)
          ("mime:image/*" "Messages with images" ?p)
          (,(mapconcat 'identity
                      (mapcar
                        (lambda (maildir)
                          (concat "maildir:" (car maildir)))
                        mu4e-maildir-shortcuts) " OR ")
          "All inboxes" ?i)))
  ;; auto update every minute
  (setq mu4e-update-interval 60)
  (setq mu4e-headers-auto-update t)
  ;; I was getting duplicate emails, this fixes it
  (setq mu4e-headers-skip-duplicates t)
  ;; sending
  (setq message-send-mail-function 'message-send-mail-with-sendmail
        sendmail-program "/usr/bin/msmtp"
        user-full-name "Vasiliy Yorkin")
  ;; capturing
  (setq org-mu4e-link-query-in-headers-mode nil)
  ;; goobook
  (setq external-abook-command "goobook query '%s' | cut -f 1,2")
  ;; mu4e alert
  (setq mu4e-alert-interesting-mail-query "flag:unread AND NOT flag:trashed AND maildir:/Gmail/INBOX")
  :config
  (add-hook 'after-init-hook #'mu4e-alert-enable-mode-line-display))

(use-package evil-mu4e
  :after mu4e
  :demand t)

(use-package external-abook
  :after quelpa
  :quelpa (external-abook :fetcher github :repo "emacsmirror/external-abook"))

(use-package mu4e-alert
  :disabled)

(provide 'init-email)
