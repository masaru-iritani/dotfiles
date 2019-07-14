#!/bin/sh

exists() {
    which $1 2> /dev/null > /dev/null
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

path add {,~}/{,usr/{,local/{,lib/mailman/bin/}}}{{,s}bin,libexec}

if [ "${UID}" = "0" ]
then
    export LANG=C
    export PS1="`whoami`@`hostname`# "
else
    export LANG=ja_JP.UTF-8
    export PS1="`whoami`@`hostname`$ "
fi

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
export QT_IM_MODULE=ibus
export R_LIBS_SITE=`ls -d "~/R/*/*" 2> /dev/null`
export RPROMPT="[%{[33m%}%~%{[m%}] "
export SAVEHIST=$HISTSIZE
export SPROMPT='%r [nyae]? '
export VISUAL=$EDITOR
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
export WWW_HOME=https://www.google.com/
export XMODIFIERS=@im=ibus

alias R='R --no-save'
alias cls='clear'
alias dir='ls -al'
alias ipconfig='ifconfig'
alias jobs='jobs -l'
alias ls_l='ls -l'
alias tail='tail -n`resize 2> /dev/null | eval; expr $LINES - 2`'

if exists cmd.exe
then
    alias cmd='cmd.exe'
fi

if exists powershell.exe
then
    alias powershell='powershell.exe'
fi

if vi --version > /dev/null 2>&1
then
    if exists nvi
    then
        if ! exists vi
        then
            alias vi=nvi
        fi
    else
        alias vi='vim -u NONE -C "+syntax on"'
    fi
fi

if ! exists lv
then
    alias lv=less
fi
if exists trash
then
    if trash > /dev/null 2>&1
    then
        alias rm=trash
    fi
fi

# SSH SERVER ALIVE INTERVAL
if exists bc
then
    SSH_VERSION=`ssh -V 2>&1|sed 's/OpenSSH[-_]\([0-9.]*\).*/\1/'`
    IS_SERVERALIVEINTERVAL_SUPPORTED=`echo "$SSH_VERSION >= 3.8" | bc`
    if [ "$IS_SERVERALIVEINTERVAL_SUPPORTED" = "1" ]
    then
        alias ssh='ssh -o ServerAliveInterval=300'
    fi
fi

# PYTHON 2
PYTHON_VERSION=`python -V 2>&1 | awk 'NR==1{print(int($2))}'`
if [ $PYTHON_VERSION -eq 2 ]
then
    alias python2='python'
elif which seq > /dev/null 2>&1
then
    # Windows Git bash may not have seq...
    for V in `seq 2.9 -0.1 2.0`
    do
        if exists python$V
        then
            alias python2="python$V"
            break
        fi
    done
fi

# TRASH-CLI
if alias python2 > /dev/null 2>&1
then
    if exists trash
    then
        alias 'trash'="python2 `which trash`"
        alias 'list-trash'="python2 `which list-trash`"
        alias 'restore-trash'="python2 `which restore-trash`"
        alias 'empty-trash'="python2 `which empty-trash`"
    fi
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

# GO
#
# export GOROOT=~/go
# case $OSTYPE in
# linux*)   export GOOS=linux   ;;
# freebsd*) export GOOS=freebsd ;;
# darwin*)  export GOOS=darwin  ;;
# esac
# 
# case $MACHTYPE in 
# i[3456]86) export GOARCH='386'   ;;
# x86_64)    export GOARCH='amd64' ;;
# esac

# KEYCHAIN
if exists keychain
then
    keychain --quiet ~/.ssh/id_rsa
    . ~/.keychain/`hostname`-sh
fi

# EXPORT ALIASES
export ALIASES="`alias`"

# LOAD HOST SPECIFIC PROFILE
if [ -f "~/.profile.`hostname`" ]
then
    . ~/.profile.`hostname`
fi
