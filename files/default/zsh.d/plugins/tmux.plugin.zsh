# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: zsh
# Plugin:: tmux
#
alias tmux="tmux -2"

[ -n "$TMUX" ] && export TERM=xterm-256color

function tmux-colors () {
    for i in {0..255} ; do
        printf "\x1b[38;5;${i}mcolour${i}\n"
    done
}

function tmux-send-keys() {
    tmux send-keys -t "$4:$2.$3" "$1"
}

function tmux-run-cmd() {
    tmux-send-keys "$1" "$2" "$3" "$4"
    tmux-send-keys "C-m" "$2" "$3" "$4"
}
