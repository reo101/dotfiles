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

emacs --daemon &

xmodmap -e "keycode 94 = backslash"
xmodmap -e "clear Lock" -e "keycode 0x42 = Escape"

### WM/DE

case $(tty | cut -b9-) in
	(1) exec dwm            ;;
	(2) exec xmonad         ;;
	(3) exec bspwm          ;;
esac
