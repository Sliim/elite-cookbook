# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: zsh
# Plugin:: msf
#
test -e $MSFRPC_HOST && export MSFRPC_HOST="127.0.0.1"
test -e $MSFRPC_PORT && export MSFRPC_PORT="55554"
test -e $MSFRPC_USER && export MSFRPC_USER="msf"
test -e $MSFRPC_PASS && export MSFRPC_PASS="msf"
test -e $MSFRPC_TOKEN && export MSFRPC_TOKEN="msf"
test -e $MSFRPC_SSL && export MSFRPC_SSL=false
test -e $MSFRPC_URI && export MSFRPC_URI=/api/
