#!/usr/bin/env bash

# Title:         greet
# Description:   a shell script to greet someone
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


# >>>>>>>>>>>>>>>>>>>>>>>> argument parsing >>>>>>>>>>>>>>>>>>>>>>>>

# default value for time of day
time='evening'

# argument parsing
POSITIONAL=()
while (( $# > 0 )); do
    case "${1}" in
        -m|--morning)
        time='morning'
        shift # shift once since flags have no values
        ;;
        -n|--name)
        numOfArgs=1 # number of switch arguments
        if (( $# < numOfArgs + 1 )); then
            echo "missing argument for '${1}' option" >&2
            exit 2
        else
            name=${2}
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

# greeting users
if (( ${#POSITIONAL[@]} > 0 )); then
    if [ "${name}" ]; then
        echo "argument '${POSITIONAL[@]}' not understood."
        exit 3
    else
        for name in ${POSITIONAL[@]}; do
            echo "Good ${time} ${name}!"
        done
    fi
elif [ "${name}" ]; then
    echo "Good ${time} ${name}!"
else
    echo "Good ${time} ${USER}!"
fi

# <<<<<<<<<<<<<<<<<<<<<<<< code starts here <<<<<<<<<<<<<<<<<<<<<<<<