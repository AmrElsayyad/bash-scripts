#!/usr/bin/env bash

# Title:         urldecode
# Description:   decodes given url
# Author:        Amr Elsayyad <amrelsayyad96@outlook.com>
# Date:          2022-09-08
# Version:       1.0.0

# Exit codes
# ==========
# 0   no error
# 1   script interrupted
# 2   no arguments
# 3   too many arguments


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

# Usage: urldecode url
# Credit: https://unix.stackexchange.com/a/187256
function urldecode () {
    local urlEncoded="${1//+/ }"
    printf '%b' "${urlEncoded//%/\\x}"
}

# <<<<<<<<<<<<<<<<<<<<<<<< functions <<<<<<<<<<<<<<<<<<<<<<<<


# >>>>>>>>>>>>>>>>>>>>>>>> argument parsing >>>>>>>>>>>>>>>>>>>>>>>>


# <<<<<<<<<<<<<<<<<<<<<<<< argument parsing <<<<<<<<<<<<<<<<<<<<<<<<


# >>>>>>>>>>>>>>>>>>>>>>>> rest of code >>>>>>>>>>>>>>>>>>>>>>>>

if (( $# < 1 )); then
    echo "Error: no URL was given." 1>&2
    exit 2
elif (( $# > 1 )); then
    echo "Error: too many arguments were given." 1>&2
    exit 3
else
    # Usage: urlencode url
    urldecode ${1}
    echo
fi

# <<<<<<<<<<<<<<<<<<<<<<<< rest of code <<<<<<<<<<<<<<<<<<<<<<<<