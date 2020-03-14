# Ask for the administrator password upfront.
sudo -v

##########################
### Get info from user ###
##########################
computer_name=' '
user_name=' '
user_email=' '

echo -n "What would you like your computer to be known as on the network? ex:Joe's Macbook  "
read computer_name

echo -n 'What is your name? (This is just for git)  '
read user_name

echo -n 'What is your email address? (Again, just for git)  '
read user_email

echo -n 'allow running unsigned executables'
sudo spctl --master-disable

#########################
### Install XCode CLI ###
#########################

if ! xcode-select --print-path &> /dev/null; then

    # Prompt user to install the XCode Command Line Tools
    xcode-select --install &> /dev/null

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Wait until the XCode Command Line Tools are installed
    until xcode-select --print-path &> /dev/null; do
        sleep 5
    done

    print_result $? 'Install XCode Command Line Tools'

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Point the `xcode-select` developer directory to
    # the appropriate directory from within `Xcode.app`
    # https://github.com/alrra/dotfiles/issues/13

    sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
    print_result $? 'Make "xcode-select" developer directory point to Xcode'

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Prompt user to agree to the terms of the Xcode license
    # https://github.com/alrra/dotfiles/issues/10

    sudo xcodebuild -license
    print_result $? 'Agree with the XCode Command Line Tools licence'

fi



#######################################
### Change ownership of /usr/local/ ###
#######################################

echo '*** gaining ownership of /usr/local/ ***'
sudo chmod a+w /usr/local/

## disable gatekeeper 
# sudo spctl --master-disable

## disable local time machine backups
echo '*** disabling local time machine backups ***'
sudo tmutil disablelocal

##############################
### Software Installations ###
##############################

echo '*** install homebrew ***'
ruby -e "$(curl -#fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile

echo '*** install coreutils ***'
brew install coreutils

echo '*** install m-cli ***'
brew install m-cli

echo '*** install bat ***'
brew install bat

echo '*** install imagemagick ***'
brew install imagemagick

echo '*** install brew cask ***'
brew install caskroom/cask/brew-cask

echo '*** install thefuck ***'
brew install thefuck

echo '*** install node/npm ***'
brew install node

echo '*** install lumo ***'
brew install lumo

echo '*** install clj-kondo ***'
brew install borkdude/brew/clj-kondo

echo '*** install tree ***'
brew install tree

echo '*** install wget ***'
brew install wget

echo '*** install osquery ***'
brew install osquery

echo '*** install icdiff ***'
brew install icdiff

echo '*** install ffmpeg ***'
brew install ffmpeg --with-fdk-aac

echo '*** install gifsicle ***'
brew install gifsicle

echo '*** install nodemon ***'
npm install -g nodemon

echo '*** install git ***'
brew install git

echo '*** install fish ***'
brew install fish

echo '*** install fisher ***'
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

echo '*** install kubectl completions for fish ***'
fisher add evanlucas/fish-kubectl-completions

echo '*** install httpie ***'
brew install httpie

echo '*** install rlwrap ***'
brew install rlwrap

echo '*** install youtube-dl ***'
brew install youtube-dl

echo '*** install openconnect ***'
brew install openconnect

echo '*** change default cask install location to ~/Applications ***'
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

echo '*** install kap screen capture app ***'
brew cask install kap

echo '*** install google chrome ***'
brew cask install google-chrome

echo '*** install chromium ***'
brew cask install chromium

echo '*** install notable ***'
brew cask install notable

echo '*** install darktable ***'
brew cask install darktable

echo '*** install digikam ***'
brew cask install digikam

echo '*** install google drive ***'
brew cask install google-drive

echo '*** install shotcut video editor ***'
brew cask install shotcut

echo '*** install Java ***'
brew cask install java

echo '*** install GraalVM ***'
brew cask install graalvm/tap/graalvm-ce-java11

echo '*** install Clojure ***'
brew install clojure/tools/clojure

echo '*** install babashka ***'
brew install borkdude/brew/babashka

echo '*** install OnionShare ***'
brew cask install onionshare

echo '*** install IntelliJ ***'
brew cask install intellij-idea

echo '*** install VSCodium ***'
brew cask install vscodium

echo '*** install transmission ***'
brew cask install transmission

