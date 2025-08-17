# Setup

## Getting started

```bash
git clone https://github.com/labordem/setup ~/Setup && cd ~/Setup
```

### NixOS

```bash
sudo nixos-rebuild switch -I nixos-config=nixos/configuration.nix

# vscode --------------------------------------------------------------------- #
cat ~/Setup/shared/vscode/settings.json | sed 's/^ *\/\/.*//' | jq -r '.["extensions.allowed"] | keys[]' | xargs -I {} code --install-extension {} --force
```

### Darwin (macOS)

Run each section sequentially or execute the entire script to set up a complete development environment.

```bash
# postinstall ---------------------------------------------------------------- #
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install jq

# keyboard ------------------------------------------------------------------- #
brew install --cask qwerty-fr
defaults write -g InitialKeyRepeat -int 10 # = 150 ms, normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # = 15 ms, normal minimum is 2 (30 ms)

# git ------------------------------------------------------------------------ #
rm -f ~/.gitconfig
ln -sf ~/Setup/shared/git/.gitconfig ~/.gitconfig

# zsh ------------------------------------------------------------------------ #
touch ~/.zshrc
ln -sf ~/Setup/shared/zsh/.zsh_aliases ~/.zsh_aliases
echo "source ~/.zsh_aliases" >> ~/.zshrc
brew install zsh-syntax-highlighting
echo "source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
brew install zsh-autosuggestions
echo "source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc

# nerdfont ------------------------------------------------------------------- #
brew install --cask font-iosevka-nerd-font

# starship ------------------------------------------------------------------- #
brew install starship
mkdir -p ~/.config && touch ~/.config/starship.toml
ln -sf ~/Setup/shared/starship/starship.toml ~/.config/starship.toml

# languages ------------------------------------------------------------------ #
brew install mise
mise use -g node

# vscode --------------------------------------------------------------------- #
brew cask install visual-studio-code
mkdir -p ~/Library/Application\ Support/Code/User/snippets
ln -sf ~/Setup/shared/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -sf ~/Setup/shared/vscode/global-snippets.code-snippets ~/Library/Application\ Support/Code/User/snippets/global-snippets.code-snippets
ln -sf ~/Setup/shared/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
cat ~/Setup/shared/vscode/settings.json | sed 's/^ *\/\/.*//' | jq -r '.["extensions.allowed"] | keys[]' | xargs -I {} code --install-extension {} --force

# aerospace ------------------------------------------------------------------ #
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
brew install --cask nikitabobko/tap/aerospace
brew tap FelixKratz/formulae && brew install borders
mkdir -p ~/.config/aerospace
ln -sf ~/Setup/darwin/aerospace/aerospace.toml ~/.config/aerospace/aerospace.toml
```
