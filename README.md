# intro

Here is find my dotfiles that I use specifically for Mac OS X.

# installation

```
$ git clone https://github.com/vyorkin-personal/d.git ~/.dotfiles
$ cd ~/.dotfiles
$ git submodule update --init
$ make
```

Optionally you may want to build and install patched [karabiner elements](https://github.com/vyorkin-forks/Karabiner-Elements/tree/standalone-modifiers) that supports hyper key.

[Here](https://gist.github.com/vyorkin/705c749cb7d439e94d62afee69520ecf) is my config for Karabiner Elements. So when you have it installed just do:

```
mkdir -p ~/.karabiner.d/configuration/
curl https://gist.githubusercontent.com/vyorkin/705c749cb7d439e94d62afee69520ecf/raw/bea834cf218633b10b0adc98b3a3cee749210b7a/karabiner.json > ~/.karabiner.d/configuration/karabiner.json
```
