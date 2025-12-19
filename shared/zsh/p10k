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
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    os_icon custom_host dir dir_writable
    vcs
    custom_bun_global custom_node_global custom_go_global custom_python_global
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
# Context
POWERLEVEL9K_CONTEXT_DEFAULT_TEMPLATE="\uF007 $USER" # 
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND=$COLOR_BLACK
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND=$COLOR_BLUE
POWERLEVEL9K_CONTEXT_ROOT_TEMPLATE=$'\uF6A4 ' # 
POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND=$COLOR_BLACK
POWERLEVEL9K_CONTEXT_ROOT_BACKGROUND=$COLOR_MAGENTA
POWERLEVEL9K_CONTEXT_SUDO_TEMPLATE=$'\uF09C ' # 
POWERLEVEL9K_CONTEXT_SUDO_FOREGROUND=$COLOR_BLACK
POWERLEVEL9K_CONTEXT_SUDO_BACKGROUND=$COLOR_MAGENTA
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
# Custom Node.js local versions
zsh_node_local() {
    if [[ -n $(find package.json 2>/dev/null) ]]; then
        NODE_VERSION=$(cat .nvmrc 2>/dev/null)
        [[ -n $NODE_VERSION ]] && echo -n "%{%F{$COLOR_GREEN}%}\ue617 $NODE_VERSION "
        HONO_VERSION=$(cat package.json | grep -o '"hono": "[^"]*' | grep -o '[^"]*$' | sed 's/[^0-9.]//g' 2>/dev/null)
        [[ -n $HONO_VERSION ]] && echo -n "%{%F{215}%}\uf490 $HONO_VERSION "
        ANGULAR_VERSION=$(cat package.json | grep -o '"@angular/core": "[^"]*' | grep -o '[^"]*$' | sed 's/[^0-9.]//g' 2>/dev/null)
        [[ -n $ANGULAR_VERSION ]] && echo -n "%{%F{197}%}\ue753 $ANGULAR_VERSION" && exit
        REACT_VERSION=$(cat package.json | grep -o '"react": "[^"]*' | grep -o '[^"]*$' | sed 's/[^0-9.]//g' 2>/dev/null)
        [[ -n $REACT_VERSION ]] && echo -n "%{%F{045}%}\ue7ba $REACT_VERSION" && exit
        VUE_VERSION=$(cat package.json | grep -o '"vue": "[^"]*' | grep -o '[^"]*$' | sed 's/[^0-9.]//g' 2>/dev/null)
        [[ -n $VUE_VERSION ]] && echo -n "%{%F{042}%}\ufd42 $VUE_VERSION" && exit
    fi
}
POWERLEVEL9K_CUSTOM_NODE_LOCAL="zsh_node_local"
POWERLEVEL9K_CUSTOM_NODE_LOCAL_BACKGROUND=$COLOR_BLACK
# Custom Node.js global versions
zsh_node_global() {
    if [[ -n $(find package-lock.json 2>/dev/null) && -x $(command -v node) ]]; then
        NODE_VERSION=$(node -v | sed 's/[^0-9.]*//g' 2>/dev/null)
        [[ -n $NODE_VERSION ]] && echo -n "%{%F{$COLOR_GREEN}%}\ue617 $NODE_VERSION"
        LOCAL_ANGULAR_VERSION=$(cat package.json | grep -o '"@angular/core": "[^"]*' | grep -o '[^"]*$' | sed 's/[^0-9.]//g' 2>/dev/null)
        [[ -n $LOCAL_ANGULAR_VERSION ]] && ANGULAR_VERSION=$(npm info -g @angular/cli version) && [[ -n $ANGULAR_VERSION ]] && echo -n "  %{%F{197}%}\ue753 $ANGULAR_VERSION" && exit
    fi
}
POWERLEVEL9K_CUSTOM_NODE_GLOBAL="zsh_node_global"
POWERLEVEL9K_CUSTOM_NODE_GLOBAL_BACKGROUND=$COLOR_BLACK
# Custom Bun.js global versions
zsh_bun_global() {
    if [[ -n $(find bun.lock 2>/dev/null) && -x $(command -v bun) ]]; then
        BUN_VERSION=$(bun -v | sed 's/[^0-9.]*//g' 2>/dev/null)
        [[ -n $BUN_VERSION ]] && echo -n "%{%F{$COLOR_YELLOW}%}\ue76f $BUN_VERSION" && exit
    fi
}
POWERLEVEL9K_CUSTOM_BUN_GLOBAL="zsh_bun_global"
POWERLEVEL9K_CUSTOM_BUN_GLOBAL_BACKGROUND=$COLOR_BLACK
# Custom Python global versions
zsh_python_global() {
    if [[ -n $(find requirements.txt 2>/dev/null || find setup.py 2>/dev/null) && -x $(command -v python) ]]; then
        PYTHON_VERSION=$(python --version | grep -Eo '[0-9]+\.[0-9]+\.[0-9]' 2>/dev/null)
        [[ -n $PYTHON_VERSION ]] && echo -n "%{%F{$COLOR_YELLOW}%}\uf81f $PYTHON_VERSION" && exit
    fi
}
POWERLEVEL9K_CUSTOM_PYTHON_GLOBAL="zsh_python_global"
POWERLEVEL9K_CUSTOM_PYTHON_GLOBAL_BACKGROUND=$COLOR_BLACK
# Custom Go global versions
zsh_go_global() {
    if [[ -n $(find go.mod 2>/dev/null) && -x $(command -v go) ]]; then
        GO_VERSION=$(go version | grep -Eo '[0-9]+\.[0-9]+\.[0-9]' 2>/dev/null)
        [[ -n $GO_VERSION ]] && echo -n "%{%F{$COLOR_CYAN}%}\ue627 $GO_VERSION" && exit
    fi
}
POWERLEVEL9K_CUSTOM_GO_GLOBAL="zsh_go_global"
POWERLEVEL9K_CUSTOM_GO_GLOBAL_BACKGROUND=$COLOR_BLACK

