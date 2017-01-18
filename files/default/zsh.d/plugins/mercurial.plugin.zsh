# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: zsh
# Plugin:: mercurial
#
alias hgc='hg commit'
alias hgb='hg branch'
alias hgba='hg branches'
alias hgco='hg checkout'
alias hgd='hg diff'
alias hged='hg diffmerge'
alias hgl='hg pull -u'
alias hgp='hg push'
alias hgs='hg status'
alias hgca='hg qimport -r tip ; hg qrefresh -e ; hg qfinish tip'

function hg_current_branch() {
    if [ -d .hg ]; then
        echo hg:$(hg branch)
    fi
}
