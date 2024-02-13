# Setup

🐧 **Fedora** & 🍎 **OSX** commands to set up a dev environment.

- [Setup](#setup)
  - [Post-install \& essential apps](#post-install--essential-apps)
  - [Git](#git)
  - [Monospace fonts](#monospace-fonts)
  - [OS/WM settings](#oswm-settings)
  - [Terminal](#terminal)
  - [Node.js](#nodejs)
  - [Visual Studio Code](#visual-studio-code)
  - [Android Studio](#android-studio)
  - [Docker](#docker)

## Post-install & essential apps

🍎 On OSX start to update OS and install [XCode](https://itunes.apple.com/us/app/xcode/id497799835), run it and accept additional requirements installation.

> 🐧🍎 Change `YOUR_HOSTNAME=thinkpad` by `YOUR_HOSTNAME=${yourHostname}` in following command block.

```bash
YOUR_HOSTNAME=thinkpad

if [[ $(uname -s) == Linux* ]]; then
    sudo hostnamectl set-hostname $YOUR_HOSTNAME
    echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
    sudo sh -c "echo 'max_parallel_downloads=10' >> /etc/dnf/dnf.conf"
    sudo dnf upgrade -y
    sudo dnf install -y \
        "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
        && sudo dnf install -y ffmpeg
    sudo dnf install -y jq htop rsync chromium
    sudo ln -s /usr/bin/chromium-browser /usr/bin/google-chrome
elif [[ $(uname -s) == Darwin* ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew install --cask firefox google-chrome
    brew install jq coreutils
    echo '\n' >> ~/.zshrc
    echo 'export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"' >> ~/.zshrc
    echo '\n' >> ~/.zshrc
else
    echo "Unsupported OS."
    exit 1
fi
```

## Git

> 🐧🍎 Change `YOUR_GITHUB_USERNAME` and `YOUR_GITHUB_EMAIL` by your values in following command block.

```bash
YOUR_GITHUB_USERNAME=labordem
YOUR_GITHUB_EMAIL=38043788+labordem@users.noreply.github.com

if [[ $(uname -s) == Linux* ]]; then
    sudo dnf install -y git git-credential-libsecret
    git config --global credential.helper libsecret
fi
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
curl -fLo "Iosevka_Nerd_Font_Bold.ttf"          $IOSEVKA_URL/Bold/IosevkaNerdFont-Bold.ttf
curl -fLo "Iosevka_Nerd_Font_Bold-Italic.ttf"   $IOSEVKA_URL/Bold-Italic/IosevkaNerdFont-BoldItalic.ttf
curl -fLo "Iosevka_Nerd_Font_Light.ttf"         $IOSEVKA_URL/Light/IosevkaNerdFont-Light.ttf
curl -fLo "Iosevka_Nerd_Font_Light-Italic.ttf"  $IOSEVKA_URL/Light-Italic/IosevkaNerdFont-LightItalic.ttf
curl -fLo "Iosevka_Nerd_Font_Medium.ttf"        $IOSEVKA_URL/Medium/IosevkaNerdFont-Medium.ttf
curl -fLo "Iosevka_Nerd_Font_Medium-Italic.ttf" $IOSEVKA_URL/Medium-Italic/IosevkaNerdFont-MediumItalic.ttf
curl -fLo "Iosevka_Nerd_Font_Regular.ttf"       $IOSEVKA_URL/Regular/IosevkaNerdFont-Regular.ttf
curl -fLo "Iosevka_Nerd_Font_Italic.ttf"        $IOSEVKA_URL/Italic/IosevkaNerdFont-Italic.ttf
cd
```

## OS/WM settings

```bash
if [[ $(uname -s) == Linux* ]]; then
    cd
    gsettings set org.gnome.desktop.interface monospace-font-name 'Iosevka 12'
    gsettings set org.gnome.desktop.peripherals.mouse natural-scroll false
    gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false
    gsettings set org.gnome.desktop.interface enable-hot-corners false
    gsettings set org.gnome.desktop.interface show-battery-percentage true
    gsettings set org.gnome.desktop.interface clock-show-weekday true
    gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
    gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 4000
    gsettings set org.gnome.desktop.session idle-delay 900
    gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
    gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<Shift><Alt>Tab']"
    curl -fsSLO https://raw.githubusercontent.com/labordem/setup/main/downloads/gnome-terminal.dconf
    gprofile=$(gsettings get org.gnome.Terminal.ProfilesList default)
    gprofile=${gprofile:1:-1}
    dconf load /org/gnome/terminal/legacy/profiles:/:$gprofile/ < gnome-terminal.dconf
    rm gnome-terminal.dconf
elif [[ $(uname -s) == Darwin* ]]; then
    defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
    defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
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
git clone https://github.com/supercrabtree/k ~/.oh-my-zsh/custom/plugins/k
curl https://raw.githubusercontent.com/labordem/setup/main/downloads/.zshrc > ~/.zshrc

if [[ $(uname -s) == Linux* ]]; then
    zsh
fi
```

> 🐧 ZSH is now your default shell, but this change will only take effect after a first reboot. You don't necessarily need to do this right away, but stick with ZSH for the next steps!

## Node.js

```bash
curl -fsSL https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
curl https://raw.githubusercontent.com/labordem/setup/main/downloads/run-nvm-use-when-nvmrc-found.sh >> ~/.zshrc
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
curl -fsSLO https://raw.githubusercontent.com/labordem/setup/main/downloads/.vscode/settings.json
curl -fsSLO https://raw.githubusercontent.com/labordem/setup/main/downloads/.vscode/keybindings.json
curl -fsSL https://raw.githubusercontent.com/labordem/setup/main/downloads/.vscode/extensions.sh | $SHELL
cd
```

> - 🐧🍎 Ignore extensions warnings...

> **Tips:**
>
> - 🐧🍎 Extensions exported with : `code --list-extensions | xargs -L 1 echo code --install-extension > downloads/.vscode/extensions.sh`
> - 🐧🍎 If you want to remove all vscode extensions : `rm -rf ~/.vscode/extensions`

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
    brew tap AdoptOpenJDK/openjdk
    brew install --cask android-studio adoptopenjdk15
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
