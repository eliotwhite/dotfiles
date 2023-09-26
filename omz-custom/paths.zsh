# Load custom commands
export PATH="$DOTFILES/bin:$PATH"

# Local bin directories before anything else
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# Multipass bin for aliases
export PATH="$PATH:$HOME/Library/Application Support/multipass/bin"

# To use the coreutils and findutils commands (installed via homebrew) with their normal 
# names -- i.e., without the 'g' prefix that homebrew installs them with -- we add 
# their respective "gnubin" directories to the PATH
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/findutils/libexec/gnubin:$PATH"