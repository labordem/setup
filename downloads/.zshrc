# Your variables ------------------------------------------------------------- #
YOUR_GITHUB_USERNAME="miaborde"
YOUR_PROJECT_FOLDER="$HOME/Projets"
# Colors --------------------------------------------------------------------- #
# https://user-images.githubusercontent.com/704406/43988708-64c0fa52-9d4c-11e8-8cf9-c4d4b97a5200.png
COLOR_BLACK="000" # black
COLOR_ERROR="001" # red
COLOR_OK="002" # green
COLOR_WARNING="003" # yellow
COLOR_PRIMARY="004" # blue
COLOR_DENIED="005" # magenta
COLOR_STRING="006" # cyan
COLOR_WHITE="015" # white
# Powerlevel9k --------------------------------------------------------------- #
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE="nerdfont-complete"
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# Prompt segments
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon custom_host user dir dir_writable vcs newline status)
# Separators ----------------------------------------------------------------- #
# POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='\uE0B4'
# POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR='\uE0B5'
# POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='\uE0BC '
# POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR='\u2571 '
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR='\uE0BA '
POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR='\u2571 '
POWERLEVEL9K_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL='\uE0B6'
POWERLEVEL9K_RIGHT_PROMPT_LAST_SEGMENT_END_SYMBOL='\uE0B4'
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(node_version)
# ZLE_RPROMPT_INDENT=0 # Fix final space for right prompt
# Left prompt ---------------------------------------------------------------- #
# OS icon
POWERLEVEL9K_OS_ICON_FOREGROUND=$COLOR_WHITE
POWERLEVEL9K_OS_ICON_BACKGROUND=$COLOR_BLACK
# User
POWERLEVEL9K_USER_ICON=$'\uF007' # 
POWERLEVEL9K_ROOT_ICON=$'\uF6A4' # 
POWERLEVEL9K_SUDO_ICON=$'\uF09C' # 
POWERLEVEL9K_USER_DEFAULT_FOREGROUND=$COLOR_BLACK
POWERLEVEL9K_USER_DEFAULT_BACKGROUND=$COLOR_PRIMARY
POWERLEVEL9K_USER_ROOT_FOREGROUND=$COLOR_BLACK
POWERLEVEL9K_USER_ROOT_BACKGROUND=$COLOR_DENIED
POWERLEVEL9K_USER_SUDO_FOREGROUND=$COLOR_BLACK
POWERLEVEL9K_USER_SUDO_BACKGROUND=$COLOR_DENIED
# Custom Host
zsh_host(){
    [[ $HOST == 'toolbox' || $HOST == 'dev' ]] && echo -n "%{%F{$COLOR_BLACK}%}\uf6a5 $HOST"
}
POWERLEVEL9K_CUSTOM_HOST="zsh_host"
POWERLEVEL9K_CUSTOM_HOST_BACKGROUND=$COLOR_WHITE
# Dir Writable
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND=$COLOR_DENIED
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND=$COLOR_BLACK
POWERLEVEL9K_DIR_WRITABLE_VERBOSE="true"
# Dir
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_DIR_HOME_BACKGROUND=$COLOR_OK
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND=$COLOR_STRING
POWERLEVEL9K_DIR_ETC_BACKGROUND=$COLOR_DENIED
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND=$COLOR_DENIED
# Status
POWERLEVEL9K_STATUS_CROSS=true
POWERLEVEL9K_STATUS_OK_FOREGROUND=$COLOR_OK
POWERLEVEL9K_STATUS_OK_BACKGROUND=$COLOR_BLACK
POWERLEVEL9K_STATUS_OK_ICON=$'\uf061' # 
POWERLEVEL9K_STATUS_ERROR_FOREGROUND=$COLOR_ERROR
POWERLEVEL9K_STATUS_ERROR_BACKGROUND=$COLOR_BLACK
POWERLEVEL9K_STATUS_VERBOSE="true"
# Vcs
POWERLEVEL9K_VCS_BRANCH_ICON=''
POWERLEVEL9K_VCS_CLEAN_FOREGROUND=$COLOR_BLACK
POWERLEVEL9K_VCS_CLEAN_BACKGROUND=$COLOR_OK
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=$COLOR_BLACK
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=$COLOR_DENIED
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=$COLOR_BLACK
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=$COLOR_WARNING
# Right prompt --------------------------------------------------------------- #
# Custom dev
POWERLEVEL9K_CUSTOM_DEV="echo $'\uF44F '" # 
POWERLEVEL9K_CUSTOM_DEV_BACKGROUND=$COLOR_OK
POWERLEVEL9K_CUSTOM_DEV_FOREGROUND=$COLOR_BLACK
# Versions
POWERLEVEL9K_NODE_VERSION_BACKGROUND=$COLOR_BLACK
POWERLEVEL9K_NODE_VERSION_FOREGROUND=$COLOR_OK
# Oh-My-Zsh ------------------------------------------------------------------ #
export ZSH="$HOME/.oh-my-zsh"
plugins=(zsh-autosuggestions zsh-syntax-highlighting)
DISABLE_MAGIC_FUNCTIONS=true
source $ZSH/oh-my-zsh.sh
# Syntax highlighting plugin
ZSH_HIGHLIGHT_STYLES[comment]='fg='$COLOR_OK
ZSH_HIGHLIGHT_STYLES[alias]='fg='$COLOR_PRIMARY
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg='$COLOR_PRIMARY
ZSH_HIGHLIGHT_STYLES[builtin]='fg='$COLOR_PRIMARY
ZSH_HIGHLIGHT_STYLES[precommand]='fg='$COLOR_PRIMARY',bold'
ZSH_HIGHLIGHT_STYLES[command]='fg='$COLOR_PRIMARY
ZSH_HIGHLIGHT_STYLES[function]='fg='$COLOR_PRIMARY
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg='$COLOR_PRIMARY
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg='$COLOR_ERROR
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg='$COLOR_DENIED
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg='$COLOR_WARNING
ZSH_HIGHLIGHT_STYLES[path]='fg='$COLOR_STRING',underline'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg='$COLOR_STRING',underline'
ZSH_HIGHLIGHT_STYLES[path_approx]='fg='$COLOR_STRING',underline'
ZSH_HIGHLIGHT_STYLES[globbing]='fg='$COLOR_WARNING
#ZSH_HIGHLIGHT_STYLES[history-expansion]='fg='$COLOR_STRING',bold'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg='$COLOR_WARNING
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg='$COLOR_WARNING
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg='$COLOR_STRING
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg='$COLOR_STRING
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg='$COLOR_STRING
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg='$COLOR_STRING
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg='$COLOR_STRING
ZSH_HIGHLIGHT_STYLES[assign]='fg='$COLOR_WARNING
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg='$COLOR_COMMENTS
# Aliases & functions -------------------------------------------------------- #
alias x="exit"
alias c="clear"
alias l="ls"
alias la="ls -A"
alias ll="ls -l"
alias lla="ls -lA"
alias llh="ls -lh"
cdp() { cd $YOUR_PROJECT_FOLDER"/$1" && ls -A }
mkcd() { mkdir -p "$1" && cd "$1" }
jcurl() { curl $@ | jq -C | less -R }
rsp() { rsync -avhW --progress $1 $2 }
ga() { git add . && gls }
gm() { git merge $1 --no-commit }
gls() {
    echo "👷 build ····· Changes that affect the build system or dependencies
💻 ci ········ Changes to our CI configuration files and scripts
📖 docs ······ Documentation only changes
✨ feat ······ New feature [minor version: 0.v.0]
🐛 fix ······· Bug fix [patch version: 0.0.v]
📈 perf ······ Change that improves performance
🏗  refactor ·· Change that neither fixes a bug nor adds a feature
🚀 release ··· A new project version
🔥 revert ···· Revert, must contains reverted commit header
🚨 test ······ Adding missing tests or correcting existing tests"
}
glog() { git log --graph --abbrev-commit --decorate --date=relative --all }
glg() { git log --graph --abbrev-commit --decorate --format=format:'%C(bold yellow)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''%C(white)%s%C(reset) %C(dim white)- %an%C(reset)' }
gh() { open "https://github.com/$YOUR_GITHUB_USERNAME/$1?tab=repositories" }
ghls() { curl "https://api.github.com/users/$YOUR_GITHUB_USERNAME/repos" -s | jq '[.[].svn_url]' }
open() {
    xdg-open "$*" 2>/dev/null || command open "$*"
}
# Added after initial setup -------------------------------------------------- #
