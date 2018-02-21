# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: zsh
# Plugin:: msf
#
test -z "$MSFRPC_HOST" && export MSFRPC_HOST="127.0.0.1"
test -z "$MSFRPC_PORT" && export MSFRPC_PORT="55554"
test -z "$MSFRPC_USER" && export MSFRPC_USER="msf"
test -z "$MSFRPC_PASS" && export MSFRPC_PASS="msf"
test -z "$MSFRPC_TOKEN" && export MSFRPC_TOKEN="msf"
test -z "$MSFRPC_SSL" && export MSFRPC_SSL=false
test -z "$MSFRPC_URI" && export MSFRPC_URI=/api/
