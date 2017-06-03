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
[Add your JDKs to jenv](http://davidcai.github.io/blog/posts/install-multiple-jdk-on-mac/) (use your JDK versions):

```
$ jenv add /Library/Java/JavaVirtualMachines/jdkx.x.x_xx.jdk/Contents/Home
```

#### Elixir

My emacs config for [alchemist](https://github.com/tonini/alchemist.el) relies on
[elixir sources](https://github.com/elixir-lang/elixir.git) available at the following path: `~/projects/github/elixir`.

Optionally you may want to build and install patched [karabiner elements](https://github.com/vyorkin-forks/Karabiner-Elements/tree/standalone-modifiers) that supports hyper key.

[Here](https://gist.github.com/vyorkin/705c749cb7d439e94d62afee69520ecf) is my config for Karabiner Elements. So when you have it installed just do:

```
mkdir -p ~/.karabiner.d/configuration/
curl https://gist.githubusercontent.com/vyorkin/705c749cb7d439e94d62afee69520ecf/raw/bea834cf218633b10b0adc98b3a3cee749210b7a/karabiner.json > ~/.karabiner.d/configuration/karabiner.json
```

#### ocaml, opam, merlin

Do you want OPAM to modify ~/.zshrc and ~/.ocamlinit? - the answer is N.
This is because I use 'x' alias instead, see helpers/functions/env.

```
$ opam init
$ opam install merlin
```

For more info see [merlin + vim setup instructions](https://github.com/ocaml/merlin/wiki/vim-from-scratch).

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

# troubleshooting
