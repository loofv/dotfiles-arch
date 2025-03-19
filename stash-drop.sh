#!/bin/bash

STASH=$(git stash list | fzf | sed 's/\}.*/}/')

if [ -z "$STASH" ];
then
    echo "Exiting without dropping any stashes."
else
    git stash drop $STASH
    echo "dropped: $STASH"
fi
