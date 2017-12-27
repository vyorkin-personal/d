(use-package rtags
  :defer t)
(use-package ggtags
  :defer t
  :commands ggtags-mode
  :config
  (add-hook 'c-mode-common-hook 'ggtags-mode)
  (add-hook 'ruby-mode-hook 'ggtags-mode)
  (add-hook 'haml-mode-hook 'ggtags-mode)
  :diminish ggtags-mode)
