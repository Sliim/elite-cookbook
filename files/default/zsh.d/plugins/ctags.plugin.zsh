# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: zsh
# Plugin:: ctags
#
which ctags-exuberant > /dev/null
if [ $? -eq 0 ]; then
    alias ctags='ctags-exuberant'
fi
