# ctrl-left and ctrl-right should navigate words
# may be required in some terminal emulators (e.g.: terminator)
function fish_user_key_bindings
  bind \cleft forward-word
  bind \cleft backward-word
end

# Source asdf files
source ~/.asdf/asdf.fish

###########
# ALIASES #
###########
if type vtop >/dev/null ^/dev/null; alias top vtop; alias oldtop /usr/bin/top; end
# alias restart-network "sudo service network-manager restart"

#########
# $PATH #
#########


############
# ENV VARS #
############
set -x VISUAL vim
set -x EDITOR $VISUAL
