#!/usr/bin/env bash

# Get the path and directory of this script.
# https://stackoverflow.com/a/246128
SCRIPT_PATH=${BASH_SOURCE[0]}
while [ -L "$SCRIPT_PATH" ]; do # resolve $SCRIPT_PATH until the file is no longer a symlink
  SCRIPT_DIR=$( cd -P "$( dirname "$SCRIPT_PATH" )" >/dev/null 2>&1 && pwd )
  SCRIPT_PATH=$(readlink "$SCRIPT_PATH")
  [[ $SCRIPT_PATH != /* ]] && SCRIPT_PATH=$SCRIPT_DIR/$SCRIPT_PATH # if $SCRIPT_PATH was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
SCRIPT_DIR=$( cd -P "$( dirname "$SCRIPT_PATH" )" >/dev/null 2>&1 && pwd )

# Make symbolic links under ~
files=(
    .bashrc
    .exrc
    .gvimrc
    .profile
    .tmux.conf
    .vim
    .vimrc
    .zprofile
    .zshrc
)

for f in ${files[@]}
do
    ln --force --symbolic $SCRIPT_DIR/$f ~
done

# Make symbolic links under ~/.config
mkdir --parents ~/.config
files=(
    fish
    starship.toml
)
for f in ${files[@]}
do
    ln --force --symbolic $SCRIPT_DIR/.config/$f  ~/.config
done

