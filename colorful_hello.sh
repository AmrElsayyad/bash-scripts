#!/usr/bin/env bash

# Title:         colorful hello
# Description:   print hello world in a colorful way
# Author:        Amr Elsayyad <amrelsayyad96@outlook.com>
# Date:          2022-09-08
# Version:       1.0.0

# Exit codes
# ==========
# 0   no error
# 1   script interrupted


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


# >>>>>>>>>>>>>>>>>>>>>>>> code starts here >>>>>>>>>>>>>>>>>>>>>>>>

# print hello in different colors
for color in {0..7}; do
    echo "$(tput setaf $color)""Hello World!""$(tput sgr0)"
done

# <<<<<<<<<<<<<<<<<<<<<<<< code starts here <<<<<<<<<<<<<<<<<<<<<<<<