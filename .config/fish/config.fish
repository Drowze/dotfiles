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

if type -q pry && test -e $HOME/asdf/shims/irb
  alias _irb $HOME/.asdf/shims/irb
  alias irb pry
end

alias be "bundle exec"

alias restart-network "sudo service network-manager restart"

#########
# $PATH #
#########

if test -d $HOME/.config/yarn/global/node_modules/.bin
  fish_add_path $HOME/.config/yarn/global/node_modules/.bin
end
if test -d $HOME/.yarn/bin
  fish_add_path $HOME/.yarn/bin
end
if test -d $HOME/.android/cmdline-tools
  fish_add_path $HOME/.android/cmdline-tools/tools/bin
  set -gx ANDROID_SDK_ROOT $HOME/.android
  set -gx ANDROID_HOME $HOME/.android
end
if test -d $HOME/.android/emulator
  fish_add_path $HOME/.android/emulator
  fish_add_path $HOME/.android/platform-tools
end
if test -d /usr/local/opt/mongodb-community@4.2/bin
  fish_add_path "/usr/local/opt/mongodb-community@4.2/bin"
end

############
# ENV VARS #
############
set -gx VISUAL vim
set -gx EDITOR $VISUAL
set -gx LC_CTYPE en_US.UTF-8
set -gx LC_ALL en_US.UTF-8
set -gx MSSQL_CLI_TELEMETRY_OPTOUT 1
set -gx DISABLE_SPRING true
# fzf.vim cmd
set -gx FZF_DEFAULT_COMMAND "rg --files --hidden"
set -gx FZF_LEGACY_KEYBINDINGS 0
# fzf fish cmd
set -gx FZF_FIND_FILE_COMMAND "rg --files --hidden"
# mac specific
set -gx HOMEBREW_NO_AUTO_UPDATE 1
