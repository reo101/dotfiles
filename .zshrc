bindkey -v

# git@github.com:zdharma/fast-syntax-highlighting.git
syntaxhl="$HOME/.config/zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"

# wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/lib/completion.zsh
completion="$HOME/.config/zsh/completion.zsh"

# git@github.com:zsh-users/zsh-autosuggestions.git
suggestions="$HOME/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"

# wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/lib/history.zsh
cmdhistory="$HOME/.config/zsh/history.zsh"

# wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/lib/key-bindings.zsh
bindings="$HOME/.config/zsh/key-bindings.zsh"

fzf="$HOME/.config/zsh/.fzf.zsh"

##################################################

[ -f "$syntaxhl" ] && source "$syntaxhl"
if [ -f "$completion" ]; then

    source "$completion"

    # Initialize the completion system
    autoload -Uz compinit

    # Cache completion if nothing changed - faster startup time
    typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
    if [ $(date +'%j') != $updated_at ]; then
        compinit -i
    else
        compinit -C -i
    fi

    # Enhanced form of menu completion called `menu selection'
    zmodload -i zsh/complist

fi
[ -f "$suggestions" ] && source "$suggestions"
[ -f "$cmdhistory" ] && source "$cmdhistory"
[ -f "$bindings" ] && source "$bindings"
[ -f "$fzf" ] && source "$fzf"

##################################################

unset syntaxhl
unset completion
unset suggestions
unset cmdhistory
unset bindings
unset fzf

##################################################

source ~/.aliases
eval "$(starship init zsh)"
