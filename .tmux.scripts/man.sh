#!/usr/bin/env bash

read selected

tmux neww bash -c "man $selected | bat & while true; do sleep 1; done"
