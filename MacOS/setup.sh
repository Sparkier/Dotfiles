# Install the Xcode Command Line Tools.
if ! [ -f "/Library/Developer/CommandLineTools/usr/bin/git" ] || \
   ! [ -f "/usr/include/iconv.h" ]
then
  echo "Installing the Xcode Command Line Tools:"
  CLT_PLACEHOLDER="/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress"
  sudo touch "$CLT_PLACEHOLDER"
  CLT_PACKAGE=$(softwareupdate -l | \
                grep -B 1 -E "Command Line (Developer|Tools)" | \
                awk -F"*" '/^ +\*/ {print $2}' | sed 's/^ *//' | head -n1)
  sudo softwareupdate -i "$CLT_PACKAGE"
  sudo rm -f "$CLT_PLACEHOLDER"
  if ! [ -f "/usr/include/iconv.h" ]; then
    echo "Requesting user install of Xcode Command Line Tools:"
    xcode-select --install
  fi
  echo "OK"
fi

# Check if the Xcode license is agreed to and agree if not.
xcode_license() {
  if /usr/bin/xcrun clang 2>&1 | grep $Q license; then
    echo "Asking for Xcode license confirmation:"
    sudo xcodebuild -license
    echo "OK"
  fi
}
xcode_license

# Install Homebrew.
if brew help > /dev/null; then
  echo "Brew already installed."
else
  echo "Installing Homebrew:"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Updating Homebrew:"
brew update
echo "OK"

# Install all additional software from brew.
echo "Installing Brewfile software:"
brew bundle --file=./Brew/Brewfile --verbose
echo "OK"

echo "Installing FZF keybindings, this may require your interaction."
$(brew --prefix)/opt/fzf/install
echo "OK"

# Install oh-my-zsh.
echo "Installing oh-my-zsh:"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo "OK"

# Shell changed to zsh.
echo "Changing shell to zsh:" # TODO: Only when not already zsh!
chsh -s $(which zsh)
echo "OK"

# Copy zsh Theme.
echo "Copying zsh theme:"
ln -s ./Terminal/alex.zsh-theme ~/.oh-my-zsh/custom/themes/alex.zsh-theme
echo "OK"

# Copy zsh config.
echo "Copying zsh config:"
ln -s ./Terminal/zshrc ~/.zshrc
echo "OK"

# Copy iTerm Profile.
echo "Copying iTerm 2 profile."
ln -s ./Terminal/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
echo "OK"

# Copy Hammerspoon Profile.
echo "Copying Hammerspoon profile."
ln -s ./Hammerspoon/init.lua ~/.hammerspoon/init.lua
echo "OK"

# Copy Karabiner Profile.
echo "Copying Karabiner profile."
ln -s ./Karabiner/karabiner.json ~/.config/karabiner/karabiner.json
echo "OK"

# Install Colorls
echo "Installing colorls."
sudo gem install colorls
echo "OK"

# Check and install any remaining software updates.
echo "Checking for software updates:"
if softwareupdate -l 2>&1 | grep $Q "No new software available."; then
  echo "OK"
else
  echo "Installing software updates:"
  sudo softwareupdate --install --all
  xcode_license
  echo "OK"
fi

echo "Your system is now setup!"
echo "!!!"
echo "If the iTerm profile is incorrect, execute the following command:"
echo "cp Terminal/com.googlecode.iterm2.plist ~/Library/Preferences"
echo "!!!"
