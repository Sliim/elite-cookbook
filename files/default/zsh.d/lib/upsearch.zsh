#!/usr/bin/env zsh
#
# http://unix.stackexchange.com/questions/13464/is-there-a-way-to-find-a-file-in-an-inverse-recursive-search

upsearch() {
  slashes=${PWD//[^\/]/}
  directory="$PWD"
  for (( n=${#slashes}; n>0; --n ))
  do
    test -e "$directory/$1" && echo "$directory/$1" && return
    directory="$directory/.."
  done
}
