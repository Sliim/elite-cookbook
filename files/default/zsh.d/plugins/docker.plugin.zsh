# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: zsh
# Plugin:: docker
#
alias docker-pkill='docker kill $(docker ps -q)'
alias docker-rmc='docker rm $(docker ps -a -q)'
alias docker-rmi-untagged='docker rmi $(docker images -q -f dangling=true)'
alias docker-rmi-all='docker rmi $(docker images -q)'
