function fish_greeting
  fish_logo
end

# Source asdf files
if test -e ~/.asdf/asdf.fish
  source ~/.asdf/asdf.fish
end

# Source default database authentication details
if test -e ~/.mssql-cli/default.fish
  source ~/.mssql-cli/default.fish
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
if test -d $HOME/.android/cmdline-tools
  set -x PATH $HOME/.android/cmdline-tools/tools/bin $PATH
  set -x ANDROID_SDK_ROOT $HOME/.android
  set -x ANDROID_HOME $HOME/.android
end
if test -d $HOME/.android/emulator
  set -x PATH $HOME/.android/emulator $PATH
  set -x PATH $HOME/.android/platform-tools $PATH
end

############
# ENV VARS #
############
set -x VISUAL vim
set -x EDITOR $VISUAL
set -x HOMEBREW_NO_AUTO_UPDATE 1
set -x MSSQL_CLI_TELEMETRY_OPTOUT 1
set -x LC_CTYPE en_US.UTF-8
set -x LC_ALL en_US.UTF-8
set -x FZF_DEFAULT_COMMAND 'rg --files'
