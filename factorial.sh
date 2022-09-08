#!/usr/bin/env bash

# Title:         factorial
# Description:   calculate factorial of a number
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

# Usage: factorial n
factorial ()
{
    if (( $1 < 2 )); then
        echo 1
    else
        echo $(( $1 * $(factorial $(( $1 - 1 ))) ))
    fi
}

# <<<<<<<<<<<<<<<<<<<<<<<< functions <<<<<<<<<<<<<<<<<<<<<<<<


# >>>>>>>>>>>>>>>>>>>>>>>> code starts here >>>>>>>>>>>>>>>>>>>>>>>>

if (($# == 1)); then
    # Usage: factorial n
    readarray -t result < <(factorial $1)
    echo "${result[@]}"
elif (($# == 0)); then
    echo "Please enter number to get its factorial!"
    exit 2
else
    echo "Error parsing arguments!"
    exit 3
fi

# <<<<<<<<<<<<<<<<<<<<<<<< code starts here <<<<<<<<<<<<<<<<<<<<<<<<