#!/usr/bin/env bash

BLACKLIST=".
..
.git
"

for file in .*
do
  if [[ $BLACKLIST =~ $file ]]
  then
    echo Ignoring blacklisted file: $file
  else
    echo Creating symlink for: $file in $HOME
    ln -s $PWD/$file $HOME/$file
  fi
done
