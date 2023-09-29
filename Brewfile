# Taps
tap 'homebrew/cask'
tap 'homebrew/cask-fonts'
tap 'homebrew/cask-versions'
tap 'homebrew/bundle'

# Make sure apps get installed in system Applications dir
cask_args appdir: '/Applications'

# Install ZSH
brew 'zsh'
brew 'zsh-completions'

# Install GNU core utilities (those that come with OS X are outdated)
brew 'coreutils'

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew 'findutils'

# Install Bash 4
brew 'bash'

# Install mas, Mac App Store CLI, enabling us to brew App Store apps
brew 'mas'

# Install Binaries
brew 'git'
brew 'gh'
brew 'tree'
brew 'mackup'
brew 'trash'
brew 'wget'
brew 'yt-dlp'

# Apps
cask '1password'
cask 'aerial'
# TODO Choosy requires sudo. Disabling until I figure out why.
# cask 'choosy'
cask 'discord'
cask 'hazel'
cask 'keyboard-maestro'
cask 'launchbar'
cask 'multipass'
cask 'microsoft-edge'
cask 'nextcloud'
cask 'nvidia-geforce-now'
cask 'obsidian'
cask 'suspicious-package'
cask 'tor-browser'
cask 'vlc'
# TODO VMWare Fusion requires Terminal to have additional permissions, and thus installation fails. Disabling until I understand how to address this ahead of time.
# cask 'vmware-fusion'

# Mac App Store Apps
# You need to know the ID of the app; to get it, run the following command:
# mas search Bear (where "Bear" is the search string for the app you want). You 
# need the mas package installed for this, which is why we have the packages 
# listed first in the Brewfile.
mas "Things 3", id: 904280696
mas "1Password for Safari", id: 1569813296
mas "Amphetamine", id: 937984704
mas "BBEdit", id: 404009241
mas "Dark Reader for Safari", id: 1438243180
mas "Drafts", id: 1435957248
mas "Pixelmator Pro", id: 1289583905

# Quicklook
# These don't work with modern MacOS. Need to figure out alternatives.
# cask 'qlcolorcode'
# cask 'qlmarkdown'
# cask 'quicklook-json'
# cask 'quicklook-csv'
# cask 'qlstephen'

# Fonts
cask 'font-source-code-pro'
cask 'font-hack-nerd-font'
cask 'font-inconsolata-for-powerline'
cask 'font-menlo-for-powerline'
cask 'font-meslo-for-powerline'