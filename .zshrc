#!/usr/bin/env zsh

. <(echo "$ALIASES" | awk '$0 {print $0 ~ "alias " ? $0 : "alias " $0}')
alias mmv='zmv -W'
alias reload='rehash && . ~/.zprofile && . ~/.zshrc'
alias w3m='noglob w3m'
alias zmv='noglob zmv'

# -U: Do not use aliases in reading functions
# -z: Load functions in zsh-style (Not used for compatibility)
autoload -U add-zsh-hook
autoload -U colors
autoload -U compinit
autoload -U hitsory-search-end
autoload -U is-at-least
autoload -U vcs_info
# autoload -U zargs
# autoload -U zsh/files # Avoid argument length limitation
# autoload -U predict-on
autoload -U zmv

bindkey -e
bindkey '^N' history-beginning-search-forward
bindkey '^P' history-beginning-search-backward
bindkey '^U' backward-kill-line
# bindkey -s '^Z' 'q%'

colors
compinit -u

export HISTFILE=~/.zsh_history
export PROMPT='%(!.%{${fg[red]}%}.%{${fg[cyan]}%})%n@%m@20%DT%*%f
${vcs_info_msg_0_}
%{${reset_color}%}%(?.%{${fg[green]}%}.%{${fg[red]}%})%(!.#.$)%{${reset_color}%} '
export RPROMPT=''
export LANG=ja_JP.UTF-8
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32:or=01;05;31'

function _chpwd_ls() {
    ls
}

function _precmd_hr() {
    echo
    echo "${fg[gray]}$(printf '-%.0s' {1..$COLUMNS})${reset_color}"
}

function _precmd_rename_tmux_window() {
    if test -n "$TMUX"
    then
        tmux -q rename-window $(basename $(print -P '%~')) > /dev/null
    fi
}

function _precmd_update_screen_title() {
    if exists screen
    then
        screen -X title $(basename $(print -P '%~')) > /dev/null
    fi
}

function _preexec_resize_tmux_window() {
    resize 2> /dev/null | eval
    if test -n "$TMUX"
    then
        tmux -q setw automatic-rename on > /dev/null
    fi
}

add-zsh-hook chpwd _chpwd_ls
add-zsh-hook precmd vcs_info
add-zsh-hook precmd _precmd_hr
add-zsh-hook precmd _precmd_rename_tmux_window
add-zsh-hook precmd _precmd_update_screen_title
add-zsh-hook preexec _preexec_resize_tmux_window

# limit coredumpsize 0 # error on Cygwin
# predict-on

setopt auto_list

# Append / for directory completions
setopt auto_param_keys

setopt auto_pushd
setopt auto_menu
setopt auto_param_keys
setopt auto_param_slash
setopt autoremoveslash

# Auto-correct misspelling
setopt correct

# setopt equals # Expand =cmd into path of cmd
# setopt extended_glob # Treat '#', '~', and '^' as regular expression
setopt extended_history # Add timestamp to HISTFILE
setopt hist_ignore_all_dups # Eliminate all duplication
setopt hist_ignore_dups # Eliminate neighbor duplication
setopt hist_ignore_space
setopt hist_save_nodups
# setopt hist_verify # Edit history expansion like !$ before execution
setopt list_types # Show file type in completion like ls -F
setopt list_packed # Show file completion in compact list
setopt magic_equal_subst # Expand var=expr
setopt numeric_glob_sort # Show file completion in numeric order
# setopt no_clobber # Prohibit overwrite redirect

# Disable C-s and C-q.
setopt no_flow_control

setopt no_hup # Do not exit on C-d
setopt nolistbeep
setopt notify # Notify job status immediately
setopt multios
setopt print_eight_bit
# setopt print_exit_value

# Expand variables in prompt messages
# whenever the prompt is shown.
setopt prompt_subst
setopt promptcr
setopt pushd_ignore_dups
setopt rm_star_silent

# Share the command history with other terminals.
setopt share_history

# setopt single_line_zle

zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' format '%B*%d*%b'
zstyle ':completion:*' verbose yes
# Ignore the case when there is no exact-matching completion.
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*:descriptions' format '%F{gray}%d%f'

# actionformats is a list of formats, used if there is a special action
# like an interactive rebase or a merge conflict.
zstyle ':vcs_info:*' actionformats '%s:%R//%S:%b (%a)'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' formats '%F{green}%s:%m:%b%c%u:%F{gray}%R%F{green}/%S%f'
zstyle ':vcs_info:*' nvcsformats '%F{yellow}%~%f'
zstyle ':vcs_info:*' stagedstr '%F{red}*%f'
zstyle ':vcs_info:*' unstagedstr '%F{red}+%f'
zstyle ':vcs_info:git+set-message:*' hooks git-config-user

# Defines a hook function to store the Git user e-mail address into %m.
function +vi-git-config-user() {
    hook_com[misc]+=`git config user.email`
}

if exists tmux
then
    if test -z "$TMUX"
    then
        tmux attach-session 2> /dev/null || tmux new-session
    fi
fi

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f ~/node_modules/tabtab/.completions/serverless.zsh ]] && . ~/node_modules/tabtab/.completions/serverless.zsh

# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f ~/node_modules/tabtab/.completions/sls.zsh ]] && . ~/node_modules/tabtab/.completions/sls.zsh

_chpwd_ls
true
