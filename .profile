#!/bin/sh

# Search aliases matched with the specified pattern
a() {
    alias | grep "$*"
}

# Checks if a command in the first argument exists or not.
exists() {
    which $1 2> /dev/null > /dev/null
}

new_feature_branch() {
    git fetch --all --prune
    git checkout --no-track origin/main -b masaru-iritani/$@
    gbda
}

path() {
    case $1 in
        "add")
            shift
            for p in $@
            do
                if [ ! -d "$p" ]
                then
                    continue
                fi
                if echo ":$PATH:" | grep -v ":$p:" > /dev/null
                then
                    PATH=$p:$PATH
                fi
            done
            export PATH
            ;;

        "rm")
            shift
            u=""

            for p in `echo -n $PATH | tr ":\n" "\n:"`
            do
                p=`echo -n $p | tr ":\n" "\n:"`
                for q in $@
                do
                    if [ $p = $q ]
                    then
                        p=''
                        break
                    fi
                done

                if [ -n "$p" ]
                then
                    if [ -z "$u" ]
                    then
                        u=$p
                    else
                        u="$u:$p"
                    fi
                fi
            done

            export PATH=$u
            ;;

        "clean")
            shift
            PATH=`echo $PATH | sed -e 's/^:\+//' -e 's/:\+$//' -e 's/::\+/:/'`
            export PATH
            ;;

        "show")
            echo $PATH | tr ":" "\n" | cat -n
            ;;

        *)
            echo $PATH | tr ":" "\n" | cat -n
            ;;
    esac
}

pkg_find() {
    PKG_PATH_HOST=`echo "$PKG_PATH" | cut -d / -f 1-3`/
    PKG_PATH_PATH=/`echo "$PKG_PATH" | cut -d / -f 4-`
    echo "ls $PKG_PATH_PATH/*$**" | ftp $PKG_PATH_HOST
}

title() {
    echo -n "\033]0;$*\007"
}

if ! exists killall
then
    killall() {
        for pnm in $*
        do
            for pid in `pgrep -x $pnm`
            do
                kill -9 $pid
            done
        done
    }
fi

path add {,~}/{,usr/{,local/}}{{,s}bin}

# Add pip binaries (e.g. flake8)
path add ~/.local/bin

# Add psql path on Mac
path add /usr/local/opt/libpq/bin

# Add Go installed binaries
path add $GOBIN
path add $GOPATH/bin

if exists vim
then
    export EDITOR=vim
else
    export EDITOR=vi
fi
export GIT_PS1_SHOWCOLORHINTS="auto"
export GIT_PS1_SHOWDIRTYSTATE="auto"
export GIT_PS1_SHOWSTASHSTATE="auto"
export GIT_PS1_SHOWUPSTREAM="auto"
export GTK_IM_MODULE=ibus
export HISTFILE=~/.bash_history
export HISTSIZE=1000000
if [ "${UID}" != "0" ]
then
    locale -a | grep --quiet 'ja_JP.UTF-8' && export LANG=ja_JP.UTF-8
fi
export LISTMAX=0
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32:or=01;05;31'
if exists lv
then
    export PAGER=lv
else
    export PAGER=less
fi
export PKG_PATH="https://cloudflare.cdn.openbsd.org/pub/`uname -s`/`uname -r`/packages/`uname -m`/"
export PROMPT2='> '
if [ "${UID}" = "0" ]
then
    export PS1="`whoami`@`hostname`# "
else
    export PS1="`whoami`@`hostname`$ "
fi
export QT_IM_MODULE=ibus
export R_LIBS_SITE=`ls -d "~/R/*/*" 2> /dev/null`
export RPROMPT="[%{[33m%}%~%{[m%}] "
export SAVEHIST=$HISTSIZE
export SPROMPT='%r [nyae]? '
export VISUAL=$EDITOR
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
export WWW_HOME=https://duckduckgo.com/
export XMODIFIERS=@im=ibus

alias R='R --no-save'
if exists batcat
then
    # The executable of bat is `batcat` when installed by apt on Ubuntu.
    # https://github.com/sharkdp/bat?tab=readme-ov-file#on-ubuntu-using-apt
    alias bat='batcat'
fi
alias cls='clear'
alias dir='ls -al'
if exists fdfind
then
    # The executable of fd is `fdfind` when installed by apt on Ubuntu.
    # https://github.com/sharkdp/fd?tab=readme-ov-file#on-ubuntu
    alias fd=fdfind
fi
alias gdom='git diff --merge-base origin/main'
alias ghg='git --no-pager log -n 1 --format=%H%n --grep'
alias glom='git log origin/main..HEAD'
alias gnom='git log --name-only origin/main..HEAD'
alias grboma='git rebase --autosquash origin/main'
alias grbomi='git rebase --autosquash --interactive origin/main'
alias ipconfig='ifconfig'
alias jobs='jobs -l'
alias ls_l='ls -l'

# Mac may not have resize command.
if exists resize
then
    alias tail='tail -n`resize 2> /dev/null | eval; expr $LINES - 2`'
fi

# LS OPTS
case "`uname -s`" in
Darwin*)
    alias ls='ls -FG'
    ;;
FreeBSD*)
    alias ls='ls -Gw'
    ;;
OpenBSD*)
    alias ls='ls -F'
    ;;
Linux* | CYGWIN*)
    alias ls='ls -Fhp --color=auto'
    ;;
esac

# KEYCHAIN
if exists keychain
then
    keychain --quiet ~/.ssh/id_rsa
    . ~/.keychain/`hostname`-sh
fi

# EXPORT ALIASES
export ALIASES="`alias`"

# LOAD HOMEBREW ENV VARIABLES
if [ -f "/opt/homebrew/bin/brew" ]
then
   eval "`/opt/homebrew/bin/brew shellenv`"
fi

# LOAD HOST SPECIFIC PROFILE
if [ -f "~/.profile.`hostname`" ]
then
    . ~/.profile.`hostname`
fi
