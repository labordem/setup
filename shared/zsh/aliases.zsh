alias x='exit'
alias c='clear'
alias ls='ls --color=auto'
alias l='ls'
alias la='ls -A'
alias ll='ls -lrthF'
alias lla='ls -lArthF'
alias rmempty="find . -empty -type d -delete"
alias cdp='cd ~/Developer'
alias ip='printf "🏠 Local:  %s\n🌐 Remote: %s\n" "$(ipconfig getifaddr en0)" "$(dig +short myip.opendns.com @resolver1.opendns.com)"'
mkcd() { mkdir -p "$1" && cd "$1"; }