# Syntax highlighting -------------------------------------------------------- #
# https://github.com/catppuccin/zsh-syntax-highlighting/blob/main/zsh-syntax-highlighting.tera
ZSH_HIGHLIGHT_STYLES[comment]='fg='$COLOR_BLACK
ZSH_HIGHLIGHT_STYLES[alias]='fg='$COLOR_BLUE
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg='$COLOR_BLUE
ZSH_HIGHLIGHT_STYLES[global-alias]='fg='$COLOR_BLUE
ZSH_HIGHLIGHT_STYLES[function]='fg='$COLOR_BLUE
ZSH_HIGHLIGHT_STYLES[command]='fg='$COLOR_BLUE
ZSH_HIGHLIGHT_STYLES[precommand]='fg='$COLOR_BLUE',italic'
ZSH_HIGHLIGHT_STYLES[autodirectory]='fg='$COLOR_YELLOW',italic'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg='$COLOR_YELLOW
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg='$COLOR_YELLOW
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg='$COLOR_MAGENTA
ZSH_HIGHLIGHT_STYLES[builtin]='fg='$COLOR_BLUE
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg='$COLOR_BLUE
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg='$COLOR_BLUE
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg='$COLOR_MAGENTA
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg='$COLOR_WHITE
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]='fg='$COLOR_WHITE
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg='$COLOR_WHITE
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='fg='$COLOR_MAGENTA
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg='$COLOR_MAGENTA
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg='$COLOR_MAGENTA
ZSH_HIGHLIGHT_STYLES[command-substitution-quoted]='fg='$COLOR_GREEN
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]='fg='$COLOR_GREEN
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg='$COLOR_GREEN
ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]='fg='$COLOR_RED
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg='$COLOR_GREEN
ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]='fg='$COLOR_RED
ZSH_HIGHLIGHT_STYLES[rc-quote]='fg='$COLOR_GREEN
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg='$COLOR_WHITE
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]='fg='$COLOR_RED
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg='$COLOR_WHITE
ZSH_HIGHLIGHT_STYLES[assign]='fg='$COLOR_WHITE
ZSH_HIGHLIGHT_STYLES[named-fd]='fg='$COLOR_WHITE
ZSH_HIGHLIGHT_STYLES[numeric-fd]='fg='$COLOR_WHITE
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg='$COLOR_RED
ZSH_HIGHLIGHT_STYLES[path]='fg='$COLOR_WHITE',underline'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg='$COLOR_WHITE',underline'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg='$COLOR_WHITE',underline'
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='fg='$COLOR_WHITE',underline'
ZSH_HIGHLIGHT_STYLES[globbing]='fg='$COLOR_WHITE
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg='$COLOR_MAGENTA
#ZSH_HIGHLIGHT_STYLES[command-substitution]='fg=?'
#ZSH_HIGHLIGHT_STYLES[command-substitution-unquoted]='fg=?'
#ZSH_HIGHLIGHT_STYLES[process-substitution]='fg=?'
#ZSH_HIGHLIGHT_STYLES[arithmetic-expansion]='fg=?'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]='fg='$COLOR_RED
ZSH_HIGHLIGHT_STYLES[redirection]='fg='$COLOR_WHITE
ZSH_HIGHLIGHT_STYLES[arg0]='fg='$COLOR_WHITE
ZSH_HIGHLIGHT_STYLES[default]='fg='$COLOR_WHITE
ZSH_HIGHLIGHT_STYLES[cursor]='fg='$COLOR_WHITE
