# intro

Here is find my dotfiles that I use specifically for Mac OS X.

# installation

```
$ git clone https://github.com/vyorkin-personal/d.git ~/.dotfiles
$ cd ~/.dotfiles
$ git submodule update --init
$ make
```

# setup

If you use iTerm2, enable "Applications in terminal may access system
clipboard"

Some of the installed software requires additional setup, so examine the Brewfile and run `brew info someting` and `brew cask info something` accordingly to find out your post-installation steps.
I've tried hard to do this for you, so you may not require to do anyting at all,
but I probably missed smth.

Here is the things you should do manually.

Run `C-SPC-I` in tmux session to install plugins.

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

Optionally you may want to build and install patched [karabiner elements](https://github.com/vyorkin-forks/Karabiner-Elements/tree/standalone-modifiers) that supports hyper key.

[Here](https://gist.github.com/vyorkin/705c749cb7d439e94d62afee69520ecf) is my config for Karabiner Elements. So when you have it installed just do:

```
mkdir -p ~/.karabiner.d/configuration/
curl https://gist.githubusercontent.com/vyorkin/705c749cb7d439e94d62afee69520ecf/raw/bea834cf218633b10b0adc98b3a3cee749210b7a/karabiner.json > ~/.karabiner.d/configuration/karabiner.json
```

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

# Troubleshooting

Don't worry, be happy

# TODO

* consider using [targets.el](https://github.com/noctuid/targets.el) - extension of evil text objects, when it'll become stable enough

* remove old packages from the list below and automate the installation process somehow:
```
  bower duo grunt-cli broccoli-cli gulp yo khaos jspm
  npm-check npm-check-updates bower-check-updates avn avn-nvm browserify
  madge forever nodemon jscs csslint how-to-npm
  psi eslint eslint_d jsdoc stylelint doiuse
  watch js-beautify nsp snyk gitbook-cli plato sloc npmd@1 live-server git-guilt doctoc
  trash localtunnel svgo git+https://github.com/ramitos/jsctags.git
  jsfmt fixmyjs jsinspect tmi speed-test tldr commitizen
  karma-cli istanbul foreman
  iron-node devtool disc stylelint-config-suitcss next-update semantic-release-cli
  git-issues exact-semver fixpack cli-real-favicon greenkeeper npm-which budo
  del-cli json-package npm-quick-run center-code gtni alex typings
  tern recli webpack-validator all-nvm available-versions manpm center-code
  conventional-changelog-cli conventional-recommended-bump
  typed-css-modules chrome-webstore-upload-cli react-native-cli
  create-webpack-config create-react-app node-pre-gyp npm-upgrade
  yarn-completions pkgcount typescript-formatter pulp
  git-recall
```

* [learn ASDF version manager](https://github.com/asdf-vm/asdf) to see if it can
  replace a bunch of other language-specific tools
