#!/usr/bin/env bash

# Title:         body sort
# Description:   sort body of input, leaving the header as it is.
# Author:        Amr Elsayyad <amrelsayyad96@outlook.com>
# Date:          2022-09-09
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

body() {
    IFS= read -r header
    printf '%s\n' "$header"
    "$@"
}

# <<<<<<<<<<<<<<<<<<<<<<<< functions <<<<<<<<<<<<<<<<<<<<<<<<


# >>>>>>>>>>>>>>>>>>>>>>>> argument parsing >>>>>>>>>>>>>>>>>>>>>>>>


# <<<<<<<<<<<<<<<<<<<<<<<< argument parsing <<<<<<<<<<<<<<<<<<<<<<<<


# >>>>>>>>>>>>>>>>>>>>>>>> rest of code >>>>>>>>>>>>>>>>>>>>>>>>

body sort $@

# <<<<<<<<<<<<<<<<<<<<<<<< rest of code <<<<<<<<<<<<<<<<<<<<<<<<