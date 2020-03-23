# ctrl-left and ctrl-right should navigate words
# may be required in some terminal emulators (e.g.: terminator)
#function fish_user_key_bindings
#  bind \cleft forward-word
#  bind \cleft backward-word
#end

# Source asdf files
if test -e ~/.asdf/asdf.fish
  source ~/.asdf/asdf.fish
end

###########
# ALIASES #
###########
if type -q vtop
  alias top vtop
  alias oldtop /usr/bin/top
end

if type -q pry && test -e ~/.asdf/shims/irb
  alias _irb ~/.asdf/shims/irb
  alias irb pry
end

alias restart-network "sudo service network-manager restart"

#########
# $PATH #
#########

if test -d $HOME/.config/yarn/global/node_modules/.bin
  set -x PATH $HOME/.config/yarn/global/node_modules/.bin $PATH
end
if test -d $HOME/.yarn/bin
  set -x PATH $HOME/.yarn/bin $PATH
end

############
# ENV VARS #
############
set -x VISUAL vim
set -x EDITOR $VISUAL
set -x HOMEBREW_NO_AUTO_UPDATE 1
set -x LC_CTYPE en_US.UTF-8
set -x LC_ALL en_US.UTF-8
