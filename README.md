# Setup

This repository contains all my dotfiles, configurations, and setup scripts to quickly bootstrap a clean, consistent, and reproducible development environment.

## macOS

### Getting started

Clone this repository into your `HOME` directory (`~`):

```bash
git clone https://github.com/labordem/setup ~/Setup && cd ~/Setup
```

### Env

Make `~/.config` the default config directory:

```bash
mkdir -p ~/.config
ln -sf ~/Setup/shared/.zshenv ~/.zshenv
exec zsh
```

### Update macOS

```bash
sudo softwareupdate --install --all
```

> **Manual action required**
>
> `` > `App Store` > `Develop` > `Xcode` > `Get`
>
> Then accept the license agreement and additional dependencies.

### MacOS custom preferences

```bash
defaults write com.apple.dock "autohide" -bool true
defaults write com.apple.dock "autohide-delay" -float 0
defaults write com.apple.dock "show-recents" -bool false
defaults write com.apple.dock "expose-group-apps" -bool true
defaults write com.apple.dock "static-only" -bool true
defaults write com.apple.dock "mru-spaces" -bool false

defaults write NSGlobalDomain "AppleShowAllExtensions" -bool true
defaults write com.apple.finder "AppleShowAllFiles" -bool true
defaults write com.apple.finder "ShowPathbar" -bool true
defaults write com.apple.finder "ShowStatusBar" -bool true
defaults write com.apple.finder "FXPreferredViewStyle" -string "clmv"
defaults write com.apple.finder "FXDefaultSearchScope" -string "SCcf"

defaults write NSGlobalDomain "com.apple.mouse.scaling" -float 5
defaults write NSGlobalDomain "com.apple.trackpad.scaling" -float 2
defaults write NSGlobalDomain "com.apple.springing.delay" -float 0.1

defaults write NSGlobalDomain "KeyRepeat" -int 1
defaults write NSGlobalDomain "InitialKeyRepeat" -int 10
defaults write NSGlobalDomain "AppleKeyboardUIMode" -int 2
defaults write NSGlobalDomain "ApplePressAndHoldEnabled" -bool true
defaults write NSGlobalDomain "NSAutomaticQuoteSubstitutionEnabled" -bool false
defaults write NSGlobalDomain "NSAutomaticDashSubstitutionEnabled" -bool false
defaults write NSGlobalDomain "NSAutomaticCapitalizationEnabled" -bool false
defaults write NSGlobalDomain "NSAutomaticPeriodSubstitutionEnabled" -bool false
defaults write NSGlobalDomain "NSAutomaticSpellingCorrectionEnabled" -bool false

# cmd+opt+s to share
#defaults write -g NSUserKeyEquivalents -dict-add "Share…" "@~s"
defaults write -g NSUserKeyEquivalents -dict-add "Partager…" "@~s"

# cmd+shift+v to paste and match style
#defaults write -g NSUserKeyEquivalents -dict-add "Paste and Match Style" -string "@\$v"
defaults write -g NSUserKeyEquivalents -dict-add "Coller et adapter le style" -string "@\$v"
```

> **Manual action required**
>
> `Safari` > `Settings…` > `Advanced` > `Show full website address` > `true`
> `Safari` > `Settings…` > `Advanced` > `Show features for web developers` > `true`

### Terminal

```bash
mkdir -p ~/.config/zsh
touch ~/.config/zsh/.zshrc

brew install jq

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

> **Manual action required**
>
> `Terminal` > `Settings…` > `Profiles` > `Basic` > `Text` > `Font` > `Change…` > `Iosevka Nerd Font` (size: `14`, interline spacing: `0.83`)

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
# Install
brew install --cask visual-studio-code

# Sync settings
mkdir -p ~/Library/Application\ Support/Code/User
ln -sf ~/Setup/shared/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -sf ~/Setup/shared/vscode/global-snippets.code-snippets ~/Library/Application\ Support/Code/User/snippets/global-snippets.code-snippets
ln -sf ~/Setup/shared/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json

# Install allowed extensions
cat ~/Setup/shared/vscode/settings.json | sed 's/^ *\/\/.*//' | jq -r '.["extensions.allowed"] | keys[]' | xargs -I {} code --install-extension {} --force
```

### Development

```bash
# Docker
brew install --cask docker

# Bun
brew install bun
bun completions

# Node.js
brew install node@24
brew link node@24

# Apple
brew install --cask sf-symbols
brew install --cask icon-composer
```

### Gaming

```bash
brew install --cask steam
```

### Keyboard layout

```bash
brew install qwerty-fr
```

> **Manual action required**
> `` > `System Settings…` > `Keyboard` > `Input Sources` > `+` > `Others` > `qwerty-fr`

> **Restart macOS.**
