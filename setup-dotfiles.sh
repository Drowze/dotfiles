#!/bin/sh

set -e

DOTFILES_PATH="$(dirname "$(realpath "$0")")"

# Create ~/.gitconfig.user
if ! test -e "$HOME/.gitconfig.user"; then
  cat <<EOF > "$HOME/.gitconfig.user"
[user]
  name = ${DOTFILES_GIT_USER:?}
  email = ${DOTFILES_GIT_EMAIL:?}
  signingkey = ${DOTFILES_GIT_SIGNING_KEY:?}
EOF
else
  echo "✅ '.gitconfig.user' (already exists)"
fi

# Create required directories
mkdir -p "$HOME/.config/fish/functions"
mkdir -p "$HOME/.tmux"
mkdir -p "$HOME/.local/bin/"

# receives on stdin a list of source/target pairs and creates symlinks accordingly
# list format: <source>/<target> (relative to "$HOME" and "dotfiles root" respectively)
create_symlinks() {
  while IFS= read -r file; do
    source="$(echo "$file" | cut -d";" -f1 | xargs)"
    target="$(echo "$file" | cut -d";" -f2 | xargs)"

    if test -z "$DOTFILES_PATH/$source"; then
      echo "❌ ERROR: SOURCE FILE NOT FOUND - $DOTFILES_PATH/$source" >/dev/stderr
      continue
    fi

    if test -e "$HOME/$target" && ! test -L "$HOME/$target"; then
      echo "❌ ERROR: TARGET FILE EXISTS AND IS NOT A SYMLINK - $HOME/$target" >/dev/stderr
      continue
    fi

    if test -L "$HOME/$target" && test "$(readlink "$HOME/$target")" = "$DOTFILES_PATH/$source"; then
      echo "✅ '$target'"
    elif test -L "$HOME/$target"; then
      echo "❗ '$target' symlink exists and points to a different location"
      echo "    ↳ '$(readlink "$HOME/$target")' (instead of '$DOTFILES_PATH/$source')"
    else
      ln -s "$DOTFILES_PATH/$source" "$HOME/$target"
      echo "✅ '$target' symlink created!"
    fi
  done
}

create_symlinks << EOF
  .jq;.jq
  .vimrc;.vimrc
  .tmux.conf;.tmux.conf
  .tmux/scripts;.tmux/scripts
  git_files/.gitmessage;.gitmessage
  git_files/.gitignore;.gitignore
  git_files/.gitconfig;.gitconfig
  .config/fish/config.fish;.config/fish/config.fish
  .config/fish/fish_plugins;.config/fish/fish_plugins
  .config/alacritty;.config/alacritty
  .config/nvim;.config/nvim
  .config/mise;.config/mise
  .default-gems;.default-gems
EOF

# macOS specific symlinks
if test "$(uname -s)" = "Darwin"; then
  create_symlinks << EOF
    .tmux-osx.conf;.tmux-osx.conf
    scripts/pbcopy-file/pbcopy-file;.local/bin/pbcopy-file
EOF
fi
