# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: zsh
# Plugin:: zcap
#
export ZCAP_DIR=~/.zsh.d/zcap

subdir="`date "+%Y%m%d"`"
zcap_file="zcap-`tty | cut -d/ -f4`-$$.zcap"

if test -z $zcap_running; then
    zcap_running=0
fi

function zcap-start {
    if test ! -d ${ZCAP_DIR}/${subdir}; then
        mkdir -p ${ZCAP_DIR}/${subdir}
    fi

    script -a -f -c "zcap_running=1 zsh" ${ZCAP_DIR}/${subdir}/${zcap_file}
}
