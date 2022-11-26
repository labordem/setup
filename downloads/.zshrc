# Your variables ------------------------------------------------------------- #
YOUR_PROJECT_FOLDER="$HOME/Projets"
# Colors --------------------------------------------------------------------- #
# https://user-images.githubusercontent.com/704406/43988708-64c0fa52-9d4c-11e8-8cf9-c4d4b97a5200.png
COLOR_BLACK="000"
COLOR_RED="001"
COLOR_GREEN="002"
COLOR_YELLOW="003"
COLOR_BLUE="004"
COLOR_MAGENTA="005"
COLOR_CYAN="006"
COLOR_WHITE="015"
# Powerlevel9k --------------------------------------------------------------- #
ZSH_DISABLE_COMPFIX=true
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE="nerdfont-complete"
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
POWERLEVEL9K_INSTANT_PROMPT=quiet
# Prompt segments
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    os_icon custom_host user dir dir_writable vcs
    custom_javascript custom_python custom_go
    newline status
)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
# Separators
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR='\uE0BA '
POWERLEVEL9K_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL='\uE0B6'
POWERLEVEL9K_RIGHT_PROMPT_LAST_SEGMENT_END_SYMBOL='\uE0B4'
# OS icon
POWERLEVEL9K_OS_ICON_FOREGROUND=$COLOR_WHITE
POWERLEVEL9K_OS_ICON_BACKGROUND=$COLOR_BLACK
# User
POWERLEVEL9K_USER_ICON=$'\uF007' # 
POWERLEVEL9K_ROOT_ICON=$'\uF6A4' # 
POWERLEVEL9K_SUDO_ICON=$'\uF09C' # 
POWERLEVEL9K_USER_DEFAULT_FOREGROUND=$COLOR_BLACK
POWERLEVEL9K_USER_DEFAULT_BACKGROUND=$COLOR_BLUE
POWERLEVEL9K_USER_ROOT_FOREGROUND=$COLOR_BLACK
POWERLEVEL9K_USER_ROOT_BACKGROUND=$COLOR_MAGENTA
POWERLEVEL9K_USER_SUDO_FOREGROUND=$COLOR_BLACK
POWERLEVEL9K_USER_SUDO_BACKGROUND=$COLOR_MAGENTA
# Custom Host
zsh_host() {
    [[ $HOST == 'toolbox' || $HOST == 'dev' ]] && echo -n "\uf6a5 $HOST"
}
POWERLEVEL9K_CUSTOM_HOST="zsh_host"
POWERLEVEL9K_CUSTOM_HOST_BACKGROUND=$COLOR_WHITE
POWERLEVEL9K_CUSTOM_HOST_FOREGROUND=$COLOR_BLACK
# Dir Writable
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND=$COLOR_MAGENTA
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND=$COLOR_BLACK
POWERLEVEL9K_DIR_WRITABLE_VERBOSE="true"
# Dir
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_DIR_HOME_BACKGROUND=$COLOR_GREEN
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND=$COLOR_CYAN
POWERLEVEL9K_DIR_ETC_BACKGROUND=$COLOR_MAGENTA
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND=$COLOR_MAGENTA
# Status
POWERLEVEL9K_STATUS_CROSS=true
POWERLEVEL9K_STATUS_OK_FOREGROUND=$COLOR_GREEN
POWERLEVEL9K_STATUS_OK_BACKGROUND=$COLOR_BLACK
POWERLEVEL9K_STATUS_OK_ICON=$'\uf061' # 
POWERLEVEL9K_STATUS_ERROR_FOREGROUND=$COLOR_RED
POWERLEVEL9K_STATUS_ERROR_BACKGROUND=$COLOR_BLACK
POWERLEVEL9K_STATUS_VERBOSE="true"
# Vcs
POWERLEVEL9K_VCS_BRANCH_ICON=''
POWERLEVEL9K_VCS_CLEAN_FOREGROUND=$COLOR_BLACK
POWERLEVEL9K_VCS_CLEAN_BACKGROUND=$COLOR_GREEN
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=$COLOR_BLACK
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=$COLOR_MAGENTA
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=$COLOR_BLACK
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=$COLOR_YELLOW
# Custom Javascript
zsh_javascript() {
    if [[ -n $(find package.json 2>/dev/null) && -x $(command -v node) ]]; then
        NODE_VERSION=$(node -v | sed 's/[^0-9.]*//g' 2>/dev/null)
        [[ -n $NODE_VERSION ]] && echo -n "%{%F{$COLOR_GREEN}%}\ue617 $NODE_VERSION"
        # too slow # NPM_VERSION=$(npm -v 2>/dev/null)
        # too slow # [[ $NPM_VERSION != null ]] && echo -n "%{%F{210}%}\ue616 $NPM_VERSION "
        ANGULAR_VERSION=$(cat package.json | grep -o '"@angular/core": "[^"]*' | grep -o '[^"]*$' | sed 's/[^0-9.]//g' 2>/dev/null)
        [[ -n $ANGULAR_VERSION ]] && echo -n " %{%F{$COLOR_RED}%}\ue753 $ANGULAR_VERSION" && exit
        REACT_VERSION=$(cat package.json | grep -o '"react": "[^"]*' | grep -o '[^"]*$' | sed 's/[^0-9.]//g' 2>/dev/null)
        [[ -n $REACT_VERSION ]] && echo -n " %{%F{$COLOR_BLUE}%}\ue7ba $REACT_VERSION" && exit
        VUE_VERSION=$(cat package.json | grep -o '"vue": "[^"]*' | grep -o '[^"]*$' | sed 's/[^0-9.]//g' 2>/dev/null)
        [[ -n $VUE_VERSION ]] && echo -n " %{%F{$COLOR_GREEN}%}\ufd42 $VUE_VERSION" && exit
    fi
}
POWERLEVEL9K_CUSTOM_JAVASCRIPT="zsh_javascript"
POWERLEVEL9K_CUSTOM_JAVASCRIPT_BACKGROUND=$COLOR_BLACK
# Custom Python
zsh_python() {
    if [[ -n $(find requirements.txt 2>/dev/null || find setup.py 2>/dev/null) && -x $(command -v python) ]]; then
        PYTHON_VERSION=$(python --version | grep -Eo '[0-9]+\.[0-9]+\.[0-9]' 2>/dev/null)
        [[ -n $PYTHON_VERSION ]] && echo -n "%{%F{$COLOR_YELLOW}%}\uf81f $PYTHON_VERSION" && exit
    fi
}
POWERLEVEL9K_CUSTOM_PYTHON="zsh_python"
POWERLEVEL9K_CUSTOM_PYTHON_BACKGROUND=$COLOR_BLACK
# Custom Go
zsh_go() {
    if [[ -n $(find go.mod 2>/dev/null) && -x $(command -v go) ]]; then
        GO_VERSION=$(go version | grep -Eo '[0-9]+\.[0-9]+\.[0-9]' 2>/dev/null)
        [[ -n $GO_VERSION ]] && echo -n "%{%F{$COLOR_CYAN}%}\ue627 $GO_VERSION" && exit
    fi
}
POWERLEVEL9K_CUSTOM_GO="zsh_go"
POWERLEVEL9K_CUSTOM_GO_BACKGROUND=$COLOR_BLACK
# Oh-My-Zsh ------------------------------------------------------------------ #
export ZSH="$HOME/.oh-my-zsh"
plugins+=(zsh-autosuggestions zsh-syntax-highlighting k)
DISABLE_AUTO_UPDATE=true
DISABLE_MAGIC_FUNCTIONS=true
source $ZSH/oh-my-zsh.sh
# Syntax highlighting plugin
ZSH_HIGHLIGHT_STYLES[comment]='fg='$COLOR_GREEN
ZSH_HIGHLIGHT_STYLES[alias]='fg='$COLOR_BLUE
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg='$COLOR_BLUE
ZSH_HIGHLIGHT_STYLES[builtin]='fg='$COLOR_BLUE
ZSH_HIGHLIGHT_STYLES[precommand]='fg='$COLOR_BLUE',bold'
ZSH_HIGHLIGHT_STYLES[command]='fg='$COLOR_BLUE
ZSH_HIGHLIGHT_STYLES[function]='fg='$COLOR_BLUE
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg='$COLOR_BLUE
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg='$COLOR_RED
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg='$COLOR_MAGENTA
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg='$COLOR_YELLOW
ZSH_HIGHLIGHT_STYLES[path]='fg='$COLOR_CYAN',underline'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg='$COLOR_CYAN',underline'
ZSH_HIGHLIGHT_STYLES[path_approx]='fg='$COLOR_CYAN',underline'
ZSH_HIGHLIGHT_STYLES[globbing]='fg='$COLOR_YELLOW
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg='$COLOR_YELLOW
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg='$COLOR_YELLOW
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg='$COLOR_CYAN
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg='$COLOR_CYAN
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg='$COLOR_CYAN
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg='$COLOR_CYAN
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg='$COLOR_CYAN
ZSH_HIGHLIGHT_STYLES[assign]='fg='$COLOR_YELLOW
# Aliases & functions -------------------------------------------------------- #
alias x="exit"
alias c="clear"
alias l="ls -F"
alias la="ls -AF"
alias ll="k -h || ls -lhF"
alias lla="k -ha || ls -lhAF"
cdp() { cd $YOUR_PROJECT_FOLDER"/$1" && lla }
mkcd() { mkdir -p "$1" && cd "$1" }
glog() { git log --graph --abbrev-commit --decorate --date=relative --all }
glg() { git log --graph --abbrev-commit --decorate --format=format:'%C(bold yellow)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''%C(white)%s%C(reset) %C(dim white)- %an%C(reset)' }
open() {
    xdg-open "$*" 2>/dev/null || command open "$*"
}
# Added after initial setup -------------------------------------------------- #
