#!/bin/bash
SESSION_NAME="default"

# Create a new session or attach to an existing one
/opt/homebrew/bin/tmux new-session -A -s $SESSION_NAME

