{ config, pkgs, ... }:
let
    home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";
in
{
    imports = [
        /etc/nixos/hardware-configuration.nix
        (import "${home-manager}/nixos")
    ];
    system = {
        stateVersion = "25.05";
    };
    nix = {
        settings = {
            experimental-features = [
                "nix-command"
                "flakes"
            ];
        };
    };
    nixpkgs = {
        config = {
            allowUnfree = true;
        };
    };
    hardware = {
        nvidia = {
            modesetting.enable = true;
            powerManagement.enable = true;
            powerManagement.finegrained = false;
            open = false;
            nvidiaSettings = false;
            package = config.boot.kernelPackages.nvidiaPackages.stable;
        };
    };
    boot = {
        loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        };
        kernelPackages = pkgs.linuxPackages_6_12;
    };
    # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
    systemd = {
        services."getty@tty1".enable = false;
        services."autovt@tty1".enable = false;
    };
    networking = {
        hostName = "nixos";
        networkmanager.enable = true;
        wireless.enable = false;
    };
    time.timeZone = "Europe/Paris";
    security = {
        rtkit.enable = true; # Allows Pipewire to use the realtime scheduler for performance.
    };
    environment = {
        systemPackages = with pkgs; [
            git
            jq
            zsh
            starship
            qwerty-fr
            nixfmt-rfc-style
        ];
        gnome = {
            excludePackages = with pkgs; [
                gnome-tour
                epiphany
                totem
                yelp
                evolution
            ];
        };
    };
    services = {
        xserver = {
            enable = true;
            excludePackages = with pkgs; [
                xterm
            ];
            xkb = {
                layout = "us";
                variant = "altgr-intl";
            };
            videoDrivers = [ "nvidia" ];
            displayManager = {
                gdm.enable = true;
            };
            desktopManager = {
                gnome.enable = true;
            };
        };
        displayManager = {
            autoLogin = {
                enable = true;
                user = "mickael";
            };
        };
        pulseaudio.enable = false;
        pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            jack.enable = false;
        };
        printing.enable = false;
        keyd = {
            enable = true;
            keyboards.default = {
                extraConfig = ''
                    [ids]
                    *
                    [main]
                    leftmeta = layer(meta_mac)
                    [meta_mac:C]
                    c = C-insert
                    v = S-insert
                    x = S-delete
                    # 1 = A-1
                    # 2 = A-2
                    # 3 = A-3
                    # 4 = A-4
                    # 5 = A-5
                    # 6 = A-6
                    # 7 = A-7
                    # 8 = A-8
                    # 9 = A-9
                    left = home
                    right = end
                    tab = swapm(app_switch_state, A-tab)
                    [app_switch_state:A]
                '';
            };
        };
    };
    fonts = {
        packages = with pkgs; [
            nerd-fonts.iosevka
        ];
    };
    programs = {
        zsh = {
            enable = true;
            enableCompletion = true;
            enableAutosuggestions = true;
            enableSyntaxHighlighting = true;
            shellInit = ''
                eval "$(starship init zsh)"
                touch ~/.zshrc
                source ~/Setup/shared/zsh/.zsh_aliases
            '';
        };
        starship = {
            enable = true;
            settings = pkgs.lib.importTOML ../shared/starship/starship.toml;
        };
        steam = {
            enable = true;
            remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
            dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
            localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
        };
        dconf = {
            profiles.user.databases = [
                {
                    lockAll = true; # prevents overriding
                    settings = {
                        "org/gnome/desktop/interface" = {
                            clock-show-weekday = true;
                            enable-hot-corners = false;
                            show-battery-percentage = true;
                            monospace-font-name = "Iosevka Nerd Font 12";
                        };
                        "org/gnome/desktop/sound" = {
                            event-sounds = false;
                        };
                        "org/gnome/desktop/session" = {
                            idle-delay = "900";
                        };
                        "org/gnome/settings-daemon/plugins/power" = {
                            sleep-inactive-ac-timeout = "1800";
                            power-button-action = "interactive";
                        };
                        "org/gnome/desktop/wm" = {
                            audible-bell = false;
                        };
                        "org/gnome/desktop/input-sources" = {
                            xkb-options = [ "ctrl:nocaps" ];
                        };
                        "org/gnome/desktop/peripherals" = {
                            keyboard = [
                                "delay:255"
                                "repeat-interval:30"
                            ];
                            mouse = [ "natural-scroll:false" ];
                            touchpad = [ "natural-scroll:false" ];
                        };
                        "org/gnome/shell/keybindings" = {
                            toggle-overview = [ "<Ctrl>space" ];
                        };
                    };
                }
            ];

        };
    };
    users = {
        defaultUserShell = pkgs.zsh;
        users.mickael = {
            isNormalUser = true;
            description = "Mickaël";
            extraGroups = [
                "networkmanager"
                "wheel"
            ];
        };
    };
    home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.mickael = {
            home = {
                stateVersion = "25.05";
                username = "mickael";
                file = {
                    zsh-aliases = {
                        source = ../shared/zsh/.zsh_aliases;
                        target = "~/.zsh_aliases";
                    };
                    vscode-settings = {
                        source = ../shared/vscode/settings.json;
                        target = "~/.config/Code/User/settings.json";
                    };
                    vscode-keybindings = {
                        source = ../shared/vscode/keybindings.json;
                        target = "~/.config/Code/User/keybindings.json";
                    };
                    vscode-snippets = {
                        source = ../shared/vscode/global-snippets.code-snippets;
                        target = "~/.config/Code/User/snippets/global-snippets.code-snippets";
                    };
                };
                homeDirectory = "/home/mickael";
                packages = with pkgs; [
                    go
                    bun
                    nodejs
                    google-chrome
                    showtime
                    gnomeExtensions.blur-my-shell
                    gnomeExtensions.rounded-window-corners-reborn
                ];
            };
            programs = {
                git = {
                    enable = true;
                    userName = "labordem";
                    userEmail = "38043788+labordem@users.noreply.github.com";
                    extraConfig = {
                        init.defaultBranch = "main";
                        credential.helper = "${pkgs.git.override { withLibsecret = true; }}/bin/git-credential-libsecret";
                    };
                };
                firefox = {
                    enable = true;
                    policies = {
                        DisableTelemetry = true;
                        DisableFirefoxStudies = true;
                        EnableTrackingProtection = {
                            Value= true;
                            Locked = true;
                            Cryptomining = true;
                            Fingerprinting = true;
                        };
                        DisablePocket = true;
                        DisableFirefoxAccounts = true;
                        DisableAccounts = true;
                        OverrideFirstRunPage = "";
                        OverridePostUpdatePage = "";
                        DontCheckDefaultBrowser = true;
                        DisplayBookmarksToolbar = "newtab"; # never, always, newtab
                        DisplayMenuBar = "never"; # always, never, default-on, default-off
                        SearchBar = "unified";
                        ExtensionSettings = {
                            "*".installation_mode = "blocked"; # blocks all addons except the ones specified below
                            "uBlock0@raymondhill.net" = {
                                install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
                                installation_mode = "force_installed";
                            };
                            "idcac-pub@www.idontcareaboutcookies.eu" = {
                                install_url = "https://addons.mozilla.org/firefox/downloads/latest/i-dont-care-about-cookies/latest.xpi";
                                installation_mode = "force_installed";
                            };
                            "bitwarden@bitwarden.com" = {
                                install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
                                installation_mode = "force_installed";
                            };
                        };
                    };
                };
                vscode = {
                    enable = true;
                };
            };
        };
    };
}
