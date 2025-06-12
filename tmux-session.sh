#!/bin/bash

SES="mysession"
tmux has-session -t $SES &> /dev/null

if [ $? != 0 ]; then
    tmux new-session -s $SES -d -x- -y-
    tmux set-option base-index 1
    tmux rename-window -t 1 "work"
    tmux send-keys "pcd" C-m
    tmux split-window
    tmux select-pane -t "{top}"
    tmux send-keys "pscd" C-m
    tmux split-window -h
    tmux send-keys "pccd" C-m
    tmux resize-pane -y 15
    tmux select-pane -t "{bottom}"
    tmux send-keys "pcd" C-m
    tmux split-window
    tmux send-keys "pscd" C-m
    tmux split-window -h
    tmux send-keys "pccd" C-m
    tmux resize-pane -y 15
    tmux select-pane -t "{top}"
    tmux new-window -t 2
    tmux rename-window -t 2 "proj"
    tmux split-window
    tmux resize-pane -y 15
    tmux select-pane -t "{top}"
    tmux new-window -t 8
    tmux rename-window -t 8 "psrv"
    tmux send-keys "pssrv" C-m
    tmux split-window -h
    tmux send-keys "pcsrv" C-m
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
