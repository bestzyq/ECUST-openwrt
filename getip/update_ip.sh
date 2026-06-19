#!/bin/bash

FILE="xyw_ip.txt"
TMP=$(mktemp)

CERNET_URL="https://ispip.clang.cn/cernet.txt"
CHINANET_URL="https://ispip.clang.cn/chinatelecom.txt"
UNICOM_URL="https://ispip.clang.cn/unicom_cnc.txt"

get_ip() {
    curl -s "$1" | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}/[0-9]+' 
}

update_block() {

    START="$1"
    END="$2"
    URL="$3"

    IPS=$(get_ip "$URL")

    awk -v start="$START" -v end="$END" -v ips="$IPS" '
    $0 ~ start {
        print
        print ips
        skip=1
        next
    }
    $0 ~ end {
        skip=0
    }
    !skip
    ' "$FILE" > "$TMP"

    mv "$TMP" "$FILE"
}

update_block "# --- AUTO CERNET BEGIN ---" "# --- AUTO CERNET END ---" "$CERNET_URL"

update_block "# --- AUTO CHINANET BEGIN ---" "# --- AUTO CHINANET END ---" "$CHINANET_URL"

update_block "# --- AUTO UNICOM BEGIN ---" "# --- AUTO UNICOM END ---" "$UNICOM_URL"

echo "IP list updated."