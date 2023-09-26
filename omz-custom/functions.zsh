# Enables the use of the gitignore API from the command line.
# See https://docs.gitignore.io/use/command-line
function gi() { curl -sLw "\n" https://www.toptal.com/developers/gitignore/api/$@ ;}
