    exec i3
    wal -n -R
    [[ -f "$HOME/.Xresources ]] && xrdb -merge -I"$HOME" "$HOME/.Xresources" ]]
