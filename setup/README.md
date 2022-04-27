# Setup

1. If MacOS: install homebrew
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

2. Install keepassxc, gpg, rg, fd, fzf, font-hack, jq, alacritty
```bash
brew tap homebrew/cask-fonts
brew install gpg rg fd fzf font-hack, jq
brew install --cask keepassxc alacritty
```

3. Download keepass db to ~/database.kdbx

4. Setup ssh and gpg
```bash
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
```

5. Install fish
```bash
brew install fish
chsh -s $(which fish)
which fish | sudo tee -a /etc/shells
```

6. Install fisher
```bash
fish
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
```

7. Install asdf, asdf-python, latest python, ansible
```bash
# asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.0
echo "source ~/.asdf/asdf.fish" >> ~/.config/fish/config.fish
mkdir -p ~/.config/fish/completions
ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions
source ~/.config/fish/config.fish

# asdf-python, python, ansible
asdf plugin add python
asdf install python 3.10.4
asdf global python 3.10.4
pip install ansible
asdf reshim python
```

8. Create valid setup/vars.yml according setup/vars.yml.sample

9. Install dotfiles
```bash
git clone git@github.com:Drowze/dotfiles.git ~/dotfiles
cd dotfiles
ansible-playbook setup/setup_dotfiles.yml
```
