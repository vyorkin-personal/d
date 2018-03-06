# Intro

Here is find my dotfiles that I use specifically for Mac OS X.

# Installation

```
$ git clone https://github.com/vyorkin-personal/d.git ~/.dotfiles
$ cd ~/.dotfiles
$ git submodule update --init
$ make
```

# Setup

If you use iTerm2, enable "Applications in terminal may access system
clipboard"

Some of the installed software requires additional setup, so examine the Brewfile and run `brew info someting` and `brew cask info something` accordingly to find out your post-installation steps.
I've tried hard to do this for you, so you may not require to do anyting at all, but I probably missed smth.

Here is the things you should do manually.

#### Coq

[install Proof General](https://github.com/ProofGeneral/PG)

#### Sufring keys for Chrome

[my settings gist](https://gist.github.com/vyorkin/c5d9cfa63da9811ed0062c5f1440f754)

#### Non-free software

* MindNode
* 2Do
* SnippetsLab
* DayOne
* Typinator
* Pixave
* Pdf Expert
* Timing
* Airmail 3
* Fantastical
* Bartender
* Focus
* Reeder 3
* Dropzone
* PopClip
* Next Meeting
* Xccello
* DaisyDisk
* MonthlyCal
* Spotify
* Spotifree
* Sketch
* Adobe Photoshop, Illustrator, etc
* BeardedSpice
* LittleSnitch
* Texpad
* Anki
* Paw
* Default Folder

#### Safari extensions

[Here](https://github.com/learn-anything/safari-extensions) you'll find anyting you need.

#### Elixir & Phoenix

I should manually install phoenix:
```
mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez
```

##### Haskell

```
stack install stylish-haskell
```

#### Tmux

Run `C-SPC-I` in tmux session to install plugins.

#### jenv & JDKs

[Add your JDKs to jenv](http://davidcai.github.io/blog/posts/install-multiple-jdk-on-mac/) (use your JDK versions):

```
$ jenv add /Library/Java/JavaVirtualMachines/jdkx.x.x_xx.jdk/Contents/Home
```

## Optional

* [Bash-Snippets](https://github.com/alexanderepstein/Bash-Snippets.git)
* [Hexitor](https://github.com/briansteffens/hexitor)

#### Scala

* [sbt & ensime installation guide](http://ensime.org/build_tools/sbt/)
* [coursier](https://github.com/coursier/coursier#quick-start)

#### Elixir

My emacs config for [alchemist](https://github.com/tonini/alchemist.el) relies on
[elixir sources](https://github.com/elixir-lang/elixir.git) available at the following path: `~/projects/github/elixir`.

Optionally you may want to install [karabiner elements](https://github.com/tekezo/Karabiner-Elements).

#### OCaml, Opam, Merlin, Tuareg

Do you want OPAM to modify ~/.zshrc and ~/.ocamlinit? - the answer is N.
This is because I use 'x' alias instead, see helpers/functions/env.

```
$ opam init
$ opam install merlin
$ opam install tuareg
```

For more info see [merlin + vim setup instructions](https://github.com/ocaml/merlin/wiki/vim-from-scratch).

#### Reason

You may want to install [the Reason toolchain](https://github.com/reasonml/reason-cli).

#### Emacs and Irony mode

[Mac OS X issues and workaround](https://github.com/Sarcasm/irony-mode/wiki/Mac-OS-X-issues-and-workaround)

#### GCC & bitutils

On Mac OS X I use GNU GCC and GNU bitutils for cross compilation,
so in my zshrc I have these binaries added to my PATH env variable.
I put GCC binaries here `/usr/local/i386elfgcc/bin` and here `/usr/local/x8664pcelfgcc/bin`.
See [this page](https://github.com/cfenollosa/os-tutorial/tree/master/11-kernel-crosscompiler)
for a detailed instructions on how to setup development environment for cross compilation.

#### PGP/GPG, keybase, signing git commits

Read on [pstadler/keybase-gpg-github](https://github.com/pstadler/keybase-gpg-github) on how to set everything up.

#### Rust

Common crates that I use:

* [rusty-tags](https://github.com/dan-t/rusty-tags)
* [rustfmt](https://github.com/rust-lang-nursery/rustfmt)
* [racer](https://github.com/phildawes/racer)

#### Coq

* [emacs company-coq](https://github.com/cpitclaudel/company-coq#proof-general) install Proof General manually

#### NPM global packages

* bower
* yo
* madge
* speed-test
* tldr
* eslint_d
* how-to-npm
* psi
* create-react-app
* git-issues
* vtop
* now@beta
* trash-cli
* purescript
* pulp
* pscid
* purescript-emmet
* git-labelmaker
* json-package

# Troubleshooting

Don't worry, be happy

# TODO

* consider using [targets.el](https://github.com/noctuid/targets.el) - extension of evil text objects, when it'll become stable enough

* remove old packages from the list below and automate the installation process somehow:
```
  npm-check
  npm-check-updates
  npm-upgrade
  bower-check-updates
  avn
  avn-nvm
  browser
  forever nodemon jscs csslint ify
```

```
  prettier
  jsdoc
  stylelint
  doiuse
  watch js-beautify nsp snyk gitbook-cli plato sloc npmd@1 live-server git-guilt doctoc
  trash localtunnel svgo git+https://github.com/ramitos/jsctags.git
  jsfmt fixmyjs jsinspect tmi  commitizen
  karma-cli istanbul foreman
  iron-node devtool disc stylelint-config-suitcss next-update semantic-release-cli
  exact-semver fixpack cli-real-favicon greenkeeper npm-which budo
  del-cli npm-quick-run center-code gtni alex typings
  tern recli webpack-validator all-nvm available-versions manpm center-code
  conventional-changelog-cli conventional-recommended-bump
  typed-css-modules chrome-webstore-upload-cli react-native-cli
  create-webpack-config node-pre-gyp
  yarn-completions pkgcount typescript-formatter
  git-recall
```

* [learn ASDF version manager](https://github.com/asdf-vm/asdf) to see if it can
  replace a bunch of other language-specific tools
