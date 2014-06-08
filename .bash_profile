# .bash_profile

#######################
# ##### GENERAL ##### #
#######################
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

if [ -f ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
fi

if [ -d $HOME/perl5 ]; then
    PERL5LIB=$PERL5LIB:$HOME/perl5/lib/perl5/
    export PERL5LIB
fi

#####################################
# ##### ENVIRONMENT VARIABLES ##### #
#####################################
export GZIP="-9"
export GREP_OPTIONS="--color=auto"
export GREP_COLOR="1;35"

export CLICOLOR=true
export PAGER=less
export LESS="-eRX"
export EDITOR=vim

export HISTIGNORE="&:cd:[bf]g:x:c:vib:w:qsc:resource:..:l:ll:ls:llr"
export HISTCONTROL=ignoreboth
export HISTSIZE=1000
export HISTFILESIZE=1000
export HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S:  "

export PROMPT_COMMAND='history -a'
export PROMPT_DIRTRIM=3

PATH=$HOME/usr/local/bin:$PATH

MANPATH=$MANPATH:$HOME/usr/local/man
MANPATH=$MANPATH:$HOME/usr/local/share/man

export PERL5LIB

export PYTHONPATH=$PYTHONPATH:/home/jess/scripts/python/qMSModule
export PYTHONPATH=$PYTHONPATH:/home/jess/scripts/python/vizLib
export PYTHONPATH=$PYTHONPATH:/home/jess/scripts/python/clusteringModule
