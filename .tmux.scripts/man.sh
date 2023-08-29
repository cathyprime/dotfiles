#!/usr/bin/env bash

read selected

tmux neww -t 100 bash -c "man $selected & while true; do sleep 1; done"
