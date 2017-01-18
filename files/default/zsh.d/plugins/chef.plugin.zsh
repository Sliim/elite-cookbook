# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: zsh
# Plugin:: chef
#
# Kitchen
alias kitchen-destroy-and-test="bundle exec kitchen destroy all && bundle exec kitchen test"
alias kitchen-destroy-all="bundle exec kitchen destroy all"
alias kitchen-test="bundle exec kitchen test"
alias kitchen-console="bundle exec kitchen console"
alias kitchen-init="bundle exec kitchen init"
alias kitchen-list="bundle exec kitchen list"
alias kitchen-version="bundle exec kitchen version"
alias kitchen-verify="bundle exec kitchen verify"
alias kitchen-setup="bundle exec kitchen setup"
alias kitchen-login="bundle exec kitchen login"
alias kitchen-converge="bundle exec kitchen converge"
alias kitchen-create="bundle exec kitchen create"
alias kitchen-help="bundle exec kitchen help"

function erb-template-lint() {
    erb -P -x -T '-' $1 | ruby -c
}
