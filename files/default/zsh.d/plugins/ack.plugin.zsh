# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: zsh
# Plugin:: ack
#
export ACKRC=".ackrc"

which ack-grep > /dev/null
if [ $? -eq 0 ]; then
    alias ack='ack-grep'
fi
