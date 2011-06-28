# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

export HISTSIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
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

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -lh'
alias la='ls -A'
alias l='ls -CF'

#alias rm='rm -i'
alias rmi='rm -i'
#alias mv='mv -i'
alias mvi='mv -i'
#alias cp='cp -i'
alias cpi='cp -i'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

#export PATH=/usr/lib/oracle/xe/app/oracle/product/10.2.0/server/bin:{$PATH}
#export ORACLE_HOME=/usr/lib/oracle/xe/app/oracle/product/10.2.0/server/
    
#export ORACLE_HOME=/usr/lib/oracle/xe/app/oracle/product/10.2.0/server
#export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/usr/local/lib:$LD_LIBRARY_PATH
#export TNS_ADMIN=/usr/lib/oracle
#export PATH=$PATH:$ORACLE_HOME/bin 


export PATH=$PATH:/usr/local/texlive/2010/bin/i386-linux
#export PATH=/usr/local/pgsql/bin/:/opt/ibm/db2/V9.7/bin:$PATH

# make less more friendly
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

#alias mywn='echo "-over" | xargs wn'
#function my_wn {
#	wn $1 -over
#}

export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;36m'
export LESS_TERMCAP_me=$'\E[0;32m'
export LESS_TERMCAP_se=$'\E[0;36m'
export LESS_TERMCAP_so=$'\E[01;44;32m'
export LESS_TERMCAP_ue=$'\E[01;34m'
export LESS_TERMCAP_us=$'\E[01;35m'




#INFORMIXDIR=/opt/IBM/informix
#INFORMIXSERVER=ol_informix1170
#ONCONFIG=onconfig.ol_informix1170
#INFORMIXSQLHOSTS=/opt/IBM/informix/etc/sqlhosts.ol_informix1170
#PATH=$INFORMIXDIR/bin:$PATH
###PATH=$INFORMIXDIR/bin:$INFORMIXDIR/extend/krakatoa/jre/bin:$PATH
#export INFORMIXDIR INFORMIXSERVER ONCONFIG INFORMIXSQLHOSTS PATH



export MEMCACHED_SERVERS=127.0.0.1


#fcitx

export XMODIFIERS=”@im=fcitx”

export XIM=fcitx

export XIM_PROGRAM=fcitx


#source ~/perl5/perlbrew/etc/bashrc

#alias pmversion="perl -le '\$m = shift; eval qq(require \$m) or die qq(module \"\$m\" is not installed\n\n); print \$m->VERSION;'"

function pmversion() {
        perl -M$1 -le "print $1->VERSION";
}
