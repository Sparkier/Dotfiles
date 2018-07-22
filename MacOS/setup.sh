echo "Changing shell to zsh:"
chsh -s /bin/zsh

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

# Setup Homebrew directory and permissions.
echo "Installing Homebrew:"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Updating Homebrew:"
brew update

echo "Installing Brewfile software:"
brew bundle /Brew/Brewfile