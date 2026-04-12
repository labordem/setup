alias x='exit'
alias c='clear'
alias ls='ls --color=auto'
alias l='ls'
alias la='ls -A'
alias ll='ls -lrthF'
alias lla='ls -lArthF'
alias dev='node --run dev'
alias rmempty="find . -empty -type d -delete"
alias glg="git log --graph --abbrev-commit --decorate --format=format:'%C(bold yellow)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''%C(white)%s%C(reset) %C(dim white)- %an%C(reset)'"
alias cdp='cd ~/Developer'

jcurl() {
    local output curl_exit body meta grey="\033[90m" reset="\033[0m"
    local delimiter=$'---------- CURL METADATA FOLLOWS ----------\n'

    output=$(command curl -s -w "${delimiter}%{json}" "$@" 2>&1)
    curl_exit=$?

    if (( curl_exit != 0 )); then
        echo -e "\033[1;31m✘ curl failed (exit $curl_exit)\033[0m"
        return $curl_exit
    fi

    if [[ "$output" == *"$delimiter"* ]]; then
        body="${output%%"$delimiter"*}"
        meta="${output#*"$delimiter"}"
    else
        body="$output"
        meta='{}'
    fi

    body="${body%"${body##*[![:space:]]}"}"

    # Extract fields
    local code http_ver conn_ms dns_ms ttfb_ms size speed remote_ip content_type

    code=$(jq -r '.response_code // "—"' <<< "$meta" 2>/dev/null || echo "—")
    http_ver=$(jq -r '.http_version // "—"' <<< "$meta" 2>/dev/null || echo "—")
    conn_ms=$(jq -r '(.time_connect     * 1000 | floor) // "—"' <<< "$meta" 2>/dev/null || echo "—")
    dns_ms=$(jq -r '(.time_namelookup   * 1000 | floor) // "—"' <<< "$meta" 2>/dev/null || echo "—")
    ttfb_ms=$(jq -r '(.time_starttransfer * 1000 | floor) // "—"' <<< "$meta" 2>/dev/null || echo "—")
    size=$(jq -r '.size_download // 0' <<< "$meta" 2>/dev/null || echo 0)
    speed=$(jq -r '.speed_download // 0' <<< "$meta" 2>/dev/null || echo 0)
    remote_ip=$(jq -r '.remote_ip // "—"' <<< "$meta" 2>/dev/null || echo "—")
    content_type=$(jq -r '.content_type // "—" | split(";")[0]' <<< "$meta" 2>/dev/null || echo "—")

    # Human-readable size & speed
    local size_disp speed_disp
    if (( size >= 1048576 )); then
        size_disp=$(awk "BEGIN {printf \"%.1f\", $size/1048576}") MB"
    elif (( size >= 1024 )); then
        size_disp=$(awk "BEGIN {printf \"%.1f\", $size/1024}") kB"
    else
        size_disp="${size} bytes"
    fi

    if (( speed >= 1048576 )); then
        speed_disp=$(awk "BEGIN {printf \"%.1f\", $speed/1048576}") MB/s"
    elif (( speed >= 1024 )); then
        speed_disp=$(awk "BEGIN {printf \"%.1f\", $speed/1024}") kB/s"
    else
        speed_disp="${speed} B/s"
    fi

    # Status styling
    local status_color status_icon
    case $code in
        2??) status_color="\033[1;32m" ; status_icon="✔" ;;
        3??) status_color="\033[1;36m" ; status_icon="↻" ;;
        4??) status_color="\033[1;33m" ; status_icon="⚠" ;;
        5??) status_color="\033[1;31m" ; status_icon="✘" ;;
        *)   status_color="\033[90m"   ; status_icon="?"  ;;
    esac

    # ────────────────────────────────────────────────────────────────
    # Print – every inner line starts with exactly ONE space
    # ────────────────────────────────────────────────────────────────
    echo -e "\n${grey}┌───────────────────────────────────────────────────┐${reset}"

    printf " ${status_color}%s %s HTTP/%s${reset}${grey} ${reset}\n" \
        "$status_icon" "$code" "$http_ver"

    printf " ${grey}├─ connect: %s ms · dns: %s ms · ttfb: %s ms ${reset}\n" \
        "$conn_ms" "$dns_ms" "$ttfb_ms"

    printf " ${grey}├─ size: %s · speed: %s ${reset}\n" \
        "$size_disp" "$speed_disp"

    [[ "$remote_ip" != "—" ]] && \
        printf " ${grey}├─ remote: %s ${reset}\n" "$remote_ip"

    [[ "$content_type" != "—" && "$content_type" != "null" ]] && \
        printf " ${grey}├─ type: %s ${reset}\n" "$content_type"

    echo -e "${grey}└───────────────────────────────────────────────────┘${reset}\n"

    # Body
    if [[ -z "$body" ]]; then
        echo -e "${grey}(no content)${reset}"
    elif jq -e . >/dev/null 2>&1 <<< "$body"; then
        jq . <<< "$body"
    else
        printf '%s\n' "$body"
        (( $(printf '%s\n' "$body" | wc -l) > 12 )) && echo -e "${grey}…${reset}"
    fi

    echo ""
}
