# Setup

This repository contains all my dotfiles, configurations, and setup scripts to quickly bootstrap a clean, consistent, and reproducible development environment.

## Getting started

Clone the repository into your home directory (~):

```bash
git clone https://github.com/labordem/setup ~/Setup && cd ~/Setup
```

### Why clone directly into `~/Setup`?

We intentionally clone the repository straight into your home directory (~) for three key reasons:

- Simplicity – Short, predictable paths
- Version control – All your configs live in one Git repository
- Symbolic links – We'll create symlinks from standard locations (like `~/.zshrc`) back to files inside `~/Setup`

### What is a symbolic link (symlink)?

A symbolic link is a special kind of file that acts like a pointer or smart shortcut to another file or directory. The operating system and applications treat the symlink exactly as if it were the original file.

**Example:**

```bash
# Create a symlink from ~/.zshrc to ~/Setup/shared/zsh/.zshrc
ln -sf ~/Setup/shared/zsh/.zshrc ~/.zshrc
```

**Result:**

- Your shell continues to read the usual ~/.zshrc path
- The real, version-controlled file lives safely in ~/Setup/zsh/.zshrc

**Key advantages:**

- All configuration files are centralized in a single Git repository
- git pull inside ~/Setup instantly updates every config on your machine
- On a fresh computer: just clone the repo + run the script → your full environment is restored in minutes

## Installation (macOS)

The first step is to install [Xcode](https://apps.apple.com/fr/app/xcode/id497799835?mt=12) from the App Store, then launch it once to accept the license agreement and install the additional command-line developer tools.

After that, run each section of the script sequentially (or execute the entire script at once) to fully set up your development environment.

```bash
# ============================================================================ #
# MacOS settings                                                               #
# ============================================================================ #
# Dock: increase icon size
defaults write com.apple.dock "tilesize" -int "72"
# Dock: enable autohide.
defaults write com.apple.dock "autohide" -bool "true"
# Dock: disable dock autohide delay.
defaults write com.apple.dock "autohide-delay" -float "0"
# Dock: disable recents apps section in dock.
defaults write com.apple.dock "show-recents" -bool "false"
# Finder: show all hidden files (you can toggle the value using "cmd+shift+.").
defaults write com.apple.finder "AppleShowAllFiles" -bool "true"
# Finder: show file extensions.
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"
# Finder: show path bar in the bottom of the windows.
defaults write com.apple.finder "ShowPathbar" -bool "true"
# Finder: set the default view style for folders without custom setting. Here column view.
defaults write com.apple.finder "FXPreferredViewStyle" -string "clmv"
# Finder: keep folders on top when sorting by name.
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"
# Finder: set the default search scope when performing a search. Here current folder.
defaults write com.apple.finder "FXDefaultSearchScope" -string SCcf
# Desktop: keep folders on top when sorting.
defaults write com.apple.finder "_FXSortFoldersFirstOnDesktop" -bool "true"
# Mouse: set movement speed of the mouse cursor. Default is 1.
defaults write NSGlobalDomain "com.apple.mouse.scaling" -float "4"
# Keyboard: disable press-and-hold for keys in favor of key repeat.
defaults write NSGlobalDomain "ApplePressAndHoldEnabled" -bool "false"
# Keyboard: enable full keyboard access, allows tab navigation through all UI controls.
defaults write NSGlobalDomain "AppleKeyboardUIMode" -int "2"
# Keyboard: change key repeat rate to fast (UI minimum is 2).
defaults write NSGlobalDomain "KeyRepeat" -int "1"
# Keyboard: change key repeat delay to fast. (UI minimum is 15).
defaults write NSGlobalDomain "InitialKeyRepeat" -int "10"
# TextEdit: disable smart quotes as it's annoying for messages that contain code.
defaults write com.apple.TextEdit "SmartQuotes" -bool "false"
defaults write NSGlobalDomain "NSAutomaticQuoteSubstitutionEnabled" -bool "false"
# TextEdit: disable smart dashes as it's annoying for messages that contain code.
defaults write com.apple.TextEdit "SmartDashes" -bool "false"
defaults write NSGlobalDomain "NSAutomaticDashSubstitutionEnabled" -bool "false"
# Safari: enable developer menu.
defaults write com.apple.Safari.SandboxBroker "ShowDevelopMenu" -bool "true"
defaults write com.apple.Safari "IncludeDevelopMenu" -bool "true"

# ============================================================================ #
# Package manager                                                              #
# ============================================================================ #
# Install https://brew.sh to manage packages.
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Install some useful packages.
brew install jq jo

# ============================================================================ #
# Terminal                                                                     #
# ============================================================================ #
# Init configuration file.
touch ~/.zshrc
# Install https://github.com/zsh-users/zsh-syntax-highlighting.
brew install zsh-syntax-highlighting
echo "source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
# Install https://github.com/zsh-users/zsh-autosuggestions.
brew install zsh-autosuggestions
echo "source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
# Install https://github.com/romkatv/powerlevel10k.
brew install powerlevel10k
echo "source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >> ~/.zshrc
# Link custom configuration (set XDG_CONFIG_HOME to ~/.config).
ln -sf ~/Setup/shared/zsh/.zsh_p10k ~/.zsh_p10k
echo "source ~/.zsh_p10k" >> ~/.zshrc

# ============================================================================ #
# Git                                                                          #
# ============================================================================ #
# Install git if not already installed.
git --version || brew install git
# Configure git with your name and your noreply github email.
git config --global user.name labordem
git config --global user.email 38043788+labordem@users.noreply.github.com
git config --global init.defaultBranch main

# ============================================================================ #
# Fonts                                                                        #
# ============================================================================ #
# Install https://typeof.net/Iosevka in https://www.nerdfonts.com format.
brew install --cask font-iosevka-nerd-font

# ============================================================================ #
# IDE                                                                          #
# ============================================================================ #
# Install https://code.visualstudio.com.
brew install --cask visual-studio-code
# Link settings.
mkdir -p ~/Library/Application\ Support/Code/User/snippets
ln -sf ~/Setup/shared/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -sf ~/Setup/shared/vscode/global-snippets.code-snippets ~/Library/Application\ Support/Code/User/snippets/global-snippets.code-snippets
ln -sf ~/Setup/shared/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
# Install allowed extensions.
cat ~/Setup/shared/vscode/settings.json | sed 's/^ *\/\/.*//' | jq -r '.["extensions.allowed"] | keys[]' | xargs -I {} code --install-extension {} --force

# ============================================================================ #
# SDKs                                                                         #
# ============================================================================ #
brew install node@24

# ============================================================================ #
# Keyboard layout                                                              #
# ============================================================================ #
# Install https://qwerty-fr.org layout.
brew install --cask qwerty-fr
```
