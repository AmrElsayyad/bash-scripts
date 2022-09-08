#!/usr/bin/env bash

# Title:         pacman
# Description:   print a string then pacman eats it
# Author:        Amr Elsayyad <amrelsayyad96@outlook.com>
# Date:          2022-09-08
# Version:       1.0.0

# Exit codes
# ==========
# 0   no error
# 1   script interrupted
# 2   error description


# >>>>>>>>>>>>>>>>>>>>>>>> variables >>>>>>>>>>>>>>>>>>>>>>>>

# <<<<<<<<<<<<<<<<<<<<<<<< variables <<<<<<<<<<<<<<<<<<<<<<<<


# >>>>>>>>>>>>>>>>>>>>>>>> handler functions >>>>>>>>>>>>>>>>>>>>>>>>

# CTRL+C event handler
function on_ctrl_c() {
    echo # Set cursor to the next line of '^C'
    tput cnorm # show cursor. You need this if animation is used.
    # i.e. clean-up code here
    exit 1 # Don't remove. Use a number (1-255) for error code.
}

# Exit event handler
function on_exit() {
    tput cnorm # Show cursor. You need this if animation is used.
    # i.e. clean-up code here
    exit 0 # Exit gracefully.
}

# <<<<<<<<<<<<<<<<<<<<<<<< handler functions <<<<<<<<<<<<<<<<<<<<<<<<


# >>>>>>>>>>>>>>>>>>>>>>>> event handlers >>>>>>>>>>>>>>>>>>>>>>>>

# Register CTRL+C event handler
trap on_ctrl_c SIGINT

# Register exit event handler.
trap on_exit EXIT

# <<<<<<<<<<<<<<<<<<<<<<<< event handlers <<<<<<<<<<<<<<<<<<<<<<<<


# >>>>>>>>>>>>>>>>>>>>>>>> functions >>>>>>>>>>>>>>>>>>>>>>>>

# Usage: pacMan inputString interval pad
# Example: pacman "string" "interval" "padding"
function pacMan () {
    local string="${1}"
    : "${string:='Hello World'}"
    local interval="${2}"
    : "${interval:=0.2}"
    local pad="${3}"
    : "${pad:=.}"
    local length=${#string}
    local padding=""

    # Comment out next two lines if you are using CTRL+C event handler.
    trap 'tput cnorm; echo' EXIT
    trap 'exit 127' HUP INT TERM

    tput civis # hide cursor
    tput sc # save cursor position

    for((i=0;i<=length;i++)); do
        tput rc
        echo "${padding}c${string:i:length}"
        sleep "$interval"
        tput rc
        echo "${padding}C${string:i:length}"
        sleep "${interval}"
        padding+="${pad}"
    done

    tput cnorm
    tput rc
    echo "${padding}"
}


# <<<<<<<<<<<<<<<<<<<<<<<< functions <<<<<<<<<<<<<<<<<<<<<<<<


# >>>>>>>>>>>>>>>>>>>>>>>> argument parsing >>>>>>>>>>>>>>>>>>>>>>>>

POSITIONAL=()
while (( $# > 0 )); do
    case "${1}" in
        -i|--interval)
        numOfArgs=1 # number of switch arguments
        if (( $# < numOfArgs + 1 )); then
            echo "missing argument for '${1}' option" >&2
            exit 2
        else
            interval=${2}
            shift $((numOfArgs + 1)) # shift 'numOfArgs + 1' to bypass switch and its value
        fi
        ;;
        -p|--padding)
        numOfArgs=1 # number of switch arguments
        if (( $# < numOfArgs + 1 )); then
            echo "missing argument for '${1}' option" >&2
            exit 2
        else
            padding=${2}
            shift $((numOfArgs + 1)) # shift 'numOfArgs + 1' to bypass switch and its value
        fi
        ;;
        -s|--string)
        numOfArgs=1 # number of switch arguments
        if (( $# < numOfArgs + 1 )); then
            echo "missing argument for '${1}' option" >&2
            exit 2
        else
            string=${2}
            shift $((numOfArgs + 1)) # shift 'numOfArgs + 1' to bypass switch and its value
        fi
        ;;
        *) # unknown flag/switch
        if [[ "${1}" =~ ^- ]]; then
            echo "argument ${1} not understood."
            exit 3
        else
            POSITIONAL+=("${1}")
            shift
        fi
        ;;
    esac
done

set -- "${POSITIONAL[@]}" # restore positional params

# <<<<<<<<<<<<<<<<<<<<<<<< argument parsing <<<<<<<<<<<<<<<<<<<<<<<<


# >>>>>>>>>>>>>>>>>>>>>>>> rest of code >>>>>>>>>>>>>>>>>>>>>>>>

if (( ${#POSITIONAL[@]} > 0 )) && [ "${string}" ]; then
    echo "argument '${POSITIONAL[@]}' not understood."
    exit 3
else
    # Usage: pacMan inputString interval pad
    pacMan "${POSITIONAL[@]}" ${interval} ${padding}
fi

# <<<<<<<<<<<<<<<<<<<<<<<< rest of code <<<<<<<<<<<<<<<<<<<<<<<<