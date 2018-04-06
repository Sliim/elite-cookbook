# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: zsh
# Plugin:: emacs
#
export EMACS_DAEMON_LOG_FILE="$HOME/.emacs-daemon.log"
export EMACS_CLIENT_BIN="emacsclient"

which emacs-snapshot > /dev/null
if [ $? -eq 0 ]; then
    export EMACS_BIN="emacs-snapshot"
else
    export EMACS_BIN="emacs"
fi

export EDITOR="$EMACS_CLIENT_BIN -t"
export VISUAL="$EMACS_CLIENT_BIN -t"
export ALTERNATE_EDITOR="$EMACS_BIN -nw"

emacs_server_file="/tmp/emacs$UID/server"

alias emacs="$EMACS_BIN --no-site-file --no-site-lisp --no-splash"
alias ed="emacs --daemon >&$EMACS_DAEMON_LOG_FILE"
alias ecli="$EMACS_CLIENT_BIN -n"
alias eshell="emacs -nw -e eshell"
alias epdf="emacs -Q"
alias emacs-daemon-logs="cat $EMACS_DAEMON_LOG_FILE"
alias vi="em"
alias vim="em"

function emacs-daemon-started() {
    return $(test -e $emacs_server_file)
}

function emacs-daemon-start() {
    ed && notify-send "Emacs daemon" "Emacs daemon started." -i emacs -u normal ||
          notify-send "Emacs daemon" "Cannot start Emacs daemon." -i emacs -u critical
}

function emacs-daemon-stop() {
    em --alternate-editor=nil -e "(kill-emacs)" 2>>$EMACS_DAEMON_LOG_FILE
}

function emacs-daemon-restart() {
    emacs-daemon-stop
    emacs-daemon-start
}

function emacs-snapshot-create() {
    dest=~/.emacs.d/snapshots
    snapshot_dir=emacs.d-`date "+%Y%m%d-%s"`

    if test ! -d $dest; then
        mkdir -p $dest
    fi

    cp -r ~/.emacs.d/ /tmp/$snapshot_dir
    $EMACS_BIN --version > /tmp/$snapshot_dir/snapshot-version.txt

    tar cfz $dest/$snapshot_dir.tar.gz --exclude=personal/snapshots -C /tmp/ $snapshot_dir
    rm -rf /tmp/$snapshot_dir
    echo "done."
}

function emacs-daemon-check() {
    if ! emacs-daemon-started; then
        notify-send "Emacs daemon" "Starting Emacs daemon.." -i emacs -u normal
        echo -n "Starting Emacs daemon.."
        emacs-daemon-start
        echo ".done."
    fi
}

function emacs-remove-server-file() {
    rm $emacs_server_file
}

# usage: emacs-client-run <t|c> [file1] [file2..]
function emacs-client-run() {
    if [ $# -lt 1 ] || [ $# -gt 2 ] || [ $1 != "t" -a $1 != "c" ]; then
        echo >&2 "usage: emacs-client-run <t|c> [file]" \
                 >> $EMACS_DAEMON_LOG_FILE
        return 1
    fi

    opt=-$1
    files=""
    if [ $# -eq 2 ]; then
        files=$2
    fi

    emacs-daemon-check
    $EMACS_CLIENT_BIN $opt $files 2>>$EMACS_DAEMON_LOG_FILE

    if [ $? -ne 0 ]; then
        message="Error when invoke $EMACS_CLIENT_BIN. Check log file, if it's a connection refused issue, run emacs-remove-server-file and try again!"
        echo >&2 $message >> $EMACS_DAEMON_LOG_FILE
        notify-send "Emacs client error" $message -i emacs -u critical
    fi
}

function em() {
    emacs-client-run "t" "$@"
}

function ec() {
    emacs-client-run "c" "$@"
}
