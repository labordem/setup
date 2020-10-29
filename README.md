# Set up dev machine

- [Set up dev machine](#set-up-dev-machine)
  - [OS post install](#os-post-install)
  - [Fonts](#fonts)
  - [Terminal](#terminal)
  - [Github account](#github-account)
  - [Visual Studio Code](#visual-studio-code)
  - [Android Studio](#android-studio)
  - [Nativescript](#nativescript)
  - [Docker](#docker)
  - [Gnome Appearance tweaks](#gnome-appearance-tweaks)

## OS post install

```bash
# 🍎 osx
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh) | $SHELL
brew cask install firefox google-chrome

# 🐧 fedora
sudo dnf update -y
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf install gnome-tweaks chromium ffmpeg -y
echo "fastestmirror=1" >> /etc/dnf/dnf.conf
echo "max_parallel_downloads=20" >> /etc/dnf/dnf.conf
```

## Fonts

```bash
# 🍎 osx
cd ~/Library/Fonts

# 🐧 fedora
cd ~/.local/share/fonts

# 🐧🍎 fedora & osx
mkdir tmp && cd tmp
IOSEVKA_URL="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Iosevka"
curl -fLo "Iosevka_Nerd_Font_Bold.ttf"          $IOSEVKA_URL/Bold/complete/Iosevka%20Bold%20Nerd%20Font%20Complete.ttf
curl -fLo "Iosevka_Nerd_Font_Bold-Italic.ttf"   $IOSEVKA_URL/Bold-Italic/complete/Iosevka%20Bold%20Italic%20Nerd%20Font%20Complete.ttf
curl -fLo "Iosevka_Nerd_Font_Light.ttf"         $IOSEVKA_URL/Light/complete/Iosevka%20Light%20Nerd%20Font%20Complete.ttf
curl -fLo "Iosevka_Nerd_Font_Light-Italic.ttf"  $IOSEVKA_URL/Light-Italic/complete/Iosevka%20Light%20Italic%20Nerd%20Font%20Complete.ttf
curl -fLo "Iosevka_Nerd_Font_Medium.ttf"        $IOSEVKA_URL/Medium/complete/Iosevka%20Medium%20Nerd%20Font%20Complete.ttf
curl -fLo "Iosevka_Nerd_Font_Medium-Italic.ttf" $IOSEVKA_URL/Medium-Italic/complete/Iosevka%20Medium%20Italic%20Nerd%20Font%20Complete.ttf
curl -fLo "Iosevka_Nerd_Font_Regular.ttf"       $IOSEVKA_URL/Regular/complete/Iosevka%20Nerd%20Font%20Complete.ttf
curl -fLo "Iosevka_Nerd_Font_Italic.ttf"        $IOSEVKA_URL/Italic/complete/Iosevka%20Italic%20Nerd%20Font%20Complete.ttf
cd .. && mv tmp Iosevka_Nerd_Font
FURACODE_URL="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode"
mkdir tmp && cd tmp
curl -fLo "FiraCode_Nerd_Font_Bold.ttf"         $FURACODE_URL/Bold/complete/Fira%20Code%20Bold%20Nerd%20Font%20Complete.ttf
curl -fLo "FiraCode_Nerd_Font_Light.ttf"        $FURACODE_URL/Light/complete/Fira%20Code%20Light%20Nerd%20Font%20Complete.ttf
curl -fLo "FiraCode_Nerd_Font_Medium.ttf"       $FURACODE_URL/Medium/complete/Fira%20Code%20Medium%20Nerd%20Font%20Complete.ttf
curl -fLo "FiraCode_Nerd_Font_Regular.ttf"      $FURACODE_URL/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete.ttf
cd .. && mv tmp FiraCode_Nerd_Font

# 🐧 fedora
gsettings set org.gnome.desktop.interface monospace-font-name 'Iosevka Nerd Font 13'
```

## Terminal

```bash
# 🍎 osx
brew install jq htop

# 🐧 fedora
sudo dnf install -y util-linux-user zsh jq htop

# 🐧🍎 fedora & osx
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/romkatv/powerlevel10k $ZSH_CUSTOM/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/lukechilds/zsh-nvm $ZSH_CUSTOM/plugins/zsh-nvm
cd && gio trash .zshrc
DOWNLOADS_URL=https://raw.githubusercontent.com/mIaborde/setup/master/downloads
curl -fLo '.zshrc' $DOWNLOADS_URL/.zshrc
source ~/.zshrc
nvm install --lts && nvm use --lts
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

## Visual Studio Code

```bash
# 🍎 osx
brew cask install visual-studio-code
cd ~/Library/Application\ Support/Code/User

# 🐧 fedora
sudo tee -a /etc/yum.repos.d/vscodium.repo << 'EOF'
[gitlab.com_paulcarroty_vscodium_repo]
name=gitlab.com_paulcarroty_vscodium_repo
baseurl=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/repos/rpms/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg
EOF
sudo dnf install codium
cd ~/.config/Code/User

# 🐧🍎 fedora & osx
DOWNLOADS_URL=https://raw.githubusercontent.com/mIaborde/setup/master/downloads
curl -fsSLO $DOWNLOADS_URL/.vscode/settings.json
curl -fsSLO DOWNLOADS_URL/.vscode/keybindings.json
curl -fsSL DOWNLOADS_URL/vscode-extensions.sh | $SHELL
```

> 🐧🍎 Extensions exported with : `code --list-extensions | xargs -L 1 echo code --install-extension > downloads/.vscode/extensions.sh`

> 🐧🍎 If you want remove all vscode extensions : `rm -rf ~/.vscode/extensions`

## Android Studio

```bash
# 🍎 osx
brew tap AdoptOpenJDK/openjdk
brew cask install adoptopenjdk8 android-studio

# 🐧 fedora
sudo dnf install java-1.8.0-openjdk-devel
flatpak install flathub com.google.AndroidStudio
```

**🐧🍎 fedora & osx :**

- Launch Android Studio and choose not to import any settings.
- Press "Next" button to continue, choose Standard setup and download all default packages
- Go to configure -> AVD manager -> Create Virtual Device...
- Download a system image according to your Android SDK API level -> Next -> Finish
- Create & Launch an emulator

```bash
# 🍎 osx
echo "export ANDROID_HOME=$HOME/Library/Android/sdk"
echo "export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk"

# 🐧 fedora
echo "export JAVA_HOME=$(update-alternatives --query javac | sed -n -e 's/Best: *\(.*\)\/bin\/javac/\1/p')" >> ~/.zshrc
echo "export ANDROID_HOME=$HOME/Android/Sdk" >> ~/.zshrc
echo "PATH=$PATH:$ANDROID_HOME/tools; PATH=$PATH:$ANDROID_HOME/platform-tools" ~/.zshrc
echo "alias android='$ANDROID_HOME/tools/android'" ~/.zshrc
echo "alias emulator='$ANDROID_HOME/tools/emulator'" ~/.zshrc

# 🐧🍎 fedora & osx
source ~/.zshrc
```

## Nativescript

**🍎 osx :**

- Install XCode from App Store
- Launch XCode a first time, and accept additional packages

```bash
# 🍎 osx
xcode-select --install

# 🐧🍎 fedora & osx
npm i nativescript -g
tns doctor # all should be ok on fedora, on OSX select 'configure for local builds' and accept installations
```

## Docker

```bash
# 🍎 osx
open https://www.docker.com/get-started # install docker-desktop with dmg file

# 🐧 fedora
sudo dnf install docker docker-compose
sudo groupadd docker
sudo usermod -aG docker $USER # then close user session
sudo systemctl start docker
docker run hello-world
```

> Fedora 32 additional steps (resolved ?)
>
> ```bash
> # 🐧 fedora
> ## switch from cgroupV2 to cgroupV1
> sudo grubby --update-kernel=ALL --args="systemd.unified_cgroup_hierarchy=0"
> ## if containers don't communicate together in docker-compose
> firewall-cmd --zone=FedoraWorkstation --add-masquerade --permanent
> ```

## Gnome Appearance tweaks

```bash
# 🐧 fedora
DOWNLOADS_URL=https://raw.githubusercontent.com/mIaborde/setup/master/downloads
cd && curl -fsSLO $DOWNLOADS_URL/gnome-terminal.dconf
dconf load /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ < gnome-terminal.dconf
rm gnome-terminal.dconf
cd && curl -fsSLO $DOWNLOADS_URL/gnome-extensions.dconf
dconf load /org/gnome/shell/extensions/ < gnome-extensions.dconf
rm gnome-extensions.dconf
cd && mkdir ~/.config/fontconfig && cd ~/.config/fontconfig && curl -fsSLO $DOWNLOADS_URL/fonts.conf
```