echo '*** install YAC Comic Reader ***'
brew cask install yacreader

echo '*** install iterm2 ***'
brew cask install iterm2

echo '*** install Maven ***'
brew install maven

echo '*** install Leiningen ***'
brew install leiningen

echo '*** install midnight commander ***'
brew install mc

echo '*** install htop ***'
brew install htop

echo '*** install slack ***'
brew cask install slack

echo '*** install skype ***'
brew cask install skype

echo '*** install steam ***'
brew cask install steam

echo '*** install flux ***'
brew cask install flux

echo '*** install keka ***'
brew cask install keka

echo '*** install scroll reverser ***'
brew cask install scroll-reverser

echo '*** install vlc ***'
brew cask install vlc

echo '*** install firefox ***'
brew cask install firefox

ecbo '*** install Areal screensaver ***'
brew cask install aerial

# echo '*** install dropbox ***'
# brew cask install dropbox

echo '*** install cakebrew ***'
brew cask install cakebrew

echo '*** install sublime text 3 ***'
# brew tap caskroom/versions
# brew cask install sublime-text3

echo '*** install OpenArena ***'
brew cask install openarena

echo '*** cleaning up cask installs ***'
brew cask cleanup

echo '*** install quick-look plugins ***'
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook

## docker
#echo '*** install ctop ***'
# brew install ctop

echo '*** install lazydocker ***'
brew tap jesseduffield/lazydocker
brew install lazydocker

#########################
### Computer Settings ###
#########################

# Set computer name
echo '*** set computer name ***'
sudo scutil --set ComputerName $computer_name
sudo scutil --set HostName $computer_name
sudo scutil --set LocalHostName $computer_name
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $computer_name

# Set standby delay to 24 hours
# echo '*** set standby delay ***'
# sudo pmset -a standbydelay 86400

# Disable the warning before emptying the Trash
# echo '*** disable warning before emptying the trash ***'
# defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Show the ~/Library folder
echo '*** show the ~/Library folder ***'
chflags nohidden ~/Library

# Speed up Mission Control animations
echo '*** speed up mission control animations ***'
defaults write com.apple.dock expose-animation-duration -float 0.2

# Prevent Time Machine from prompting to use new hard drives as backup volume
echo '*** stop time machine from asking about new drives ***'
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable Dashboard
echo '*** disable dashboard ***'
defaults write com.apple.dashboard mcx-disabled -bool true

# Make Dock icons of hidden applications translucent
echo '*** make hidden app icons translucent ***'
defaults write com.apple.dock showhidden -bool true

# Disable the Launchpad gesture (pinch with thumb and three fingers)
echo '*** disable launchpad gesture ***'
defaults write com.apple.dock showLaunchpadGestureEnabled -int 0

# Add the keyboard shortcut ⌘ + Enter to send an email in Mail.app
# echo '*** add the keyboard shortcut ⌘ + Enter to send an email ***'
# defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" -string "@\\U21a9"

# Disable prompt when quitting iterm2
# echo '*** Disable prompt when quitting iterm2 ***'
# defaults write com.googlecode.iterm2 PromptOnQuit -bool false

# Don’t automatically rearrange Spaces based on most recent use
echo '*** stop automatically rearranging spaces based on time ***'
defaults write com.apple.dock mru-spaces -bool false

# Menu bar: hide the Time Machine and User icons
# echo '*** hide the time machine and user icons from the menu bar ***'
# for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
#   defaults write "${domain}" dontAutoLoad -array \
#     "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
#     "/System/Library/CoreServices/Menu Extras/User.menu"
# done

# Set sidebar icon size to medium
echo '*** set sidebar icons in finder to medium size ***'
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

# expand save prompt
echo '*** expand save prompt ***'
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# quit printer app when there are no pending jobs
echo '*** quit printer app when there are no pending jobs ***'
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# check for updates daily
echo '*** check for Apple updates daily ***'
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# disable smart quotes, auto-correct spelling, and smart dashes
echo '*** disable smart quotes, auto-correct spelling, and smart dashes ***'
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# prevent Photos from opening when inserting external media
echo '*** prevent photos from opening when instering drives ***'
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# sets clock to 24-hour mode
echo '*** set clock to 24-hour mode ***'
defaults write NSGlobalDomain AppleICUForce24HourTime -bool true

