# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: zsh
# Plugin:: faraday
#
export FARADAY_ROOT=/usr/share/python-faraday
export FARADAY_ZSH_HOST=localhost
export FARADAY_ZSH_RPORT=9977

function faraday-zsh() {
    source $FARADAY_ROOT/zsh/faraday.zsh
    export PATH=$PATH:$FARADAY_ROOT/bin
}
