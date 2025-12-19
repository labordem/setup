# Setup

This repository contains all my dotfiles, configurations, and setup scripts to quickly bootstrap a clean, consistent, and reproducible development environment.

## Getting started

Clone the repository into your home directory (~):

```bash
git clone https://github.com/labordem/setup ~/Setup && cd ~/Setup
```

## Installation (macOS)

The first step is to install [Xcode](https://apps.apple.com/fr/app/xcode/id497799835?mt=12) from the App Store, then launch it once to accept the license agreement and install the additional command-line developer tools.

After that, run each section of the script sequentially (or execute the entire script at once) to fully set up your development environment.

```bash
# ============================================================================ #
# MacOS settings                                                               #
# ============================================================================ #
# Dock ----------------------------------------------------------------------- #
# Enable dock autohide
defaults write com.apple.dock "autohide" -bool "true"
# Disable dock autohide delay
defaults write com.apple.dock "autohide-delay" -float "0"
# Finder --------------------------------------------------------------------- #
# Show file extensions
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"
# Show all hidden files (you can toggle the value using "cmd+shift+.")
defaults write com.apple.finder "AppleShowAllFiles" -bool "true"
# Show path bar in the bottom of the window
defaults write com.apple.finder "ShowPathbar" -bool "true"
# Show status bar in the bottom of the window
defaults write com.apple.finder "ShowStatusBar" -bool "true"
# Set column view the default view style for folders without custom setting
defaults write com.apple.finder "FXPreferredViewStyle" -string "clmv"
# Set current folder the default search scope when performing a search
defaults write com.apple.finder "FXDefaultSearchScope" -string SCcf
# Mouse ---------------------------------------------------------------------- #
# Set movement speed of the mouse cursor. GUI max is 1
defaults write NSGlobalDomain "com.apple.mouse.scaling" -float "5"
# Make folders open almost instantly when hovering while dragging
defaults write NSGlobalDomain "com.apple.springing.delay" -float "0.1"
# Keyboard-------------------------------------------------------------------- #
# Speed up key repeat rate (UI minimum is 2)
defaults write NSGlobalDomain "KeyRepeat" -int "1"
# Speed up key repeat delay (UI minimum is 15)
defaults write NSGlobalDomain "InitialKeyRepeat" -int "10"
# Enable full keyboard access, allows tab navigation through all UI controls
defaults write NSGlobalDomain "AppleKeyboardUIMode" -int "2"
# Change paste and match style shortcut to ⌘⇧V
defaults write -g NSUserKeyEquivalents '{"com.apple.NSPasteAndMatchStyleMenuItem"="@$V";}'
# Disable smart quotes
defaults write NSGlobalDomain "NSAutomaticQuoteSubstitutionEnabled" -bool "false"
# Disable smart dashes
defaults write NSGlobalDomain "NSAutomaticDashSubstitutionEnabled" -bool "false"
# Disable auto-capitalization
defaults write NSGlobalDomain "NSAutomaticCapitalizationEnabled" -bool "false"
# Disable double-space → period
defaults write NSGlobalDomain "NSAutomaticPeriodSubstitutionEnabled" -bool "false"
# Disable auto spell-check
defaults write NSGlobalDomain "NSAutomaticSpellingCorrectionEnabled" -bool "false"
# Safari --------------------------------------------------------------------- #
# enable developer menu
defaults write com.apple.Safari.SandboxBroker "ShowDevelopMenu" -bool "true"

# ============================================================================ #
# Package manager                                                              #
# ============================================================================ #
# Install https://brew.sh to manage packages
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Install some useful packages
brew install jq

# ============================================================================ #
# Fonts                                                                        #
# ============================================================================ #
# Install https://typeof.net/Iosevka in https://www.nerdfonts.com format
brew install --cask font-iosevka-nerd-font

# ============================================================================ #
# Terminal                                                                     #
# ============================================================================ #
# Init configuration file
touch ~/.zshrc
# link environment
ln -sf ~/Setup/shared/zsh/env ~/.config/zsh/env
echo "source ~/.config/zsh/env" >> ~/.zshrc
# Link aliases
ln -sf ~/Setup/shared/zsh/aliases ~/.config/zsh/aliases
echo "source ~/.config/zsh/aliases" >> ~/.zshrc
# Install https://github.com/zsh-users/zsh-syntax-highlighting
brew install zsh-syntax-highlighting
echo "source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
# Install https://github.com/zsh-users/zsh-autosuggestions
brew install zsh-autosuggestions
echo "source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
# Install https://github.com/romkatv/powerlevel10k
brew install powerlevel10k
echo "source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >> ~/.zshrc
# Link custom configuration (set XDG_CONFIG_HOME to ~/.config)
ln -sf ~/Setup/shared/zsh/p10k ~/.config/zsh/p10k
echo "source ~/.zsh_p10k" >> ~/.zshrc

# ============================================================================ #
# Git                                                                          #
# ============================================================================ #
git config --global core.excludesfile "~/.config/git/.gitignore"
echo .DS_Store >> ~/.config/git/.gitignore
git config --global user.name labordem
git config --global user.email 38043788+labordem@users.noreply.github.com
git config --global init.defaultBranch main

# ============================================================================ #
# Visual Studio Code                                                           #
# ============================================================================ #
# Install https://code.visualstudio.com
brew install --cask visual-studio-code
# Link settings
mkdir -p ~/Library/Application\ Support/Code/User/snippets
ln -sf ~/Setup/shared/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -sf ~/Setup/shared/vscode/global-snippets.code-snippets ~/Library/Application\ Support/Code/User/snippets/global-snippets.code-snippets
ln -sf ~/Setup/shared/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
# Install allowed extensions
cat ~/Setup/shared/vscode/settings.json | sed 's/^ *\/\/.*//' | jq -r '.["extensions.allowed"] | keys[]' | xargs -I {} code --install-extension {} --force

# ============================================================================ #
# SDKs                                                                         #
# ============================================================================ #
brew install node@24
# switch to node@22
#brew install node@22 && brew unlink node@24 && brew link node@22

# ============================================================================ #
# Keyboard layout                                                              #
# ============================================================================ #
# Install https://qwerty-fr.org layout
brew install --cask qwerty-fr
```
