#!/usr/bin/env bash

# Title:         progress bar
# Description:   a dummy progress bar
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

# Usage: progressBar "message" currentStep totalSteps
function progressBar() {
    local bar='████████████████████'
    local space='....................'
    local wheel=('\' '|' '/' '-')

    local msg="${1}"
    local current=${2}
    local total=${3}
    local wheelIndex=$((current % 4))
    local position=$((100 * current / total))
    local barPosition=$((position / 5))

    echo -ne "\r|${bar:0:$barPosition}$(tput dim)${space:$barPosition:20}$(tput sgr0)|\
     ${wheel[wheelIndex]} ${position}% [ ${msg} ] "
}

# <<<<<<<<<<<<<<<<<<<<<<<< functions <<<<<<<<<<<<<<<<<<<<<<<<


# >>>>>>>>>>>>>>>>>>>>>>>> argument parsing >>>>>>>>>>>>>>>>>>>>>>>>

POSITIONAL=()
while (( $# > 0 )); do
    case "${1}" in
        -f|--flag)
        echo flag: "${1}"
        shift # shift once since flags have no values
        ;;
        -s|--switch)
        numOfArgs=1 # number of switch arguments
        if (( $# < numOfArgs + 1 )); then
            shift $#
        else
            echo "switch: ${1} with value: ${2}"
            shift $((numOfArgs + 1)) # shift 'numOfArgs + 1' to bypass switch and its value
        fi
        ;;
        *) # unknown flag/switch
        POSITIONAL+=("${1}")
        shift
        ;;
    esac
done

set -- "${POSITIONAL[@]}" # restore positional params

# <<<<<<<<<<<<<<<<<<<<<<<< argument parsing <<<<<<<<<<<<<<<<<<<<<<<<


# >>>>>>>>>>>>>>>>>>>>>>>> rest of code >>>>>>>>>>>>>>>>>>>>>>>>

# Usage: progressBar "message" currentStep totalSteps
totalSteps=100

for ((currentStep=1; currentStep <= totalSteps; currentStep++)); do
    sleep 0.1 # simulating one step of job
    progressBar "Installing foo..." "${currentStep}" "${totalSteps}"
done

echo

# <<<<<<<<<<<<<<<<<<<<<<<< rest of code <<<<<<<<<<<<<<<<<<<<<<<<