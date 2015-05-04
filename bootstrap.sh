#!/bin/sh
DOTFILESDIR=$(cd "$(dirname "$0")"; pwd)
export LC_ALL="en_US.UTF-8"

cd "$DOTFILESDIR"
git submodule init
git submodule update --remote

cd ~
for F in $DOTFILESDIR/*; do
  rm -Irf "$F"
  ln -s "$DOTFILESDIR/$F"
done
rm .git .gitmodules bootstrap.sh
