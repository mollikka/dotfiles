#!/usr/bin/env bash

set -euo pipefail

if [[ $# -gt 0 ]]; then
    cmds=$(grep -vE '^\s*(#|$)' "$1")
else
    cmds=$(
        find -L ${PATH//:/ } \
            -maxdepth 1 \
            -type f \
            -executable \
            -printf '%f\n' 2>/dev/null
    )
fi

cmd=$(
    printf '%s\n' "$cmds" |
    sort -u |
    fzf \
        --layout=reverse \
        --height=40% \
        --border \
        --prompt="Run > "
)

setsid "$cmd" </dev/null >/dev/null 2>&1 &
sleep 0.2
