#!/bin/sh

if [[ "$OSTYPE" == "darwin"* ]]; then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        brew tap Homebrew/bundle
        brew bundle
        brew install --HEAD https://raw.github.com/apiaryio/drafter/master/tools/homebrew/drafter.rb
        mas signin

        sudo easy_install pip

        mkdir -p ~/.karabiner.d/configuration/
        touch $HOME/.karabiner.d/configuration/karabiner.json

        sudo sysctl -w kern.maxfiles=1000000
        sudo sysctl -w kern.maxfilesperproc=18000

        defaults write -g InitialKeyRepeat -int 1               # normal minimum is 15 (225 ms)
        defaults write -g KeyRepeat -int 1                      # normal minimum is 2 (30 ms)
        defaults write com.apple.finder AppleShowAllFiles YES   # display hidden files in Finder
fi

# required for nvm
mkdir -p $HOME/.nvm

ln -s $HOME/.dotfiles/rcrc $HOME/.rcrc

# allow everything
sudo spctl --master-disable

# set zsh as a default shell for the current user
sudo chsh -s $(which zsh) $USER

# backup existing emacs configuration
mv -f $HOME/.emacs.d $HOME/.emacs.d.bak

pip install -r requirements.txt
pip3 install -r requirements3.txt

/usr/local/opt/fzf/install
