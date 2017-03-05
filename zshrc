# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000
bindkey -e

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "~/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

# enable bash completion compatibility mode
autoload bashcompinit
bashcompinit

source ~/.zplug/init.zsh

zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"

# set the priority when loading
# e.g., zsh-syntax-highlighting must be loaded
# after executing compinit command and sourcing other plugins
# (If the defer tag is given 2 or above, run after compinit command)
zplug "zsh-users/zsh-syntax-highlighting", defer:2

GEOMETRY_PROMPT_PLUGINS=(virtualenv exec_time git hg node)
zplug "frmendes/geometry", as:theme
# zplug 'simnalamburt/shellder', as:theme
# zplug "dracula/zsh", as:theme

zplug "zplug/zplug", hook-build: "zplug --self-manage"

# install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# source plugins and add commands to $PATH
zplug load

export PATH="$HOME/.rbenv/bin:$HOME/.local/bin:$PATH"
export GOPATH="$HOME/go"

# load custom functions & aliases
source $HOME/.helpers/index
