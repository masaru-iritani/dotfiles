export HISTFILE="$HOME/.bash_history"

if which starship &> /dev/null
then
    eval "$(starship init bash)"
else
    echo -e "\033[33mSkipped initializing Starship because it's not installed.\033[0m"
    PS1="\n"
    PS1="${PS1}\[\033[1;32m\]"
    PS1="${PS1}\`date '+%Y-%m-%dT%H:%M:%S'\`"
    PS1="${PS1} \[\033[0m\]"
    PS1="${PS1}\[\033[33m\]"
    PS1="${PS1}\w"
    PS1="${PS1}\[\033[36m\]"
    if which __git_ps1 &> /dev/null
    then
        PS1="${PS1}\`__git_ps1\`"
    fi
    PS1="${PS1}\[\033[00m\]"
    PS1="${PS1}\n"
    PS1="${PS1}\[\033[34m\]"
    PS1="${PS1}\u@\H"
    PS1="${PS1}\[\033[0m\]"
    PS1="${PS1}\$ "
    export PS1
fi

# Install asdf.
# https://asdf-vm.com/guide/getting-started.html#_3-install-asdf
[ -f "$HOME/.asdf/completions/asdf.bash" ] && . "$HOME/.asdf/completions/asdf.bash"
