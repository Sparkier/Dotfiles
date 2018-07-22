# MacOS Setup Scripts
This folder contains everything I use for setting up macOS. If I do a plain setup, i simply run: 
```zsh
bash setup.sh
```
What this does:
1. Installs the Xcode Command Line Tools
1. Agrees to the Xcode license
1. Installs and updates Homebrew
1. Installs all the software listed in ./Brew/Brewfile
1. Installs oh-my-zsh
1. Updates my shell to use zsh
1. Copies my zsh theme to ~/.oh-my-zsh/custom/themes
1. Copies my zsh config to ~/.zshrc
1. Copies my iTerm2 profile to ~/Library/Preferences
1. Installs colorls
1. Checks for software updates

If one does not want to do all of that, some steps or config files can also be found in the subfolders of this folder and can be used independently.