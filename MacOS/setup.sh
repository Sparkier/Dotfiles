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
  if /usr/bin/xcrun clang 2>&1 | grep -q license; then
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
  HOMEBREW_SCRIPT_URL="https://raw.githubusercontent.com/Homebrew/install/280cbc9adffcbdef15dd1c9d991ef2d1dd7cfc9c/install.sh"
  HOMEBREW_SCRIPT_HASH="f3e91784ffeda32bc397de7acc1154724cc47522a459c9ac656cca176eeba457"
  TMP_SCRIPT=$(mktemp)
  curl -fsSL "$HOMEBREW_SCRIPT_URL" -o "$TMP_SCRIPT"
  if echo "$HOMEBREW_SCRIPT_HASH  $TMP_SCRIPT" | shasum -a 256 -c - > /dev/null; then
    /bin/bash "$TMP_SCRIPT"
  else
    echo "Error: Homebrew install script hash mismatch!"
    rm -f "$TMP_SCRIPT"
    exit 1
  fi
  rm -f "$TMP_SCRIPT"
fi

echo "Linking Homebrew:"
echo '# Set PATH, MANPATH, etc., for Homebrew.' >> /Users/alex/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/alex/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

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

# Install oh-my-zsh securely.
echo "Installing oh-my-zsh:"
  OMZ_SCRIPT_URL="https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/c86ba78e2ff5c5a3e9282a84c0cc220dd3d5f253/tools/install.sh"
  OMZ_SCRIPT_HASH="21043aec5b791ce4835479dc33ba2f92155946aeafd54604a8c83522627cc803"
  TMP_SCRIPT=$(mktemp)
  curl -fsSL "$OMZ_SCRIPT_URL" -o "$TMP_SCRIPT"
  if echo "$OMZ_SCRIPT_HASH  $TMP_SCRIPT" | shasum -a 256 -c - > /dev/null; then
    sh "$TMP_SCRIPT"
  else
    echo "Error: Oh-My-Zsh install script hash mismatch!"
    rm -f "$TMP_SCRIPT"
    exit 1
  fi
  rm -f "$TMP_SCRIPT"
echo "OK"

# Shell changed to zsh.
ZSH_PATH=$(which zsh)
if [ "$SHELL" != "/bin/zsh" ] && [ "$SHELL" != "$ZSH_PATH" ]; then
  echo "Changing shell to zsh:"
  chsh -s "$ZSH_PATH"
  echo "OK"
fi

# Copy zsh Theme.
echo "Copying zsh theme:"
ln -s $PWD/Terminal/alex.zsh-theme ~/.oh-my-zsh/custom/themes/alex.zsh-theme
echo "OK"

# Copy zsh config.
echo "Copying zsh config:"
ln -s $PWD/Terminal/zshrc ~/.zshrc
echo "OK"

# Copy iTerm Profile.
echo "Copying iTerm 2 profile."
ln -s $PWD/Terminal/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
echo "OK"

# Copy Tmux Profile.
echo "Copying Tmux profile."
ln -s $PWD/Terminal/tmux.conf ~/.tmux.conf
echo "OK"

# Copy launch temix script
echo "Copying launch tmux script."
ln -s $PWD/Terminal/launch.sh ~/.launch.sh
echo "OK"

# Copy Hammerspoon Profile.
echo "Copying Hammerspoon profile."
ln -s $PWD/Hammerspoon/init.lua ~/.hammerspoon/init.lua
echo "OK"

# Copy Karabiner Profile.
echo "Copying Karabiner profile."
ln -s $PWD/Karabiner/karabiner.json ~/.config/karabiner/karabiner.json
echo "OK"

# Copy vim config.
echo "Copying vim config."
ln -s $PWD/Vim/vimrc ~/.vimrc
echo "OK"

# Copy Rectangle Profile.
echo "Copying Rectangle profile."
rm ~/Library/Preferences/com.knollsoft.Rectangle.plist
cp $PWD/Rectangle/com.knollsoft.Rectangle.plist ~/Library/Preferences/com.knollsoft.Rectangle.plist
echo "OK"

# Install Colorls
echo "Installing colorls."
gem install --user-install colorls
echo "OK"

# Check and install any remaining software updates.
echo "Checking for software updates:"
if softwareupdate -l 2>&1 | grep -q "No new software available."; then
  echo "OK"
else
  echo "Installing software updates:"
  sudo softwareupdate --install --all
  xcode_license
  echo "OK"
fi

git config --global user.name "Alex Bäuerle"
git config --global user.email alex@a13x.io

echo "Your system is now setup!"
echo "!!!"
echo "If the iTerm profile is incorrect, execute the following command:"
echo "cp Terminal/com.googlecode.iterm2.plist ~/Library/Preferences"
echo "!!!"
