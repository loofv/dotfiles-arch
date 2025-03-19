#!/bin/bash

REFLOG=$(git reflog -9 | fzf | sed -e 's/^.*HEAD/HEAD/' -e 's/\}.*/}/' | cat)

if [ -z "$REFLOG" ];
then
    echo "no reflog found? exiting."
else
	echo "trying to reset to reflog: $REFLOG"
    git reset --hard $REFLOG
    echo "reset to: $REFLOG"
fi
