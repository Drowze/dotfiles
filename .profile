# ~/.profile: executed by the command interpreter for login shells.
# Not read by bash(1), if ~/.bash_profile or ~/.bash_login exists.
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Random wallpaper
wget -q --tries=10 --timeout=20 --spider http://google.com
if [[ $? -eq 0 ]]; then
  ruby ~/.wallpaper/wallhaven.rb '/search?q="minimalism"&sorting=random&atleast=1920x1080' 2
else
  feh --randomize --bg-fill ~/.wallpaper/*
fi
