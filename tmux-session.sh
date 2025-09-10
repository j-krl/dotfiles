#!/bin/bash

SES="mysession"
tmux has-session -t $SES &> /dev/null

if [ $? != 0 ]; then
    tmux new-session -s $SES -d -x- -y-
    tmux set-option base-index 1
    tmux rename-window -t 1 "proj"
    tmux split-window
    tmux select-pane -t "{top}"
    tmux split-window -h
    tmux resize-pane -y 12
    tmux select-pane -t "{bottom}"
    tmux split-window
    tmux split-window -h
    tmux resize-pane -y 12
    tmux select-pane -U
    tmux new-window -t 2
    tmux rename-window -t 2 "nb"
    tmux split-window -h
    tmux select-pane -L
    tmux new-window -t 8
    tmux rename-window -t 8 "srv"
    tmux split-window -h
    tmux select-pane -L
    tmux new-window -t 9
    tmux rename-window -t 9 "term"
    tmux split-window
    tmux split-window
    tmux select-layout even-vertical
    tmux select-pane -t "{top}"
    tmux select-window -t 1
fi

tmux attach -t $SES
