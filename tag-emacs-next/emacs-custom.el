(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#d6d6d6" "#c82829" "#718c00" "#eab700" "#4271ae" "#8959a8" "#3e999f" "#4d4d4c"))
 '(ansi-term-color-vector
   [unspecified "#1e0528" "#00d9e9" "#05cb0d" "#955ae7" "#550068" "#8991bb" "#550068" "#ffeeff"])
 '(beacon-color "#c82829")
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(fci-rule-color "#d6d6d6")
 '(flycheck-color-mode-line-face-to-color (quote mode-line-buffer-id))
 '(flycheck-javascript-flow-args nil)
 '(frame-brackground-mode (quote dark))
 '(git-gutter:added-sign "+")
 '(git-gutter:deleted-sign "-")
 '(git-gutter:hide-gutter nil)
 '(git-gutter:modified-sign "*")
 '(git-gutter:update-interval 2)
 '(haskell-process-type (quote ghci) t)
 '(hl-paren-colors
   (quote
    ("#B9F" "#B8D" "#B7B" "#B69" "#B57" "#B45" "#B33" "#B11")))
 '(jdee-db-active-breakpoint-face-colors (cons "#1B2229" "#51afef"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1B2229" "#98be65"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1B2229" "#3f444a"))
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(org-agenda-files
   (quote
    ("/Users/vyorkin/Dropbox/org/diary.org" "/Users/vyorkin/Dropbox/org/ideas.org" "/Users/vyorkin/Dropbox/org/notes.org" "/Users/vyorkin/Dropbox/org/todos.org" "~/.emacs.d/elpa/moe-theme-20170914.2111/project.org" "~/.emacs.d/elpa/editorconfig-20180211.2028/project.org" "~/.emacs.d/elpa/spray-20160304.1420/project.org" "~/.emacs.d/elpa/arduino-mode-20151017.2335/project.org" "~/.emacs.d/elpa/nix-mode-20180215.1331/project.org" "~/.emacs.d/elpa/ssh-config-mode-20171109.1549/project.org" "~/.emacs.d/elpa/company-flx-20180102.2118/project.org" "~/.emacs.d/elpa/dired-quick-sort-20161208.1312/project.org" "~/.emacs.d/elpa/dired-filter-20171010.204/project.org" "~/.emacs.d/elpa/timonier-20170411.100/project.org" "~/.emacs.d/elpa/all-the-icons-20180125.757/project.org" "~/.emacs.d/elpa/memoize-20170720.1802/project.org" "~/.emacs.d/elpa/dired+-20180103.2043/project.org" "~/.emacs.d/elpa/peep-dired-20160321.1537/project.org" "~/.emacs.d/elpa/general-20180215.1455/project.org" "~/.emacs.d/elpa/dired-k-20170313.803/project.org" "~/projects/play/haskell/2018/pong/project.org" "~/.emacs.d/elpa/theme-changer-20171221.1127/project.org" "~/.emacs.d/elpa/flycheck-ocaml-20170730.1453/project.org" "~/.emacs.d/elpa/merlin-20170917.430/project.org" "~/.emacs.d/elpa/kotlin-mode-20180219.853/project.org" "~/.emacs.d/elpa/quack-20160410.207/project.org" "~/.emacs.d/elpa/geiser-20180202.1825/project.org" "~/.emacs.d/elpa/flycheck-yamllint-20170325.1035/project.org" "~/.emacs.d/elpa/flycheck-kotlin-20170122.337/project.org" "~/.emacs.d/elpa/flycheck-credo-20170526.845/project.org" "~/.emacs.d/elpa/flycheck-elm-20160717.257/project.org" "~/.emacs.d/elpa/flycheck-inline-20170728.2328/project.org" "~/.emacs.d/elpa/inline-docs-20170522.2150/project.org" "~/.emacs.d/elpa/web-mode-20180220.906/project.org" "~/.emacs.d/elpa/flycheck-color-mode-line-20171121.2307/project.org" "~/.emacs.d/elpa/company-restclient-20151202.401/project.org" "~/.emacs.d/elpa/know-your-http-well-20160208.1504/project.org" "/Applications/Emacs.app/Contents/Resources/lisp/textmodes/project.org" "~/.emacs.d/elpa/dash-20180206.2124/project.org" "~/.avfs/Users/vyorkin/.dotfiles/tag-ruby/rbenv/plugins/ruby-build/test/fixtures/project.org" "~/.dotfiles/tag-ruby/rbenv/plugins/ruby-build/project.org" "~/.emacs.d/elpa/elm-mode-20180114.9/project.org" "~/.emacs.d/elpa/flycheck-20180217.1201/project.org" "~/.emacs.d/elpa/prodigy-20180214.1249/project.org" "~/.emacs.d/elpa/magithub-20180217.601/project.org" "~/.emacs.d/elpa/ghub+-20180203.1017/project.org" "~/.emacs.d/elpa/apiwrap-20180201.637/project.org" "~/.emacs.d/elpa/exec-path-from-shell-20170508.4/project.org" "~/.emacs.d/elpa/rbenv-20141119.2349/project.org" "~/.emacs.d/elpa/dotenv-mode-20180207.1114/project.org" "~/.emacs.d/elpa/wakatime-mode-20170517.2053/project.org" "~/.emacs.d/elpa/racket-mode-20171116.1435/project.org" "~/.emacs.d/elpa/faceup-20170925.1246/project.org" "~/.emacs.d/elpa/company-racer-20171204.1910/project.org" "~/.emacs.d/elpa/deferred-20170901.630/project.org" "~/.emacs.d/elpa/cargo-20171218.855/project.org" "~/.emacs.d/elpa/clojure-mode-extra-font-locking-20180114.911/project.org" "~/.emacs.d/elpa/avy-20171230.220/project.org" "~/.emacs.d/elpa/helpful-20180220.1512/project.org" "~/.emacs.d/elpa/shut-up-20150423.522/project.org" "~/.emacs.d/elpa/elisp-refs-20180111.1431/project.org" "~/.emacs.d/elpa/loop-20160813.707/project.org" "~/.emacs.d/elpa/macrostep-20161120.1306/project.org" "~/.emacs.d/elpa/evil-args-20140329.1429/project.org" "/Applications/Emacs.app/Contents/Resources/lisp/calendar/project.org" "~/.emacs.d/elpa/smartparens-20180219.758/project.org" "~/.emacs.d/elpa/gist-20171127.2006/project.org" "~/.emacs.d/elpa/gh-20180112.1110/project.org" "~/.emacs.d/elpa/pcache-20170105.1414/project.org" "~/.emacs.d/elpa/logito-20120225.1255/project.org" "~/.emacs.d/elpa/marshal-20180124.439/project.org" "~/.emacs.d/elpa/ht-20180129.1434/project.org" "~/.emacs.d/elpa/gh-md-20151207.940/project.org" "/Applications/Emacs.app/Contents/Resources/lisp/term/project.org" "~/.emacs.d/elpa/dash-at-point-20140626.35/project.org" "~/.emacs.d/elpa/frame-cmds-20180106.141/project.org" "~/.emacs.d/elpa/camcorder-20160404.2134/project.org" "~/.emacs.d/elpa/names-20171012.1214/project.org" "~/.emacs.d/elpa/bundler-20160815.215/project.org" "~/.emacs.d/elpa/speed-type-20171230.847/project.org" "~/.emacs.d/elpa/markdown-mode+-20170320.1404/project.org" "~/.dotfiles/tag-ruby/rbenv/plugins/rbenv-aliases/project.org" "~/.emacs.d/elpa/markdown-preview-mode-20171121.2323/project.org" "~/.emacs.d/elpa/websocket-20171113.2045/project.org" "~/.emacs.d/elpa/web-server-20140905.1706/project.org" "~/.emacs.d/elpa/uuidgen-20140918.1601/project.org" "~/.emacs.d/elpa/use-package-20180206.1414/project.org" "~/.emacs.d/elpa/pomidor-20171214.727/project.org" "~/.emacs.d/elpa/alert-20180122.1242/project.org" "~/.emacs.d/elpa/gntp-20141024.1950/project.org" "~/.emacs.d/elpa/log4e-20170401.604/project.org" "~/.emacs.d/elpa/racer-20171211.1548/project.org" "~/.emacs.d/elpa/neotree-20170522.758/project.org" "~/.emacs.d/elpa/keyfreq-20160516.716/project.org" "~/.emacs.d/elpa/transmission-20180201.1506/project.org" "~/.emacs.d/elpa/coin-ticker-20170611.27/project.org" "~/.emacs.d/elpa/request-20170131.1747/project.org" "~/.emacs.d/elpa/external-abook-20100715.1240/project.org" "~/.emacs.d/elpa/evil-mu4e-20171127.1214/project.org" "~/.emacs.d/elpa/ob-restclient-20160323.2305/project.org" "~/.emacs.d/elpa/restclient-20171203.1248/project.org" "~/.emacs.d/elpa/docker-compose-mode-20170916.1438/project.org" "~/.emacs.d/elpa/yaml-mode-20180212.1556/project.org" "~/.emacs.d/elpa/docker-20180107.925/project.org" "~/.emacs.d/elpa/docker-tramp-20170206.1925/project.org" "~/.emacs.d/elpa/tablist-20170219.1935/project.org" "~/.emacs.d/elpa/flycheck-irony-20160317.1536/project.org" "~/.emacs.d/elpa/company-irony-c-headers-20151018.209/project.org" "~/.emacs.d/elpa/company-irony-20170905.1346/project.org" "~/.emacs.d/elpa/irony-eldoc-20170502.1208/project.org" "~/.emacs.d/elpa/irony-20180104.1109/project.org" "~/.emacs.d/elpa/go-playground-20170226.43/project.org" "~/.emacs.d/elpa/gotest-20170823.141/project.org" "~/.emacs.d/elpa/go-direx-20150315.1843/project.org" "~/.emacs.d/elpa/direx-20170422.627/project.org" "~/.emacs.d/elpa/go-gopath-20160705.334/project.org" "~/.emacs.d/elpa/go-eldoc-20170305.627/project.org" "~/.emacs.d/elpa/go-add-tags-20161123.427/project.org" "~/.emacs.d/elpa/go-stacktracer-20150430.1442/project.org" "~/.emacs.d/elpa/company-go-20170825.943/project.org" "~/.emacs.d/elpa/go-mode-20170726.555/project.org" "~/.emacs.d/elpa/rubocop-20170311.2211/project.org" "~/.emacs.d/elpa/robe-20171116.1249/project.org" "~/.emacs.d/elpa/psci-20171011.50/project.org" "~/.emacs.d/elpa/purescript-mode-20180120.709/project.org" "~/.emacs.d/elpa/psc-ide-20180101.1421/project.org" "~/.emacs.d/elpa/idris-mode-20180210.400/project.org" "~/.emacs.d/elpa/prop-menu-20150728.418/project.org" "~/.emacs.d/elpa/intero-20180221.149/project.org" "~/.emacs.d/elpa/haskell-mode-20171022.26/project.org" "~/.emacs.d/elpa/flycheck-dialyxir-20170515.825/project.org" "~/.emacs.d/elpa/flycheck-mix-20170118.630/project.org" "~/.emacs.d/elpa/flycheck-elixir-20171122.507/project.org" "~/.emacs.d/elpa/alchemist-20171029.2307/project.org" "~/.emacs.d/elpa/elixir-mode-20170918.2231/project.org" "~/.emacs.d/elpa/flycheck-dialyzer-20160326.730/project.org" "~/.emacs.d/elpa/erlang-20171219.305/project.org" "~/.emacs.d/elpa/reason-mode-0.3.0/project.org" "~/.emacs.d/elpa/ensime-20180201.1340/project.org" "~/.emacs.d/elpa/scala-mode-20170802.432/project.org" "~/.emacs.d/elpa/sbt-mode-20171111.1558/project.org" "~/.emacs.d/elpa/popup-20160709.729/project.org" "~/.emacs.d/elpa/flycheck-rust-20171021.151/project.org" "~/.emacs.d/elpa/rust-mode-20180215.210/project.org" "~/.emacs.d/elpa/flycheck-clojure-20170221.1354/project.org" "~/.emacs.d/elpa/cider-20180219.1846/project.org" "~/.emacs.d/elpa/clojure-mode-20180202.922/project.org" "~/.emacs.d/elpa/queue-0.2/project.org" "~/.emacs.d/elpa/json-navigator-20171220.19/project.org" "~/.emacs.d/elpa/hierarchy-20171221.351/project.org" "~/.emacs.d/elpa/json-mode-20170719.2205/project.org" "~/.emacs.d/elpa/json-reformat-20160212.53/project.org" "~/.emacs.d/elpa/json-snatcher-20150511.2047/project.org" "~/.emacs.d/elpa/company-tern-20161004.1147/project.org" "~/.emacs.d/elpa/dash-functional-20180107.818/project.org" "~/.emacs.d/elpa/prettier-js-20180108.2326/project.org" "~/.emacs.d/elpa/rjsx-mode-20171029.1156/project.org" "~/.emacs.d/elpa/js2-refactor-20180118.251/project.org" "~/.emacs.d/elpa/multiple-cursors-20170908.1452/project.org" "~/.emacs.d/elpa/xref-js2-20170530.126/project.org" "~/.emacs.d/elpa/js2-mode-20171224.1833/project.org" "~/.emacs.d/elpa/npm-mode-20171103.1135/project.org" "~/.emacs.d/elpa/tern-20170925.1333/project.org" "~/.emacs.d/elpa/flycheck-flow-20180216.1156/project.org" "~/.emacs.d/elpa/tide-20180212.2229/project.org" "~/.emacs.d/elpa/typescript-mode-20180118.2305/project.org" "~/.emacs.d/elpa/company-web-20171111.1049/project.org" "~/.emacs.d/elpa/web-completion-data-20160318.148/project.org" "~/.emacs.d/elpa/flyspell-correct-ivy-20161031.1134/project.org" "~/.emacs.d/elpa/flyspell-correct-20171205.940/project.org" "~/.emacs.d/elpa/emmet-mode-20161113.2158/project.org" "~/.emacs.d/elpa/markdown-preview-eww-20160111.702/project.org" "~/.emacs.d/elpa/markdown-toc-20170711.1249/project.org" "~/.emacs.d/elpa/markdown-mode-20180124.138/project.org" "~/.emacs.d/elpa/google-translate-20170713.119/project.org" "~/.emacs.d/elpa/yasnippet-20180218.459/project.org" "~/.emacs.d/elpa/git-gutter-20161105.656/project.org" "~/.emacs.d/elpa/evil-magit-20171213.1019/project.org" "~/.emacs.d/elpa/magit-20180220.1117/project.org" "~/.emacs.d/elpa/ghub-20180218.904/project.org" "~/.emacs.d/elpa/git-commit-20180202.321/project.org" "~/.emacs.d/elpa/let-alist-1.0.5/project.org" "~/.emacs.d/elpa/magit-popup-20180217.910/project.org" "~/.emacs.d/elpa/with-editor-20180217.548/project.org" "~/.emacs.d/elpa/async-20180119.533/project.org" "~/.emacs.d/elpa/highlight-indent-guides-20170516.1355/project.org" "~/.emacs.d/elpa/use-package-chords-20180127.1413/project.org" "~/.emacs.d/elpa/bind-chord-20171204.1210/project.org" "~/.emacs.d/elpa/key-chord-20160227.438/project.org" "~/.emacs.d/elpa/volatile-highlights-20160611.1855/project.org" "~/.emacs.d/elpa/highlight-thing-20170919.704/project.org" "~/.emacs.d/elpa/highlight-blocks-20151201.815/project.org" "/var/folders/dn/j1kwqgxx7890ghrdbcg4kv2m0000gn/T/try199982nL/highlight-blocks-20151201.815/project.org" "~/.emacs.d/elpa/highlight-escape-sequences-20171117.437/project.org" "~/.emacs.d/elpa/highlight-chars-20180102.36/project.org" "~/.emacs.d/elpa/intero-20180219.1703/project.org" "/Applications/Emacs.app/Contents/Resources/lisp/language/project.org" "~/.emacs.d/elpa/mu4e-alert-20180211.2319/project.org" "~/.emacs.d/elpa/magit-20180219.1545/project.org" "~/.emacs.d/elpa/yasnippet-20180213.602/project.org" "~/.emacs.d/elpa/ace-window-20180123.1111/project.org" "~/.emacs.d/elpa/company-coq-20180219.751/project.org" "~/.emacs.d/elpa/company-math-20171016.814/project.org" "~/.emacs.d/elpa/math-symbol-lists-20170221.553/project.org")))
 '(org-fontify-whole-heading-line t)
 '(package-selected-packages
   (quote
    (auto-package-update spaceline-all-the-icons company-box google-this eldoc-overlay lsp-rust company-lsp lsp-haskell lsp-ui lsp-mode hasky-stack flycheck-haskell flycheck-ghcmod counsel-etags hlint-refactor hasky-extensions company-ghc ghc hsearch-mode coq-mode sml-mode org-trello org-super-agenda org-projectile lush-theme deep-thought-theme challenger-deep-theme labburn-theme brainfuck-mode blackboard-theme assemblage-theme abyss-theme color-theme-modern material-theme cyberpunk-theme ample-theme tao-theme flatland-theme flatland darkmine-theme arjen-grey-theme org-bullets vargant hayoo 0xc flycheck-stack structured-haskell-mode hindent hident ghci-completion iasm-mode nasm-mode crontab-mode csv-mode showcss-mode css-autoprefixer flycheck-css-colorguard define-word llvm-mode rainbow-blocks undohist 4clojure aggressive-indent fill-column-indicator indent-guide golden-ratio git-timemachine fancy-battery gitconfig-mode gitignore-mode vi-tilde-fringe ws-butler hl-todo diff-hl gitattributes-mode git-modes smeargle smooth-scrolling typeit uptimes rspec-mode moe-theme editorconfig spray arduino-mode nix-mode ssh-config-mode company-flx dired-filter timonier peep-dired theme-changer flycheck-ocaml quack geiser flycheck-yamllint flycheck-kotlin kotlin-flycheck flycheck-credo avy-flycheck flycheck-elm flycheck-inline company-restclient elm-mode prodigy magithub rbenv dotenv-mode wakatime-mode ob-racket racket-mode ensime-company company-racer cargo clojure-mode-extra-font-locking helpful elisp-refs macrostep smartparens-config smartparens gist gh-md dash-at-point camcorder bundler speed-type markdown-mode+ markdown-mode-plus markdown-preview-mode pomidor neotree irony tern flycheck vimish-fold dashboard page-break-lines frame-cmds markdown-preview-eww markdown-toc use-package-chords highlight-sexp volatile-highlights highlight-thing highlight-blocks flycheck-color-mode-line highlight-escape-sequences haskell-mode elixir-mode js2-mode typescript-mode transmission coin-ticker evil-mu4e mu4e-alert external-abook go-playground gotest go-direx go-gopath go-eldoc go-add-tags go-stacktracer company-go git-gutter evil-escape docker-compose-mode rust-mode yasnippet counsel ivy company frame-fns quelpa package-build seethru ob-restclient restclient highlight-indent-guides dired-hacks-utils dired diminish fullframe popwin osx reveal-in-osx-finder linum-relative spaceline spaceline-config docker-machine docker-containers docker-images docker evil-surround evil highlight-leading-spaces evil-lion evil-goggles evil-collection use-package-ensure-system-package dimmer zoom-frm zenburn-theme yoshi-theme yaml-mode xref-js2 which-key web-mode virtualenvwrapper twilight-theme try toml-mode tide telephone-line sublimity sublime-themes solidity-mode smart-mode-line shell-switcher sentence-navigation scss-mode rubocop rtags robe rjsx-mode restart-emacs repl-toggle reason-mode rainbow-mode rainbow-delimiters racer quelpa-use-package psci psc-ide projectile-ripgrep projectile-rails prettier-js persp-projectile paradox paganini-theme npm-mode nginx-mode multi-term monokai-theme lua-mode kotlin-mode keyfreq kaolin-theme json-navigator json-mode js2-refactor jade-mode ivy-hydra irony-eldoc intero idris-mode idle-highlight-mode highlight-indentation highlight-chars hemisu-theme haml-mode gruber-darker-theme gotham-theme google-translate go-mode glsl-mode git-gutter+ ggtags general flyspell-correct-ivy flycheck-rust flycheck-purescript flycheck-mix flycheck-irony flycheck-flow flycheck-elixir flycheck-dialyzer flycheck-dialyxir flycheck-clojure flx fireplace exec-path-from-shell evil-visualstar evil-vimish-fold evil-org evil-numbers evil-mc evil-matchit evil-magit evil-indent-plus evil-exchange evil-embrace evil-ediff evil-commentary evil-args erlang ensime emmet-mode dtrt-indent dracula-theme doom-themes dockerfile-mode direx dired-toggle dired-subtree dired-rainbow dired-quick-sort dired-open dired-narrow dired-k dired-collapse dired-avfs dired+ delight d-mode cycle-themes counsel-projectile company-web company-tern company-quickhelp company-irony-c-headers company-irony company-coq color-theme-sanityinc-tomorrow color-identifiers-mode busybee-theme boron-theme bookmark+ bliss-theme better-shell base16-theme badwolf-theme badger-theme atom-one-dark-theme all-the-icons-ivy all-the-icons-dired alchemist ace-window)))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838")))
 '(safe-local-variable-values (quote ((checkdoc-minor-mode . t) (mangle-whitespace . t))))
 '(smeargle-age-colors
   (quote
    ((0)
     (1 . "grey8")
     (2 . "grey7")
     (3 . "grey6")
     (4 . "grey5")
     (5 . "grey4")
     (6 . "grey3")
     (7 . "grey2")
     (8 . "grey1"))))
 '(smeargle-colors
   (quote
    ((older-than-1day . "red")
     (older-than-3day . "green")
     (older-than-1week . "yellow")
     (older-than-2week)
     (older-than-1month . "orange")
     (older-than-3month . "pink")
     (older-than-6month . "cyan")
     (older-than-1year . "grey50"))))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#c82829")
     (40 . "#f5871f")
     (60 . "#eab700")
     (80 . "#718c00")
     (100 . "#3e999f")
     (120 . "#4271ae")
     (140 . "#8959a8")
     (160 . "#c82829")
     (180 . "#f5871f")
     (200 . "#eab700")
     (220 . "#718c00")
     (240 . "#3e999f")
     (260 . "#4271ae")
     (280 . "#8959a8")
     (300 . "#c82829")
     (320 . "#f5871f")
     (340 . "#eab700")
     (360 . "#718c00"))))
 '(vc-annotate-very-old-color nil)
 '(wakatime-python-bin nil)
 '(window-divider-default-right-width 1)
 '(window-divider-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil))))
 '(vimish-fold-mouse-face ((t (:box (:line-width 1 :color "yellow")))))
 '(vimish-fold-overlay ((t (:box (:line-width 1 :color "dim gray"))))))
