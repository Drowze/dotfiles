# Setup

1. If MacOS: install homebrew
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

2. Install utilities
```bash
# if on MacOS
brew tap homebrew/cask-fonts
brew install fish
fish
brew install gpg rg fd fzf tmux font-hack-nerd-font jq yq gh htop bat tree axel tig wget nvim ruby-install chruby-fish docker docker-buildx docker-compose colima kubectl gsed shellcheck
brew tap ankitpokhrel/jira-cli # work specific
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

7. Install asdf, asdf-python, latest python, ansible
```bash
# asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
echo "source ~/.asdf/asdf.fish" >> ~/.config/fish/config.fish
mkdir -p ~/.config/fish/completions
ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions
source ~/.config/fish/config.fish

# asdf-python, python, ansible
asdf plugin add python
set -l latest_python (asdf list-all python | grep -E '^(\d|\.)+$' | tail -n1)
asdf install python $latest_python
asdf global python $latest_python
pip install ansible
asdf reshim python
```

8. Install dotfiles
```bash
git clone git@github.com:Drowze/dotfiles.git ~/dotfiles
cd dotfiles
# Create valid setup/vars.yml according setup/vars.yml.sample
ansible-playbook setup/setup_dotfiles.yml
fisher update
```
