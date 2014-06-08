if [ -r /opt/applications/Modules/current/init/bash ]; then
	source /opt/applications/Modules/current/init/bash
fi

# .bashrc

#######################
# ##### GENERAL ##### #
#######################
# Source Bash completion
if [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
fi

# Source custom Bash completions
if [ -f ~/.bash_completion ]; then
   source ~/.bash_completion
fi

# Source custom aliases
if [ -f ~/.aliases ]; then
   source ~/.aliases
fi

########################
# ##### SETTINGS ##### #
########################
ulimit -S -c 0        # Don't want any coredumps
#set -o notify
set -o noclobber
set -o ignoreeof
#set -o nounset
#set -o xtrace        # Useful for debuging

shopt -s cdspell
shopt -s checkhash
shopt -s checkwinsize
shopt -s sourcepath
shopt -s no_empty_cmd_completion
shopt -s expand_aliases

#shopt -s cdable_vars
#shopt -s mailwarn
#shopt -s cmdhist
#shopt -s histappend histreedit histverify
#shopt -s lithist
#shopt -s extglob
#shopt -s dotglob
#shopt -s progcomp
#shopt -s promptvars
#shopt -s hostcomplete
#shopt -s interactive_comments

complete -d pd cd rmd

#########################
# ##### FUNCTIONS ##### #
#########################

function    rmd              { /bin/rm -fr $@; }

function    x                { exit; }

function    e                { ${EDITOR} $@; }
function    p                { ${PAGER}  $@; }

function    c                { clear; }
function    h                { history $@; }
function    hc               { history -c; }
function    hcc              { hc;c; }
function    hg               { history | grep $@ | sed '$d'; }

function    ..               { cd ..; }
function    ...              { cd ../..; }
function    ....             { cd ../../..; }
function    .....            { cd ../../../..; }

function    ff               { find . -name $@ -print; }
# Find a file with a pattern in name
function    ffp              { find . -type f -iname '*'$*'*' -ls ; }
# Find a file with pattern $1 in name and Execute $2 on it:
function    fe               { find . -type f -iname '*'$1'*' -exec "${2:-file}" {} \;  ; }

# Show the definition(s) of shell functions
function    fdef             { declare -f $1 ;}

# Process management
function    psa              { ps aux $@; }
function    psu              { ps  ux $@; }
function    psg              { ps ax | grep $@ | fgrep -v "grep $@"; }
function    lpsa             { ps aux $@ | p; }
function    lpsu             { ps  ux $@ | p; }
function    myps             { ps $@ -u $USER -o pid,%cpu,%mem,time,command ; }
function    pp               { myps f | awk '!/awk/ && $0~var' var=${1:-".*"} ; }

# Estimate file space usage 
function    duh	             { du --max-depth=1 -h $@; }
function    dus              { du -k $@ | sort -rn; }

# .bashrc functions
function    vib              { e ~/.bashrc && . ~/.bashrc; }
function    resource         { . ~/.bashrc; }

# Compression functions
function    co               { tar jcf $1.tar.bz2 $1; }
function    uco              { tar jxf $1; }

# List the difference between two directories
function    dirq             { diff -rq $1 $2; }

# Backup
function    bak              { cp $1 $1.bak; }

function rename {
   for f in *.$1;
      do mv $f ${f%$1}$2
   done
}

function rept { 
   delay=$1;
   shift;
   while true; do
      eval "$@";
      sleep $delay;
   done
}

# Backup functions
function buh () { cp $1 ~/.backup/${1}-`date +%Y%m%d%H%M`.backup; }

function bu () { 
    if [ "`dirname $1`" == "." ]; then 
        mkdir -p ~/.backup/`pwd`; 
        cp $1 ~/.backup/`pwd`/$1-`date +%Y%m%d%H%M`.backup; 
    else 
        mkdir -p ~/.backup/`dirname $1`; 
        cp $1 ~/.backup/$1-`date +%Y%m%d%H%M`.backup; 
    fi 
} 

##############################
# ##### PROMPT SECTION ##### #
##############################

function prompt  {
    local NONE="\[\033[0m\]"    # unsets color to term's fg color

    # regular colors
    local K="\[\033[0;30m\]"    # black
    local R="\[\033[0;31m\]"    # red
    local G="\[\033[0;32m\]"    # green
    local Y="\[\033[0;33m\]"    # yellow
    local B="\[\033[0;34m\]"    # blue
    local M="\[\033[0;35m\]"    # magenta
    local C="\[\033[0;36m\]"    # cyan
    local W="\[\033[0;37m\]"    # white

    # emphasized (bolded) colors
    local EMK="\[\033[1;30m\]"
    local EMR="\[\033[1;31m\]"
    local EMG="\[\033[1;32m\]"
    local EMY="\[\033[1;33m\]"
    local EMB="\[\033[1;34m\]"
    local EMM="\[\033[1;35m\]"
    local EMC="\[\033[1;36m\]"
    local EMW="\[\033[1;37m\]"

    # background colors
    local BGK="\[\033[40m\]"
    local BGR="\[\033[41m\]"
    local BGG="\[\033[42m\]"
    local BGY="\[\033[43m\]"
    local BGB="\[\033[44m\]"
    local BGM="\[\033[45m\]"
    local BGC="\[\033[46m\]"
    local BGW="\[\033[47m\]"

    if [ $UID == 0 ]; then
        local UC="${EMR}"
    else
        local UC="${G}"
    fi

    color="$(eval echo '$'$1)"
    PS1="${W}${UC}\u${W}@${color}\h${W}:${Y}\w${W}${EMM}\$(__git_ps1)${W}\\\$${NONE} "
}

case $HOSTNAME in
    dhcp*)      prompt R;;
    garibaldi*) prompt W;;
    *)          prompt R;;
esac

unset prompt
