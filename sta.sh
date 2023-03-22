#!/bin/bash

STASH=$(git stash list | fzf | sed 's/\}.*/}/')

if [ -z "$STASH" ];
then
    echo "Exiting without applying any stashes."
else
    git stash apply $STASH
    echo "applied: $STASH"
fi
