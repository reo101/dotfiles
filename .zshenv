export PATH="$HOME/.local/bin:$HOME/.local/bin/statusbar:$HOME/.local/bin/cron:$PATH"
export PATH="$PATH:/opt/texlive/2020/bin/x86_64-linux"
export PATH="$PATH:$HOME/.config/emacs/bin"
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$GEM_HOME/bin"
export TERMINAL="st"
export VISUAL=nvim #vim
export EDITOR="$VISUAL"
export BROWSER="vimb"
export SUDO_ASKPASS="/home/reo101/.local/bin/dmenupass"
export VIMB_DOWNLOAD_PATH="/home/reo101/Downloads"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export SPOTIPY_CLIENT_ID='834dda1a9027409a85cf0c08db55d4d9'
export SPOTIPY_CLIENT_SECRET='faefc1f970b04d3a8ff1bdf66c8f2fa0'
export SPOTIPY_REDIRECT_URI='http://localhost/'
export JAVA_HOME=/usr/lib/jvm/default

# added by hanabi ^_^
export RUSTC_WRAPPER=/usr/bin/sccache #(also checkout ~/.cargo/config because iirc this only applies to pure `rustc` and not cargo)
# The next lines might be to your liking if you want to clean up ~/ a little.
# Btw also always remember to reference your envvars like: "${ENVVAR}" to prevent against vulnerabilities
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CACHE_DHOME="{$HOME}/.cache"
export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/X11/xinitrc"
export XAUTHORITY="${XFG_RUNTIME_DIR}/Xauthority" # This line will break some DMs.
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export GOROOT="/usr/lib/go"
export NOTMUCH_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/notmuch-config"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/shell/inputrc"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export ALSA_CONFIG_PATH="$XDG_CONFIG_HOME/alsa/asoundrc"
export GNUPGHOME="${XDG_DATA_HOME:-$HOME/.local/share}/gnupg"
export WINEPREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/wineprefixes/default"
export STEAM_DIR="$HOME/.local/share/Steam"
export STEAM_RUNTIME=0
export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/password-store"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/android"
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/ansible/ansible.cfg"
export UNISON="${XDG_DATA_HOME:-$HOME/.local/share}/unison"
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share/zsh}/history"
export HISTSIZE=10000000
export SAVEHIST=10000000
setopt SHARE_HISTORY
export QT_QPA_PLATFORMTHEME="gtk2"      # Have QT use gtk2 theme.
export AWT_TOOLKIT="MToolkit wmname LG3D"       #May have to install wmname
export _JAVA_AWT_WM_NONREPARENTING=1    # Fix for Java applications in dwm
export SSLKEYLOGFILE="${XDG_CACHE_HOME:-$HOME/.cache}/ssl-key.log"

### DPI scale
## Qt
# export QT_AUTO_SCREEN_SCALE_FACTOR=1
## GTK 3
# export GDK_SCALE=2
# export GDK_DPI_SCALE=0.5
