# Setup

This repository contains all my dotfiles, configurations, and setup scripts to quickly bootstrap a clean, consistent, and reproducible development environment.

## macOS

### Getting started

Clone the repository into your `HOME` directory (`~`):

```bash
git clone https://github.com/labordem/setup ~/Setup && cd ~/Setup
```

### Env

```bash
mkdir -p ~/.config
ln -sf ~/Setup/shared/.zshenv ~/.zshenv
exec zsh
```

### Update macOS

```bash
sudo softwareupdate --install --all
```

> If Xcode is not installed run: `sudo softwareupdate --install Xcode`

### MacOS custom preferences

```bash
defaults write com.apple.dock "autohide" -bool "true"
defaults write com.apple.dock "autohide-delay" -float "0"
defaults write com.apple.dock "show-recents" -bool "false"

defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"
defaults write com.apple.finder "AppleShowAllFiles" -bool "true"
defaults write com.apple.finder "ShowPathbar" -bool "true"
defaults write com.apple.finder "ShowStatusBar" -bool "true"
defaults write com.apple.finder "FXPreferredViewStyle" -string "clmv"
defaults write com.apple.finder "FXDefaultSearchScope" -string SCcf

defaults write NSGlobalDomain "com.apple.mouse.scaling" -float "5"
defaults write NSGlobalDomain "com.apple.trackpad.scaling" -float "2"
defaults write NSGlobalDomain "com.apple.springing.delay" -float "0.1"

defaults write NSGlobalDomain "KeyRepeat" -int "1"
defaults write NSGlobalDomain "InitialKeyRepeat" -int "10"
defaults write NSGlobalDomain "AppleKeyboardUIMode" -int "2"
defaults write -g NSUserKeyEquivalents '{"com.apple.NSPasteAndMatchStyleMenuItem"="@$V";}'
defaults write NSGlobalDomain "NSAutomaticQuoteSubstitutionEnabled" -bool "false"
defaults write NSGlobalDomain "NSAutomaticDashSubstitutionEnabled" -bool "false"
defaults write NSGlobalDomain "NSAutomaticCapitalizationEnabled" -bool "false"
defaults write NSGlobalDomain "NSAutomaticPeriodSubstitutionEnabled" -bool "false"
defaults write NSGlobalDomain "NSAutomaticSpellingCorrectionEnabled" -bool "false"
```

> **Safari**
> Open Safari to enable this settings:
>
> - `⌘,` > `Advanced` > `Show full website address` > `true`
> - `⌘,` > `Advanced` > `Show develop menu in menu bar` > `true`

### Terminal

```bash
mkdir -p ~/.config/zsh
touch ~/.config/zsh/.zshrc

brew install zsh-syntax-highlighting
echo "source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.config/zsh/.zshrc

brew install zsh-autosuggestions
echo "source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.config/zsh/.zshrc

brew install powerlevel10k
echo "source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >> ~/.config/zsh/.zshrc

ln -sf ~/Setup/shared/zsh/p10k.zsh ~/.config/zsh/p10k.zsh
echo "source ~/.config/zsh/p10k.zsh" >> ~/.config/zsh/.zshrc

ln -sf ~/Setup/shared/zsh/aliases.zsh ~/.config/zsh/aliases.zsh
echo "source ~/.config/zsh/aliases.zsh" >> ~/.config/zsh/.zshrc

brew install --cask font-iosevka-nerd-font
exec zsh
```

> Then you should change your **Terminal.app** default profile to use the `Iosevka NF` font at size `14`, with `0.83` interline spacing.

### Git

```bash
mkdir -p ~/.config/git
rm -rf ~/.gitconfig
ln -sf ~/Setup/shared/git/config .config/git/config
ln -sf ~/Setup/shared/git/ignore .config/git/ignore

exec zsh
```

### Package manager

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Visual Studio Code

```bash
brew install --cask visual-studio-code

mkdir -p ~/Library/Application\ Support/Code/User
ln -sf ~/Setup/shared/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -sf ~/Setup/shared/vscode/global-snippets.code-snippets ~/Library/Application\ Support/Code/User/snippets/global-snippets.code-snippets
ln -sf ~/Setup/shared/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json

cat ~/Setup/shared/vscode/settings.json | sed 's/^ *\/\/.*//' | jq -r '.["extensions.allowed"] | keys[]' | xargs -I {} code --install-extension {} --force
```

### Development

```bash
# Web development
brew install node@24 && brew link node@24

# Apple development
brew install --cask sf-symbols
brew install --cask icon-composer
```

### Steam

```bash
brew install --cask steam
softwareupdate --install-rosetta --agree-to-license
```

### Keyboard layout

```bash
brew install qwerty-fr
```

> Then to `System Preferences` → `Keyboard` → `Input Sources`, click `+`, scroll down to `Others` and add `qwerty-fr`. Then restart macOS.
