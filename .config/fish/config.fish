function fish_greeting
  fish_logo
end

set -l is_mac
set -l mac_brew_dir
if test (uname -s) = "Darwin"
  set is_mac "yes"
  set mac_brew_dir (brew --prefix)
end

# fish-async-prompt sources this file in a non-interactive shell
set -l is_interactive
if status is-interactive
  set is_interactive "yes"
end

# do not clear prompt on ctrl-c
bind ctrl-c cancel-commandline

if test -f ~/.config/fish/functions/oh_helpers.fish
  source ~/.config/fish/functions/oh_helpers.fish
end

# source mise & setup shell completion
if test "$is_interactive" = "yes" && test -f ~/.local/bin/mise
  ~/.local/bin/mise activate fish | source
  mise completion fish | source
end

# Feature flags
set -U fish_features qmark-noglob # disable globbing with '?' so e.g.: `open http://example.com?foo=bar` works

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
  alias nvimdiff "nvim -d"
end

if type -q bundle
  alias be "bundle exec"
end

if type -q kubectl
  alias k kubectl
end

if type -q fzf && type -q bat && type -q rg && type -q nvim
  function rgopen
    rg --no-heading --line-number $argv | cut -d':' -f1-2 | sort | fzf --multi --delimiter=: --preview "bat --color=always {1}" | xargs nvim -
  end
end

#########
# $PATH #
#########
if test -d $HOME/.yarn/bin
  fish_add_path $HOME/.yarn/bin
end
if test -d $HOME/.android/cmdline-tools
  fish_add_path $HOME/.android/cmdline-tools/tools/bin
  set -x ANDROID_SDK_ROOT $HOME/.android
  set -x ANDROID_HOME $HOME/.android
end
if test -d $HOME/.android/emulator
  fish_add_path $HOME/.android/emulator
  fish_add_path $HOME/.android/platform-tools
end
if test -d $HOME/go/bin
  fish_add_path $HOME/go/bin
end

if test "$is_mac" = "yes"
  if test -d $mac_brew_dir/opt/mongodb-community@4.2/bin
    fish_add_path $mac_brew_dir/opt/mongodb-community@4.2/bin
  end
end

###########
# PLUGINS #
###########
# fzf fish; keybindings: ctrl-s, ctrl-g, ctrl-o, ctrl-r ctrl-alt-p
if type -q fzf_configure_bindings
  fzf_configure_bindings --git_status=\cs --git_log=\cg --variables --directory=\co
end
set -x FZF_DEFAULT_OPTS '--cycle --layout=reverse --border --height=40% --preview-window=wrap --marker="*" --bind "ctrl-j:preview-down,ctrl-k:preview-up"'
set fzf_fd_opts --hidden --no-ignore --exclude '.git' --exclude 'node_modules' --exclude '/public/' --exclude '/tmp/' --exclude '/coverage/'

############
# ENV VARS #
############
set -x VISUAL nvim
set -x EDITOR $VISUAL
set -x LC_CTYPE en_US.UTF-8
set -x LC_ALL en_US.UTF-8
# mssql-cli
set -x MSSQL_CLI_TELEMETRY_OPTOUT 1
# ruby/rails
set -x DISABLE_SPRING true
set -x RUBY_DEBUG_IRB_CONSOLE true
set -x BAT_THEME Dracula
# fzf.vim cmd
set -x FZF_DEFAULT_COMMAND "fd --type=file --strip-cwd-prefix $fzf_fd_opts"
# mac specific
if test "$is_mac" = yes
  set -x OBJC_DISABLE_INITIALIZE_FORK_SAFETY YES
  set -x HOMEBREW_NO_AUTO_UPDATE 1
  set -x GPG_TTY (tty) # fix gpg in mac-os
  set -x PGGSSENCMODE disable # see: https://github.com/ged/ruby-pg/issues/538
end
# credentials
if test -f $HOME/.config/fish/secrets.fish
  source $HOME/.config/fish/secrets.fish
end
