#!/usr/bin/env bash

# Title:         banner
# Description:   display a banner
# Author:        Amr Elsayyad <amrelsayyad96@outlook.com>
# Date:          2022-09-08
# Version:       1.0.0

# Exit codes
# ==========
# 0   no error
# 1   script interrupted
# 2   missing argument
# 3   unknown argument


# >>>>>>>>>>>>>>>>>>>>>>>> handler functions >>>>>>>>>>>>>>>>>>>>>>>>

# CTRL+C event handler
function on_ctrl_c() {
    echo # Set cursor to the next line of '^C'
    tput cnorm # show cursor. You need this if animation is used.
    # i.e. clean-up code here
    echo "terminated by signal interrupt" 1>&2
    exit 1 # Don't remove. Use a number (1-255) for error code.
}

# <<<<<<<<<<<<<<<<<<<<<<<< handler functions <<<<<<<<<<<<<<<<<<<<<<<<


# >>>>>>>>>>>>>>>>>>>>>>>> event handlers >>>>>>>>>>>>>>>>>>>>>>>>

# Register CTRL+C event handler
trap on_ctrl_c SIGINT

# <<<<<<<<<<<<<<<<<<<<<<<< event handlers <<<<<<<<<<<<<<<<<<<<<<<<


# >>>>>>>>>>>>>>>>>>>>>>>> functions >>>>>>>>>>>>>>>>>>>>>>>>

# Usage: bannerColor "message" "color" "decorator"
function bannerColor() {
    case ${2} in
        black) color=0
        ;;
        red) color=1
        ;;
        green) color=2
        ;;
        yellow) color=3
        ;;
        blue) color=4
        ;;
        magenta) color=5
        ;;
        cyan) color=6
        ;;
        white) color=7
        ;;
    esac

    local msg="${3} ${1} ${3}"
    local edge
    edge=${msg//?/$3}
    tput setaf ${color}
    tput bold
    echo "${edge}"
    echo "${msg}"
    echo "${edge}"
    tput sgr 0
    echo
}

# <<<<<<<<<<<<<<<<<<<<<<<< functions <<<<<<<<<<<<<<<<<<<<<<<<


# >>>>>>>>>>>>>>>>>>>>>>>> argument parsing >>>>>>>>>>>>>>>>>>>>>>>>

# default color
color='white'

# default decorator
decorator='*'

# argument parsing
POSITIONAL=()
while (( $# > 0 )); do
    case "${1}" in
        -c|--color)
        numOfArgs=1 # number of switch arguments
        if (( $# < numOfArgs + 1 )); then
            echo "missing argument for '${1}' option" >&2
            exit 2
        else
            color=${2}
            shift $((numOfArgs + 1)) # shift 'numOfArgs + 1' to bypass switch and its value
        fi
        ;;
        -d|--decorator)
        numOfArgs=1 # number of switch arguments
        if (( $# < numOfArgs + 1 )); then
            echo "missing argument for '${1}' option" >&2
            exit 2
        else
            decorator=${2}
            shift $((numOfArgs + 1)) # shift 'numOfArgs + 1' to bypass switch and its value
        fi
        ;;
        -m|--message)
        numOfArgs=1 # number of switch arguments
        if (( $# < numOfArgs + 1 )); then
            echo "missing argument for '${1}' option" >&2
            exit 2
        else
            message=${2}
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


# >>>>>>>>>>>>>>>>>>>>>>>> code starts here >>>>>>>>>>>>>>>>>>>>>>>>

# show banner
if (( ${#POSITIONAL[@]} > 0 )); then
    if [ "${message}" ]; then
        echo "argument '${POSITIONAL[@]}' not understood."
        exit 3
    else
        for message in ${POSITIONAL[@]}; do
            bannerColor "${message}" "${color}" "${decorator}"
        done
    fi
elif [ "${message}" ]; then
    bannerColor "${message}" "${color}" "${decorator}"
else    
    echo "No message to display!" 1>&2
fi

# <<<<<<<<<<<<<<<<<<<<<<<< code starts here <<<<<<<<<<<<<<<<<<<<<<<<