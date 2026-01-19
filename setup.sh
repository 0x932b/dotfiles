DOTFILES_PATH="${1:-$HOME/.dotfiles}"

if [ -d "$DOTFILES_PATH" ]; then
    echo "Directory $DOTFILES_PATH already exists. Skipping clone."
else
    git clone https://github.com/u932b/dotfiles.git "$DOTFILES_PATH"
fi

cd "$DOTFILES_PATH"
./install
