# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: zsh
# Plugin:: ssync

function ssync() {
  sc-syncer -o $HOME/musics/soundcloud-sync -L 100 --convert --client-id $SC_CLIENT_ID -u $1
}

function ssync-track() {
  sc-syncer -o $HOME/musics/soundcloud-sync -L 100 --convert --client-id $SC_CLIENT_ID -t -u $1
}

function soundcloud-likes() {
    mplayer $(ls -t `find $HOME/musics/soundcloud-sync -path $HOME/musics/soundcloud-sync/artworks -prune -o -type f -print`)
}
