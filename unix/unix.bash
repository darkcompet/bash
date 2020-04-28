## original bashrc in ubuntu
case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth

shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then

    color_prompt=yes
    else
    color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


## my-bashrc
alias .="cd .."
alias b="subl ~/.bashrc"
alias cd="cdls"
alias cp="cp -i"
alias cl="clear"
alias c="pwd | xsel -b"
alias et="extract"
alias eb="source ~/.bashrc"
alias ls="ls --color=auto -a"
alias mv="mv -i"
alias op="nautilus"
alias rm="rm -i"
alias sl="subl"
alias t="platex main.tex"
alias tt="dvipdfmx main.dvi"
alias ub="cp ~/.bashrc ~/.../manual"
alias v="xsel --clipboard --output"

cdls () {
    \cd "$@" ;
    ls ;
}

extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2 )   tar xjf $1     ;;
            *.tar.gz )    tar xzf $1     ;;
            *.bz2 )       bunzip2 $1     ;;
            *.rar )       unrar e $1     ;;
            *.gz )        gunzip $1      ;;
            *.tar )       tar xf $1      ;;
            *.tbz2 )      tar xjf $1     ;;
            *.tgz )       tar xzf $1     ;;
            *.zip )       unzip $1       ;;
            *.Z )         uncompress $1  ;;
            *.7z )        7z x $1        ;;
            * )           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
