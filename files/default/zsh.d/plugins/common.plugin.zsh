# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: zsh
# Plugin:: common
#
function source-gpg {
    c=$(gpg -q -d $1); eval $c; unset c
}
