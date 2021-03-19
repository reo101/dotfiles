xrandr --output Virtual-1 --mode 1280x800 &

mpd &
#mpd-notification &
mpd_discord_richpresence --fork --no-idle

wal -R

# xrdb ${XDG_CONFIG_HOME:-$HOME/.config}/Xresources &

xcompmgr &

dunst &

setxkbmap -layout us,bg -variant ,phonetic -option grp:lalt_lshift_toggle &

unclutter --timeout 3 --jitter 75 --ignore-scrolling &

systemctl --user import-environment DISPLAY

export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

clipmenud &

xset r rate 300 50 &

#if [[ -z "$DISPLAY" ]]; then
#    if [[ $(tty) = /dev/tty1 ]]; then
#        exec dwm
#    elif [[ $(tty) = /dev/tty2 ]]; then
#        exec bspwm
#    el then
#        echo "No WM fo you bud"
#    fi
#fi

#while true; do
#    dwm >/dev/null 2>&1
#    dwmblocks &
#done

xmodmap -e "keycode 94 = backslash"

dwmblocks &
exec dwm
