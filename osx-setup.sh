###############################################################################
# Computer Settings                                                           #
###############################################################################
echo "Setup computer name"
sudo scutil --set ComputerName "erebos"
sudo scutil --set HostName "erebos"
sudo scutil --set LocalHostName "erebos"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "erebos"

#echo "Disable the 'Are you sure you want to open this application?' dialog"
#defaults write com.apple.LaunchServices LSQuarantine -bool false

echo "Enable repeat on keydown"
defaults write -g ApplePressAndHoldEnabled -bool false

echo "Show Path bar in Finder"
defaults write com.apple.finder ShowPathbar -bool true

echo "Show Status bar in Finder"
defaults write com.apple.finder ShowStatusBar -bool true

#echo "Set a fast keyboard repeat rate"
#defaults write NSGlobalDomain KeyRepeat -int 0.02

#echo "Set a shorter Delay until key repeat"
#defaults write NSGlobalDomain InitialKeyRepeat -int 12

echo "Show the ~/Library folder"
chflags nohidden ~/Library

echo "set git config values"
git config --global user.name "Dmitri Sotnikov" && \
git config --global user.email "dmitri.sotnikov@gmail.com" && \
git config --global github.user yogthos && \
git config --global color.ui true

###############################################################################
# Install Applications                                                        #
###############################################################################

# Install XCODE Command Line Tools
#xcode-select --install

# Install Homebrew
echo "Installing Homebrew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install Homebrew Apps
echo "Installing Homebrew Command Line Tools"
brew install \
leiningen \
fish \
node \
tree \
wget \

brew tap caskroom/cask

echo "Installing Apps"
sudo brew cask install \
google-chrome \
firefox \
gitkraken \
obs \
steam \
macdown \
google-drive \
cleanmymac \
iterm2

@echo "Cleaning Up Cask Files"
sudo brew cask cleanup
