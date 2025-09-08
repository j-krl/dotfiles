#!/bin/bash

SES="mysession"
tmux has-session -t $SES &> /dev/null

if [ $? != 0 ]; then
    tmux new-session -s $SES -d -x- -y-
    tmux set-option base-index 1
    tmux rename-window -t 1 "proj"
    tmux send-keys "cd programming" C-m
    tmux split-window
    tmux send-keys "cd programming" C-m
    tmux resize-pane -y 15
    tmux select-pane -t "{top}"
    tmux new-window -t 2
    tmux send-keys "cd programming" C-m
    tmux rename-window -t 2 "proj2"
    tmux split-window
    tmux send-keys "cd programming" C-m
    tmux resize-pane -y 15
    tmux select-pane -t "{top}"
    tmux new-window -t 9
    tmux rename-window -t 9 "cfg"
    tmux send-keys "nvcd" C-m
    tmux split-window
    tmux send-keys "nvcd" C-m
    tmux resize-pane -y 15
    tmux select-pane -t "{top}"
    tmux select-window -t 1
fi

tmux attach -t $SES
