# Setup

🐧 **Fedora** & 🍎 **OSX** commands to set up a dev environment.

- [Setup](#setup)
  - [Post-install & essential apps](#post-install--essential-apps)
  - [Git](#git)
  - [Monospace fonts](#monospace-fonts)
  - [Gnome tweaks](#gnome-tweaks)
  - [Terminal](#terminal)
  - [Node.js](#nodejs)
  - [Visual Studio Code](#visual-studio-code)
  - [Android Studio](#android-studio)
  - [Docker](#docker)

## Post-install & essential apps

> 🍎 Install [XCode](https://itunes.apple.com/us/app/xcode/id497799835), run it and install additional requirements.

```bash
YOUR_HOSTNAME=thinkpad

if [[ $(uname -s) == Linux* ]]; then

sudo hostnamectl set-hostname $YOUR_HOSTNAME
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
sudo sh -c "echo 'max_parallel_downloads=10' >> /etc/dnf/dnf.conf"
sudo dnf upgrade -y
sudo dnf install -y "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm"
sudo dnf install -y \
    ffmpeg \
    git git-credential-libsecret \
    jq htop rsync \
    google-noto-emoji-color-fonts \
    gnome-tweaks chromium
git config --global credential.helper libsecret
sudo ln -s /usr/bin/chromium-browser /usr/bin/google-chrome

elif [[ $(uname -s) == Darwin* ]]; then

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install --cask firefox google-chrome
brew install jq htop

else

echo "Unsupported OS."
exit 1

fi

```

## Git

```bash
YOUR_GITHUB_USERNAME=miaborde
YOUR_GITHUB_EMAIL=38043788+mIaborde@users.noreply.github.com

git config --global user.name $YOUR_GITHUB_USERNAME
git config --global user.email $YOUR_GITHUB_EMAIL

```

> 🍎 Clone your first repositories with the native OSX Terminal application to initialize Github/GitLab keys in the Apple Keychain Acces.

## Monospace fonts

```bash
if [[ $(uname -s) == Linux* ]]; then

mkdir -pv ~/.local/share/fonts
cd ~/.local/share/fonts

elif [[ $(uname -s) == Darwin* ]]; then

mkdir -pv ~/Library/Fonts
cd ~/Library/Fonts

else

echo "Unsupported OS."
exit 1

fi

mkdir Iosevka_Nerd_Font
cd Iosevka_Nerd_Font
IOSEVKA_URL="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Iosevka"
curl -fLo "Iosevka_Nerd_Font_Bold.ttf"          $IOSEVKA_URL/Bold/complete/Iosevka%20Bold%20Nerd%20Font%20Complete.ttf
curl -fLo "Iosevka_Nerd_Font_Bold-Italic.ttf"   $IOSEVKA_URL/Bold-Italic/complete/Iosevka%20Bold%20Italic%20Nerd%20Font%20Complete.ttf
curl -fLo "Iosevka_Nerd_Font_Light.ttf"         $IOSEVKA_URL/Light/complete/Iosevka%20Light%20Nerd%20Font%20Complete.ttf
curl -fLo "Iosevka_Nerd_Font_Light-Italic.ttf"  $IOSEVKA_URL/Light-Italic/complete/Iosevka%20Light%20Italic%20Nerd%20Font%20Complete.ttf
curl -fLo "Iosevka_Nerd_Font_Medium.ttf"        $IOSEVKA_URL/Medium/complete/Iosevka%20Medium%20Nerd%20Font%20Complete.ttf
curl -fLo "Iosevka_Nerd_Font_Medium-Italic.ttf" $IOSEVKA_URL/Medium-Italic/complete/Iosevka%20Medium%20Italic%20Nerd%20Font%20Complete.ttf
curl -fLo "Iosevka_Nerd_Font_Regular.ttf"       $IOSEVKA_URL/Regular/complete/Iosevka%20Nerd%20Font%20Complete.ttf
curl -fLo "Iosevka_Nerd_Font_Italic.ttf"        $IOSEVKA_URL/Italic/complete/Iosevka%20Italic%20Nerd%20Font%20Complete.ttf
cd

```

## Gnome tweaks

```bash
if [[ $(uname -s) == Linux* ]]; then

cd
gsettings set org.gnome.desktop.interface monospace-font-name 'Iosevka 12'
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll false
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false
gsettings set org.gnome.desktop.interface enable-hot-corners false
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 3
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 4000
curl -fsSLO https://raw.githubusercontent.com/mIaborde/setup/main/downloads/gnome-terminal.dconf
gprofile=$(gsettings get org.gnome.Terminal.ProfilesList default)
gprofile=${gprofile:1:-1}
dconf load /org/gnome/terminal/legacy/profiles:/:$gprofile/ < gnome-terminal.dconf
rm gnome-terminal.dconf

else

echo "Not required in this OS."
exit 1

fi

```

## Terminal

```bash
if [[ $(uname -s) == Linux* ]]; then

sudo dnf install -y zsh
sudo usermod --shell /bin/zsh $USER

fi

RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/romkatv/powerlevel10k ~/.oh-my-zsh/custom/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
curl https://raw.githubusercontent.com/mIaborde/setup/main/downloads/.zshrc > ~/.zshrc

if [[ $(uname -s) == Linux* ]]; then

zsh

fi

```

> 🐧 ZSH is now your default shell, but this change will only take effect after a first reboot. You don't necessarily need to do this right away, but stick with ZSH for the next steps!

## Node.js

```bash

curl -fsSL https://raw.githubusercontent.com/creationix/nvm/master/install.sh | zsh
curl https://raw.githubusercontent.com/mIaborde/setup/main/downloads/run-nvm-use-when-nvmrc-found.sh >> ~/.zshrc
source ~/.zshrc
nvm install --lts && nvm use --lts

```

## Visual Studio Code

```bash
if [[ $(uname -s) == Linux* ]]; then

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update
sudo dnf install -y code
mkdir -pv ~/.config/Code/User && cd ~/.config/Code/User

elif [[ $(uname -s) == Darwin* ]]; then

brew cask install visual-studio-code
mkdir -pv ~/Library/Application\ Support/Code/User && cd ~/Library/Application\ Support/Code/User

else

echo "Unsupported OS."
exit 1

fi

curl -fsSLO https://raw.githubusercontent.com/mIaborde/setup/main/downloads/.vscode/settings.json
curl -fsSLO https://raw.githubusercontent.com/mIaborde/setup/main/downloads/.vscode/keybindings.json
curl -fsSL https://raw.githubusercontent.com/mIaborde/setup/main/downloads/.vscode/extensions.sh | $SHELL
cd

```

> 🐧🍎 Ignore extensions warnings...

> 🐧🍎 Extensions exported with : `code --list-extensions | xargs -L 1 echo code --install-extension > downloads/.vscode/extensions.sh`

> 🐧🍎 If you want remove all vscode extensions : `rm -rf ~/.vscode/extensions`

## Android Studio

```bash
if [[ $(uname -s) == Linux* ]]; then

sudo dnf install -y java-1.8.0-openjdk-devel
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub com.google.AndroidStudio
echo '\n' >> ~/.zshrc
echo 'export ANDROID_HOME=$HOME/Android/Sdk' >> ~/.zshrc
echo 'export PATH=$PATH:$ANDROID_HOME/platform-tools' >> ~/.zshrc
echo '\n' >> ~/.zshrc
source ~/.zshrc

elif [[ $(uname -s) == Darwin* ]]; then

brew install --cask adoptopenjdk8 android-studio
echo '\n' >> ~/.zshrc
echo 'export ANDROID_HOME=$HOME/Library/Android/sdk' >> ~/.zshrc
echo 'export PATH=$PATH:$ANDROID_HOME/platform-tools' >> ~/.zshrc
echo '\n' >> ~/.zshrc
source ~/.zshrc

else

echo "Unsupported OS."
exit 1

fi

```

**🐧🍎 Additional steps:**

- Launch Android Studio and choose not to import any settings.
- Press "Next" button to continue, choose Standard setup and download all default packages
- Go to configure -> AVD manager -> Create Virtual Device...
- Download a system image according to your Android SDK API level -> Next -> Finish
- Create & Launch an emulator

## Docker

```bash
if [[ $(uname -s) == Linux* ]]; then

sudo dnf install -y docker docker-compose
sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl start docker
sudo grubby --update-kernel=ALL --args="systemd.unified_cgroup_hierarchy=0"
sudo firewall-cmd --zone=FedoraWorkstation --add-masquerade --permanent

elif [[ $(uname -s) == Darwin* ]]; then

brew install --cask docker

else

echo "Unsupported OS."
exit 1

fi

```

> 🐧 Docker can now run without root permissions, but this change will only take effect after a first reboot.
