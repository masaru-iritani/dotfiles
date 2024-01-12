export HISTFILE="$HOME/.bash_history"

if exists starship
then
    eval "$(starship init bash)"
else
    PS1="\n"
    PS1="${PS1}\[\033[1;32m\]"
    PS1="${PS1}\`date '+%Y-%m-%dT%H:%M:%S'\`"
    PS1="${PS1} \[\033[0m\]"
    PS1="${PS1}\[\033[33m\]"
    PS1="${PS1}\w"
    PS1="${PS1}\[\033[36m\]"
    if which __git_ps1 > /dev/null 2>&1
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