# disable hibernate
# echo '*** disable hibernate ***'
# sudo pmset -a hibernatemode 0

# disable sudden motion sensor
# echo '*** disable the sudden motion sensor ***'
# sudo pmset -a sms 0

# increase Bluetooth sound quality
# echo '*** increase bluetooth sound quality ***'
# defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# disable press-and-hold for special keys
echo '*** disable special key press-and-hold ***'
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# increase key repeat rate
# echo '*** increase key repeat rate ***'
# defaults write NSGlobalDomain KeyRepeat -int 0

# disable auto-brightness on keyboard and screen
# echo '*** disable auto-brightness ***'
# sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor "Automatic Keyboard Enabled" -bool false
# sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor "Automatic Display Enabled" -bool false

# create folder for screenshots in documents
# echo '*** create folder for screenshots in documents ***'
# defaults write com.apple.screencapture location -string "${HOME}/Documents/screenshots"

# enable hidpi mode
# echo '*** enable hidpi ***'
# sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

# enable font rendering on non-apple displays
echo '*** enable font rendering on non-apple displays ***'
defaults write NSGlobalDomain AppleFontSmoothing -int 2

# show full path in finder
echo '*** show full path in finder ***'
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# disable warning when changing file extension
echo '*** disable warning when changing file extension ***'
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# disable .DS_Store on network drives
echo '*** prevent creation of .DS_Store on network drives ***'
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# enable snap to grid for desktop and icon view
echo '*** enable snap to grid ***'
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# set column view as default
echo '*** set column view as default in finder ***'
defaults write com.apple.finder FXPreferredViewStyle Clmv

# set dock icons to 48px
echo '*** set dock icons to 48px ***'
defaults write com.apple.dock tilesize -int 48

# disable focus ring
# echo '*** disable focus ring ***'
# defaults write NSGlobalDomain NSUseAnimatedFocusRing -bool false

# reformat copying email addresses
# echo '*** reformat copying email addresses in mail.app ***'
# defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# show battery percentage
echo '*** show battery percentage ***'
defaults write com.apple.menuextra.battery ShowPercent -string "NO"

#disable gatekeeper
# echo '*** disable gatekeeper ***'
# sudo spctl --master-disable

# disable npm progress bar (doubles install speed)
# echo '*** disable npm progress bar ***'
# npm set progress=false

# set tap-to-click
# echo '*** enable tap-to-click ***'
# defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1

# change crash reporter to notification
# echo '*** change crash reporter to notification ***'
# defaults write com.apple.CrashReporter UseUNC 1

# create global .gitignore
echo '*** create global .gitignore ***'
curl -# https://raw.githubusercontent.com/yogthos/env-init/0e8e5dba1f66b9af1e0d0f6a0df019c47915d89c/gitignore > ~/.gitignore

# set git user info and credentials
echo '*** set git user info and credentials ***'
git config --global user.name $user_name
git config --global user.email $user_email
git config --global credential.helper osxkeychain
git config --global push.default current
git config --global pull.default current

# update PATH
echo '*** update path ***'
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile

# Disable local Time Machine snapshots
# echo '*** disable local time machine snapshots ***'
# sudo tmutil disablelocal



#############################
### Transmission Settings ###
#############################

# setup folder for incomplete torrents
echo '*** set up folder for incomplete torrents ***'
mkdir -p ~/Downloads/torrents
defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
defaults write org.m0k.transmission IncompleteDownloadFolder -string "${HOME}/Downloads/torrents"

# hide donate message
echo '*** hide transmission donate message ***'
defaults write org.m0k.transmission WarningDonate -bool false

# hide legal warning
echo '*** hide transmission legal warning ***'
defaults write org.m0k.transmission WarningLegal -bool false

# auto resize window
# echo '*** auto resize transmission window ***'
# defaults write org.m0k.transmission AutoSize -bool true

# setting block-list
echo '*** set up transmission block-list ***'
defaults write org.m0k.transmission EncryptionRequire -bool true
defaults write org.m0k.transmission BlocklistAutoUpdate -bool true
defaults write org.m0k.transmission BlocklistNew -bool true
defaults write org.m0k.transmission BlocklistURL -string "http://john.bitsurge.net/public/biglist.p2p.gz"

