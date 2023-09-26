# Enables the use of the gitignore API from the command line.
# See https://docs.gitignore.io/use/command-line
function gi() { curl -sLw "\n" https://www.toptal.com/developers/gitignore/api/$@ ;}

# Activates zsh completions from homebrew
  if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
  fi