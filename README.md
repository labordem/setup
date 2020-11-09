# Set up dev machine

- [Set up dev machine](#set-up-dev-machine)
  - [Post-install & essential apps](#post-install--essential-apps)
  - [Monospace fonts](#monospace-fonts)
  - [Gnome tweaks](#gnome-tweaks)
  - [Zsh theme](#zsh-theme)
  - [Github account](#github-account)
  - [Node.js](#nodejs)
  - [Visual Studio Code](#visual-studio-code)
  - [Android Studio](#android-studio)
  - [Nativescript](#nativescript)
  - [Docker](#docker)

## Post-install & essential apps

```bash
# 🍎 osx
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh) | $SHELL
brew cask install firefox google-chrome
brew install jq htop

# 🐧 fedora
sudo su
# then
sudo hostnamectl set-hostname thinkpad
sudo sh -c "echo 'deltarpm=true' >> /etc/dnf/dnf.conf"
sudo sh -c "echo 'fastestmirror=true' >> /etc/dnf/dnf.conf"
sudo sh -c "echo 'max_parallel_downloads=10' >> /etc/dnf/dnf.conf"
sudo dnf upgrade -y
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo dnf install -y gnome-tweaks ffmpeg jq git-credential-libsecret seahorse && exit
```

## Monospace fonts

```bash
# 🍎 osx
mkdir -pv ~/Library/Fonts
cd ~/Library/Fonts

# 🐧 fedora
mkdir -pv ~/.local/share/fonts
cd ~/.local/share/fonts

# 🐧🍎 fedora & osx
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
cd ..
mkdir Firacode_Nerd_Font
cd Firacode_Nerd_Font
FURACODE_URL="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode"
curl -fLo "Firacode_Nerd_Font_Bold.ttf"         $FURACODE_URL/Bold/complete/Fira%20Code%20Bold%20Nerd%20Font%20Complete.ttf
curl -fLo "Firacode_Nerd_Font_Light.ttf"        $FURACODE_URL/Light/complete/Fira%20Code%20Light%20Nerd%20Font%20Complete.ttf
curl -fLo "Firacode_Nerd_Font_Medium.ttf"       $FURACODE_URL/Medium/complete/Fira%20Code%20Medium%20Nerd%20Font%20Complete.ttf
curl -fLo "Firacode_Nerd_Font_Regular.ttf"      $FURACODE_URL/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete.ttf
cd
```

## Gnome tweaks

```bash
# 🐧 fedora
gsettings set org.gnome.desktop.interface monospace-font-name 'Iosevka Nerd Font 13'
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll false
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false
gsettings set org.gnome.desktop.sound event-sounds false
cd && curl -fsSLO https://raw.githubusercontent.com/mIaborde/setup/main/downloads/gnome-terminal.dconf
dconf load /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ < gnome-terminal.dconf
rm gnome-terminal.dconf
cd && curl -fsSLO https://raw.githubusercontent.com/mIaborde/setup/main/downloads/gnome-extensions.dconf
dconf load /org/gnome/shell/extensions/ < gnome-extensions.dconf
rm gnome-extensions.dconf
```

## Zsh theme

```bash
# 🐧 fedora
sudo dnf install -y util-linux-user zsh

# 🐧🍎 fedora & osx
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# then
git clone https://github.com/romkatv/powerlevel10k $ZSH_CUSTOM/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/lukechilds/zsh-nvm $ZSH_CUSTOM/plugins/zsh-nvm
cd && rm .zshrc
curl -fLo '.zshrc' https://raw.githubusercontent.com/mIaborde/setup/main/downloads/.zshrc
source ~/.zshrc
```

## Github account

```bash
# 🐧🍎 fedora & osx
git config --global user.name miaborde
git config --global user.email 38043788+mIaborde@users.noreply.github.com
git config --global core.editor code
# 🐧 fedora
git config --global credential.helper libsecret
```

## Node.js

```bash
# 🐧 fedora
nvm install --lts && nvm use --lts
```

## Visual Studio Code

```bash
# 🍎 osx
brew cask install visual-studio-code
mkdir -pv ~/Library/Application\ Support/Code/User && cd ~/Library/Application\ Support/Code/User

# 🐧 fedora
sudo su
# then
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update
sudo dnf install -y code
exit
mkdir -pv ~/.config/Code/User && cd ~/.config/Code/User

# 🐧🍎 fedora & osx
curl -fsSLO https://raw.githubusercontent.com/mIaborde/setup/main/downloads/.vscode/settings.json
curl -fsSLO https://raw.githubusercontent.com/mIaborde/setup/main/downloads/.vscode/keybindings.json
curl -fsSL https://raw.githubusercontent.com/mIaborde/setup/main/downloads/.vscode/extensions.sh | $SHELL
cd
```

> 🐧🍎 extensions exported with : `code --list-extensions | xargs -L 1 echo code --install-extension > downloads/.vscode/extensions.sh`

> 🐧🍎 if you want remove all vscode extensions : `rm -rf ~/.vscode/extensions`

## Android Studio

```bash
# 🍎 osx
brew tap AdoptOpenJDK/openjdk
brew cask install adoptopenjdk8 android-studio
echo "export ANDROID_HOME=$HOME/Library/Android/sdk" >> ~/.zshrc
echo "export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk" >> ~/.zshrc
source ~/.zshrc

# 🐧 fedora
sudo dnf install -y java-1.8.0-openjdk-devel
flatpak install -y flathub com.google.AndroidStudio
echo "export JAVA_HOME=$(update-alternatives --query javac | sed -n -e 's/Best: *\(.*\)\/bin\/javac/\1/p')" >> ~/.zshrc
echo "export ANDROID_HOME=$HOME/Android/Sdk" >> ~/.zshrc
echo "PATH=$PATH:$ANDROID_HOME/tools; PATH=$PATH:$ANDROID_HOME/platform-tools" ~/.zshrc
echo "alias android='$ANDROID_HOME/tools/android'" ~/.zshrc
echo "alias emulator='$ANDROID_HOME/tools/emulator'" ~/.zshrc
source ~/.zshrc
```

**🐧🍎 fedora & osx :**

- Launch Android Studio and choose not to import any settings.
- Press "Next" button to continue, choose Standard setup and download all default packages
- Go to configure -> AVD manager -> Create Virtual Device...
- Download a system image according to your Android SDK API level -> Next -> Finish
- Create & Launch an emulator

## Nativescript

```bash
npm i nativescript -g
```

## Docker

```bash
sudo dnf install docker docker-compose
sudo groupadd docker
sudo usermod -aG docker $USER # then close user session
sudo systemctl start docker
docker run hello-world
```

> Fedora additional steps (resolved ?)
>
> ```bash
> # 🐧 fedora
> sudo grubby --update-kernel=ALL --args="systemd.unified_cgroup_hierarchy=0"
> firewall-cmd --zone=FedoraWorkstation --add-masquerade --permanent
> ```
