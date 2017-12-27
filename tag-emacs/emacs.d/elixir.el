(use-package elixir-mode
  :init
  (use-package alchemist
    :demand t
    :init
    (setq
     alchemist-goto-elixir-source-dir "~/projects/github/elixir"
     alchemist-goto-erlang-source-dir "/usr/local/Cellar/erlang/19.2.3")
    :config
    (general-evil-define-key 'normal 'alchemist-mode-map
      :prefix "SPC"
      ;; elixir general key bindings
      "t" 'alchemist-mix-test
      "T" 'alchemist-project-run-tests-for-current-file
      "," 'alchemist-test-toggle-test-report-display
      "h" 'alchemist-help-search-at-point
      "H" 'alchemist-help
      "a" 'alchemist-project-toggle-file-and-tests
      "A" 'alchemist-project-toggle-file-and-tests-other-window
      "m" 'alchemist-mix
      ;; elixir IEx-specific key bindings
      "e" 'alchemist-iex-project-run
      "r" 'alchemist-iex-reload-module)
    (general-evil-define-key 'visual 'alchemist-mode-map
      :prefix "SPC"
      "e" 'alchemist-iex-send-current-line
      "E" 'alchemist-iex-send-current-line-and-go
      "r" 'alchemist-iex-send-region
      "R" 'alchemist-iex-send-region-and-go)
    ;; elixir HEX-specific key bindings
    (general-evil-define-key 'normal 'alchemist-hex-mode-map
      :prefix "SPC"
      "i" 'alchemist-hex-info-at-point
      "I" 'alchemist-hex-info
      "r" 'alchemist-hex-releases-at-point
      "R" 'alchemist-hex-releases
      "f" 'alchemist-hex-search))
  :config
  (add-hook 'elixir-mode-hook 'alchemist-mode)
  (add-hook 'elixir-mode-hook
            (lambda ()
              (when (and
                     (string-equal "exs" (file-name-extension buffer-file-name))
                     (string-equal "mix" (file-name-base buffer-file-name)))
                (alchemist-hex-mode 1)))))
