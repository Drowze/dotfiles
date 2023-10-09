function fish_greeting
  fish_logo
end

# Direnv
if type -q direnv
  direnv hook fish | source

  # direnv is too verbose... this should suppress all logging
  set -gx DIRENV_LOG_FORMAT ""
end

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

if type -q pry && test -e $HOME/asdf/shims/irb
  alias _irb $HOME/.asdf/shims/irb
  alias irb pry
end

if type -q nvim
  alias vi nvim
end

if type -q bundle
  alias be "bundle exec"
end

if type -q kubectl
  alias k kubectl
end

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

###########
# PLUGINS #
###########
# fzf fish; keybindings: ctrl-s, ctrl-g, ctrl-o, ctrl-r ctrl-alt-p
if type -q fzf_configure_bindings
  fzf_configure_bindings --git_status=\cs --git_log=\cg --variables --directory=\co
end
set -gx FZF_DEFAULT_OPTS '--cycle --layout=reverse --border --height=40% --preview-window=wrap --marker="*" --bind "ctrl-j:preview-down,ctrl-k:preview-up"'
set fzf_fd_opts --hidden --no-ignore --exclude '.git' --exclude 'node_modules' --exclude '/public/' --exclude '/tmp/' --exclude '/coverage/'

############
# ENV VARS #
############
set -gx VISUAL vim
set -gx EDITOR $VISUAL
set -gx LC_CTYPE en_US.UTF-8
set -gx LC_ALL en_US.UTF-8
# mssql-cli
set -gx MSSQL_CLI_TELEMETRY_OPTOUT 1
# ruby/rails
set -gx DISABLE_SPRING true
set -gx BAT_THEME Dracula
# fzf.vim cmd
set -gx FZF_DEFAULT_COMMAND "fd --type=file --strip-cwd-prefix $fzf_fd_opts"
# mac specific
set -gx HOMEBREW_NO_AUTO_UPDATE 1
# credentials
if test -f $HOME/.config/fish/secrets.fish
  source $HOME/.config/fish/secrets.fish
end
