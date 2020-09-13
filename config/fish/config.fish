###
# Exports
###
if test -z $TMUX; set -x TERM 'xterm-256color'; end

set -x FISH_CONF_PATH "$HOME/.config/fish"

# Set prompt
source $FISH_CONF_PATH/prompts/agnoster.fish

###
# Import main config
###
source $FISH_CONF_PATH/baserc.fish
source $FISH_CONF_PATH/fedora.fish
