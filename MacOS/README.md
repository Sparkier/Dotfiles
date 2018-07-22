# MacOS Setup Scripts
This folder contains everything I use for setting up macOS. If I do a plain setup, i simply run: 
```zsh
bash setup.sh
```
This updates my shell to use zsh, installs the Xcode Command Line Tools, agrees to the Xcode license, installs and updates Homebrew, copies my zsh config to ~/.zshrc, and installs all the software listed in ./Brew/Brewfile and then checks for software updates.