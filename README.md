# Setup

1. If MacOS: install homebrew
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

2. Install utilities
```bash
# if on MacOS
brew tap homebrew/cask-fonts
brew tap ankitpokhrel/jira-cli # work specific
brew install fish
fish # enter in fish, so brew setup shell-specific stuff for fish
brew install gpg rg fd fzf tmux font-hack-nerd-font jq yq gh htop bat tree axel tig wget docker docker-buildx docker-compose colima kubectl gsed shellcheck coreutils
brew install az jira-cli cloudflared Azure/kubelogin/kubelogin # work specific
brew install --cask --no-quarantine font-hack-nerd-font brave-browser keepassxc alacritty spotify slack zoom rectangle alt-tab

mkdir -p ~/.docker/cli-plugins
ln $(brew --prefix docker-compose)/bin/docker-compose ~/.docker/cli-plugins/docker-compose

# if on Ubuntu
# TODO
```

3. Download keepass db to ~/database.kdbx

4. Setup ssh and gpg
```bash
# then
database=$HOME/database.kdbx
ssh_entry="SSH"
gpg_entry="GPG"
mkdir -p ~/.ssh
keepassxc-cli attachment-export $database $ssh_entry config ~/.ssh/config
keepassxc-cli attachment-export $database $ssh_entry id_ed25519 ~/.ssh/id_ed25519
keepassxc-cli attachment-export $database $ssh_entry id_ed25519.pub ~/.ssh/id_ed25519.pub
keepassxc-cli attachment-export $database $gpg_entry backupkeys.pgp backupkeys.pgp
gpg --import-options restore --import backupkeys.pgp
rm backupkeys.pgp

# then, to make gpg key valid again (if needed):
https://gist.github.com/TheSherlockHomie/a91d3ecdce8d0ea2bfa38b67c0355d00
```

5. Make fish default shell
```bash
which fish | sudo tee -a /etc/shells
chsh -s $(which fish)
```

6. Install fisher
```bash
fish
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
```

7. Install mise, neovim and some programming languages
```bash
curl https://mise.run | sh
~/.local/bin/mise plugin install neovim https://github.com/richin13/asdf-neovim
~/.local/bin/mise use -g neovim@nightly go@latest node@latest python@latest ruby@latest rust@latest usage@latest
```

8. Install dotfiles
```bash
git clone git@github.com:Drowze/dotfiles.git ~/dotfiles
~/dotfiles/setup-dotfiles.sh
source ~/.config/fish/config.fish
fisher update
```
