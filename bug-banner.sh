#!/usr/bin/env bash
# bug-banner - bug-themed terminal banner with commands and options.
#
# Usage: bug-banner [OPTIONS] [COMMAND]
#
# Commands:
#   show          Print the banner (default)
#   info          Print system information only
#   shell         Interactive mode; type 'exit' or 'quit' to leave
#   help          Show this help
#   version       Show version
#   exit, quit    Exit without output (also leaves shell mode)
#
# Options:
#   -c, --color NAME   Color: green, cyan, yellow, red, none (default green)
#   -n, --no-info      Hide the system information line
#   -h, --help         Show help
#   -v, --version      Show version

VERSION="1.0.0"

COLOR_NAME="green"
SHOW_INFO=1

set_color() {
    case "$1" in
        green)  COLOR='\033[1;32m' ;;
        cyan)   COLOR='\033[1;36m' ;;
        yellow) COLOR='\033[1;33m' ;;
        red)    COLOR='\033[1;31m' ;;
        none)   COLOR='' ;;
        *) return 1 ;;
    esac
    RESET='\033[0m'
    [ -z "$COLOR" ] && RESET=''
    COLOR_NAME="$1"
}

usage() {
    sed -n '2,20p' "$0" 2>/dev/null | sed 's/^# \{0,1\}//' || cat <<'EOF'
Usage: bug-banner [OPTIONS] [COMMAND]
EOF
}

print_banner() {
    printf '%b' "$COLOR"
    cat <<'BUG'
          \  /
       .-"""-.
      /  o o  \
     |  \___/  |     B U G   H U N T E R
      \  ___  /
 /\    `-----'    /\
/  \  /|  |  |\  /  \
/    \/ |__|__| \/    \
~~~~~~~ /_/   \_\ ~~~~~~~
BUG
    printf '%b' "$RESET"
    printf '\n%s\n' "Every bug is a lesson. Read the code, fix the cause."
}

print_info() {
    [ "$SHOW_INFO" -eq 1 ] || return 0
    printf '%b' "$COLOR"
    printf 'SYSTEM : %s\n' "$(uname -s 2>/dev/null || echo unknown)"
    printf 'SHELL  : %s\n' "${SHELL:-unknown}"
    printf 'MODE   : DEBUG  |  COLOR: %s\n' "$COLOR_NAME"
    printf '%b' "$RESET"
}

run_command() {
    case "$1" in
        show)    print_banner; echo; print_info ;;
        info)    print_info ;;
        version) echo "bug-banner $VERSION" ;;
        help)    usage ;;
        exit|quit) return 0 ;;
        *)
            echo "bug-banner: unknown command '$1'. Try 'help'." >&2
            return 1
            ;;
    esac
}

interactive_shell() {
    echo "bug-banner shell. Commands: show, info, version, help, exit"
    while true; do
        printf 'bug> '
        if ! read -r line; then
            echo
            break
        fi
        # shellcheck disable=SC2086
        set -- $line
        case "${1:-}" in
            "") continue ;;
            exit|quit) break ;;
            shell) echo "Already in shell mode." ;;
            *) run_command "$1" ;;
        esac
    done
}

# Parse options first, then the command.
COMMAND="show"
while [ $# -gt 0 ]; do
    case "$1" in
        -c|--color)
            [ $# -ge 2 ] || { echo "bug-banner: $1 needs a value" >&2; exit 2; }
            set_color "$2" || { echo "bug-banner: unknown color '$2'" >&2; exit 2; }
            shift 2
            ;;
        -n|--no-info) SHOW_INFO=0; shift ;;
        -h|--help)    COMMAND="help"; shift ;;
        -v|--version) COMMAND="version"; shift ;;
        -*)
            echo "bug-banner: unknown option '$1'" >&2
            exit 2
            ;;
        *)
            COMMAND="$1"; shift
            ;;
    esac
done

[ -n "${COLOR+x}" ] || set_color green

if [ "$COMMAND" = "shell" ]; then
    interactive_shell
    exit 0
fi

run_command "$COMMAND"
