# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: zsh
# Plugin:: yoda
#
function yoda_load_workspace_list (){
    for ws in $(python -c "from yoda import Config, Workspace; ws = Workspace(Config('$HOME/.yodarc')); print('\n'.join(ws.list().keys()))"); do
        YODA_WORKSPACE_LIST+=($ws)
    done
    export YODA_WORKSPACE_LIST
}

function yoda_load_repository_list () {
    for repo in $(echo -e "from yoda import Config, Workspace; ws = Workspace(Config('$HOME/.yodarc'))\nfor k, v in ws.list().items():\n\tfor repo in v['repositories']: print('%s/%s' % (k, repo))" | python); do
        YODA_REPOSITORY_LIST+=($repo)
    done
    export YODA_REPOSITORY_LIST
}

function yoda_reload_environment () {
    yoda_load_workspace_list
    yoda_load_repository_list
}
