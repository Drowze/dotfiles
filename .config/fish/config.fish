function fish_greeting
  fish_logo
end

set -l is_mac
if test (uname -s) = "Darwin"
  set is_mac "yes"
end

# configuations for `fish_git_prompt`
set __fish_git_prompt_showcolorhints true
set __fish_git_prompt_showdirtystate true

# NOTE: fish-async-prompt sources this file in a non-interactive shell
if status is-interactive
  # do not clear prompt on ctrl-c
  bind ctrl-c cancel-commandline
end

if test -f ~/.config/fish/functions/oh_helpers.fish
  source ~/.config/fish/functions/oh_helpers.fish
end

# source mise
if status is-interactive && test -x ~/.local/bin/mise
  # NOTE: the default activation modifies $PATH with the bin directory for each installed tool, which results in a very long $PATH
  # in future we may want to switch to using shims (in case the very long $PATH end up causing issues)
  # ~/.local/bin/mise activate fish --shims | source
  ~/.local/bin/mise activate fish | source
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

if type -q bat
  set -x BAT_PAGER 'less --silent --raw-control-chars' # disable bell & preserve colors
  set -x MANPAGER 'col -bx | bat --language=man --plain' # NOTE: `col -bx` is needed to remove legacy unix formatting chars (which confuses bat)
  # set -x MANROFFOPT '-c'
end

if type -q eza
  alias exa eza
end

if type -q fzf && type -q bat && type -q rg && type -q nvim
  function rgopen
    rg --no-heading --line-number $argv | cut -d':' -f1-2 | sort | fzf --multi --delimiter=: --preview "bat --color=always {1}" | xargs nvim -
  end
end

#########
# $PATH #
#########
if test -d $HOME/.android/cmdline-tools
  fish_add_path $HOME/.android/cmdline-tools/tools/bin
  set -x ANDROID_SDK_ROOT $HOME/.android
  set -x ANDROID_HOME $HOME/.android
end
if test -d $HOME/.android/emulator
  fish_add_path $HOME/.android/emulator
  fish_add_path $HOME/.android/platform-tools
end

###########
# PLUGINS #
###########
# global default options `fzf`
set -x FZF_DEFAULT_OPTS --cycle --layout=reverse --border --height=40% --preview-window=wrap --marker="*" \
  --bind ctrl-j:preview-down \
  --bind ctrl-d:preview-page-down \
  --bind ctrl-k:preview-up \
  --bind ctrl-u:preview-page-up

# configurations for `fzf.fish` (fish plugin)
set fzf_fd_opts --hidden --no-ignore --exclude '{.git,.ruby-lsp,node_modules,/tmp/,/coverage/}'
if status is-interactive && type -q fzf_configure_bindings
  # keybindings:
  # - ctrl-s for searching files on `git status`
  # - ctrl-g for searching commits on `git log`
  # - ctrl-o for searching files/directories on current working directory
  # - ctrl-r for searching thru the command history
  # - ctrl-alt-p for searching a PID thru the process list
  fzf_configure_bindings --git_status=\cs --git_log=\cg --variables --directory=\co
end

############
# ENV VARS #
############
set -x VISUAL nvim
set -x EDITOR $VISUAL
set -x LC_CTYPE en_US.UTF-8
set -x LC_ALL en_US.UTF-8
if type -q mssql-cli
  set -x MSSQL_CLI_TELEMETRY_OPTOUT 1
end
if type -q copilot
  # data can be viewed with `npx tokscale@latest`
  set -x COPILOT_OTEL_FILE_EXPORTER_PATH "$HOME/.copilot/otel/copilot-otel-$(date +%Y%m%d-%H%M%S).jsonl"
end
if type -q usql
  set -x USQL_CONFIG "$HOME/.config/usql/config.yaml" # usql ignores xdg directories in macos, so let's force it
end
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

  if isatty stdin
    set -x GPG_TTY (tty) # fix gpg in mac-os
  end
end
# credentials
if test -f $HOME/.config/fish/secrets.fish
  source $HOME/.config/fish/secrets.fish
end
