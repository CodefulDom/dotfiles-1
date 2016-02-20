# Source global definitions.
[ -f /etc/bashrc ] && \
    . /etc/bashrc
if [ -z "$(type -t __git_ps1)" ]; then
    [ -f /etc/profile.d/git-prompt.sh ] && \
        . /etc/profile.d/git-prompt.sh
    [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ] && \
        . /usr/share/git-core/contrib/completion/git-prompt.sh
fi

# Export environment variables.
export EDITOR=vim
export PS1="\[\e[00;32m\]\u@\h \[\e[00;33m\]\w\$(__git_ps1 ' \[\e[00;36m\](%s)')\[\e[0m\]\$ "
export GIT_PS1_SHOWDIRTYSTATE=*
export GIT_PS1_SHOWSTASHSTATE=$

[ -d /s ] && \
    export SRC_PATH="/s"
[ -d $HOME/Source ] && \
    export SRC_PATH="$HOME/Source"
[ -d "$SRC_PATH/rust/src" ] && \
    export RUST_SRC_PATH="$SRC_PATH/rust/src"
[ -f "$SRC_PATH/racer/target/release/racer" ] && \
    export RACER_PATH="$SRC_PATH/racer/target/release/racer"

# User specific aliases, bindings, and functions
alias la='ls -lAh --color=auto'
alias ll='ls -lh --color=auto'
alias irssi='TERM=screen irssi'

if [ ! -z $MSYSTEM ]; then
    export PS1="\[\e[00;33m\]\w\$(__git_ps1 ' \[\e[00;36m\](%s)')\[\e[0m\]\$ "

    [ -d /usr/share/terminfo ] && \
        export TERMINFO=$(cygpath -w /usr/share/terminfo)

    alias grep='grep --color=auto'
    alias cargo='winpty cargo'

    #function cargo() {
    #    local cmd=$1
    #    shift && command cargo $cmd --color always $@
    #}

    bind '"\t":complete'
    bind '"\e[1;5C":forward-word'
    bind '"\e[1;5D":backward-word'
fi

# Disable scroll-lock (Ctrl-s, Ctrl-q)
stty -ixon

