# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: zsh
# Plugin:: bundler
#
alias be="bundle exec"
alias bl="bundle list"
alias bp="bundle package"
alias bo="bundle open"
alias bu="bundle update"
alias bi="bundle_install"

bundled_commands=(
    berks
    foodcritic
    guard
    kitchen
    knife
    rake
    rspec
    rubocop
    spec
    strainer
)

## Functions
_bundler-installed() {
    which bundle > /dev/null 2>&1
}

_within-bundled-project() {
    local check_dir="$PWD"
    while [ "$check_dir" != "/" ]; do
        [ -f "$check_dir/Gemfile" ] && return
        check_dir="$(dirname $check_dir)"
    done
    false
}

_binstubbed() {
    [ -f "./bin/${1}" ]
}

_run-with-bundler() {
    if _bundler-installed && _within-bundled-project; then
        if _binstubbed $1; then
            ./bin/$@
        else
            bundle exec $@
        fi
    else
        $@
    fi
}

## Main program
for cmd in $bundled_commands; do
    eval "function bundled_$cmd () { _run-with-bundler $cmd \$@}"
    alias $cmd=bundled_$cmd

    if which _$cmd > /dev/null 2>&1; then
        compdef _$cmd bundled_$cmd=$cmd
    fi
done
