# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: zsh
# Plugin:: stumpwm
#
function stumpish/eval-lisp () {
    echo $1 | ~/bin/stumpish -e eval | sed "s/\"//g"
}

function stumpwm/get-group-name () {
    stumpish/eval-lisp '(stumpwm::group-name (current-group))'
}

function stumpwm/get-group-list () {
    grouplist=$(stumpish/eval-lisp '(dolist (group (stumpwm::sort-groups (current-screen))) (setf groupname (stumpwm::group-name group)) (when (eq group (current-group)) (setf groupname (concat "*" groupname "*")))(message groupname))')
    echo $grouplist | tr '\n' ' ' | sed 's/ NIL //g'
}

function stumpwm/get-window-name () {
    stumpish/eval-lisp '(stumpwm::window-name (current-window))'
}

function stumpwm/get-window-list () {
    windowlist=$(stumpish/eval-lisp '(dolist (window (stumpwm::group-windows (current-group))) (setf winname (stumpwm::window-name window)) (when (eq window (current-window)) (setf winname (concat "*" winname "*")))(message winname))')
    echo $windowlist | tr '\n' ' ' | sed 's/ NIL //g'
}
