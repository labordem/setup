# Setup

## Getting started

```bash
git clone https://github.com/labordem/setup ~/Setup && cd ~/Setup
```

### Darwin (macOS)

Run each section sequentially or execute the entire script to set up a complete development environment.

```bash
# postinstall ---------------------------------------------------------------- #
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install jq
defaults write com.apple.dock "autohide" -bool "true"
defaults write com.apple.dock "show-recents" -bool "false"
defaults write com.apple.dock "static-only" -bool "true"
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"
defaults write com.apple.finder "AppleShowAllFiles" -bool "true"
defaults write com.apple.finder "ShowPathbar" -bool "true"
defaults write com.apple.finder "ShowStatusBar" -bool "true"
defaults write com.apple.finder "FXPreferredViewStyle" -string "clmv"
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"
defaults write com.apple.finder "FXDefaultSearchScope" -string "SCcf"
defaults write NSGlobalDomain "NSToolbarTitleViewRolloverDelay" -float "0"
defaults read NSGlobalDomain com.apple.mouse.scaling
defaults write NSGlobalDomain AppleKeyboardUIMode -int "2"
defaults write com.apple.systemsound "com.apple.sound.uiaudio.enabled" -int "0"

# tiling --------------------------------------------------------------------- #
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
brew install --cask nikitabobko/tap/aerospace
brew tap FelixKratz/formulae && brew install borders
mkdir -p ~/.config/aerospace
ln -sf ~/Setup/darwin/aerospace/aerospace.toml ~/.config/aerospace/aerospace.toml

# keyboard ------------------------------------------------------------------- #
brew install --cask qwerty-fr
defaults write -g InitialKeyRepeat -int 10 # = 150 ms, normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # = 15 ms, normal minimum is 2 (30 ms)

# fonts ---------------------------------------------------------------------- #
brew install --cask font-iosevka-nerd-font

# terminal ------------------------------------------------------------------- #
touch ~/.zshrc
ln -sf ~/Setup/shared/zsh/.zsh_aliases ~/.zsh_aliases
echo "source ~/.zsh_aliases" >> ~/.zshrc
brew install zsh-syntax-highlighting
echo "source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
brew install zsh-autosuggestions
echo "source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
brew install starship
echo '\n# starship\neval "$(starship init zsh)"\n' >> ~/.zshrc
mkdir -p ~/.config && touch ~/.config/starship.toml
ln -sf ~/Setup/shared/starship/starship.toml ~/.config/starship.toml

# sdks ----------------------------------------------------------------------- #
brew install vfox
echo '\n# vfox\neval "$(vfox activate zsh)"\n' >> ~/.zshrc

# ide ------------------------------------------------------------------------ #
brew cask install visual-studio-code
mkdir -p ~/Library/Application\ Support/Code/User/snippets
ln -sf ~/Setup/shared/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -sf ~/Setup/shared/vscode/global-snippets.code-snippets ~/Library/Application\ Support/Code/User/snippets/global-snippets.code-snippets
ln -sf ~/Setup/shared/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
cat ~/Setup/shared/vscode/settings.json | sed 's/^ *\/\/.*//' | jq -r '.["extensions.allowed"] | keys[]' | xargs -I {} code --install-extension {} --force

# git ------------------------------------------------------------------------ #
rm -f ~/.gitconfig
ln -sf ~/Setup/shared/git/.gitconfig ~/.gitconfig
```

### NixOS

```bash
sudo nixos-rebuild switch -I nixos-config=nixos/configuration.nix
```
