#!/bin/sh

if [[ "$OSTYPE" == "linux-gnu" ]]; then

        # ...

elif [[ "$OSTYPE" == "darwin"* ]]; then

	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew tap Homebrew/bundle
	brew bundle

	mkdir -p ~/.karabiner.d/configuration/
	touch $HOME/.karabiner.d/configuration/karabiner.json

	defaults write -g InitialKeyRepeat -int 10 		# normal minimum is 15 (225 ms)
	defaults write -g KeyRepeat -int 1 			# normal minimum is 2 (30 ms)
	defaults write com.apple.finder AppleShowAllFiles YES	# display hidden files in Finder

elif [[ "$OSTYPE" == "cygwin" ]]; then

        # POSIX compatibility layer and Linux environment emulation for Windows

elif [[ "$OSTYPE" == "msys" ]]; then

        # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)

elif [[ "$OSTYPE" == "win32" ]]; then

        # I'm not sure this can happen.

elif [[ "$OSTYPE" == "freebsd"* ]]; then

        # ...

else
        # Unknown.
fi

# required for nvm
mkdir -p $HOME/.nvm

ln -s $HOME/.dotfiles/rcrc $HOME/.rcrc

# set zsh as a default shell for the current user
sudo chsh -s $(which zsh) $USER

# backup existing emacs configuration
mv $HOME/.emacs.d $HOME/.emacs.d.bak
# install spacemacs
git clone https://github.com/syl20bnr/spacemacs $HOME/.emacs.d

# terminfo fix for neovim,
# see: https://github.com/neovim/neovim/issues/2048#issuecomment-78045837
infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
tic $TERM.ti
