# ctrl-left and ctrl-right should navigate words
function fish_user_key_bindings
  bind \cleft forward-word
  bind \cleft backward-word
end

# Source asdf files
source ~/.asdf/asdf.fish

# Open tmux by default (not recommended because sessions)
# test $TERM != "screen"; and exec tmux

###########
# ALIASES #
##########
alias top vtop
alias oldtop /usr/bin/top
alias config "/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

#########
# $PATH #
#########
set -x PATH $PATH ~/.android/tools
set -x PATH $PATH ~/.android/platforms

############
# ENV VARS #
############
set -x ANDROID_HOME ~/.android
