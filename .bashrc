# don't save command history
unset HISTFILE
 
# don't save duplicates in history
HISTCONTROL=ignoredups
 
EDITOR=vi
VISUAL=vim
PAGER='less -i'
 
set -o notify   # Report status of terminated bg jobs immediately
set -o emacs    # emacs-style editing
 
shopt -s extglob   # extended pattern matching features
shopt -s cdspell   # correct dir spelling errors on cd
shopt -s lithist   # save multi-line commands with newlines
shopt -s autocd    # if a command is a dir name, cd to it
shopt -s checkjobs # print warning if jobs are running on shell exit
shopt -s dirspell  # correct dir spelling errors on completion
shopt -s globstar  # ** matches all files, dirs and subdirs
shopt -s cmdhist   # save multi-line commands in a single hist entry
shopt -s cdable_vars # if cd arg is not a dir, assume it is a var
shopt -s checkwinsize # check the window size after each command
shopt -s no_empty_cmd_completion # don't try to complete empty cmds
 
# enable coloured man pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
 
# define some colours
GREY=$'\033[1;30m'
RED=$'\033[1;31m'
GREEN=$'\033[1;32m'
YELLOW=$'\033[1;33m'
BLUE=$'\033[1;34m'
MAGENTA=$'\033[1;35m'
CYAN=$'\033[1;36m'
WHITE=$'\033[1;37m'
NONE=$'\033[m'
 
# random grep colour
export GREP_COLOR="1;3$((RANDOM%6+1))"
export GREP_OPTIONS='--color=auto'
 
# path for directories
export CDPATH=".:..:../..:~/:~/dev/"
 
# file containing hosts
export HOSTFILE=~/.hosts
 
# source everything else
. ~/.bash/.bash_prompt
. ~/.bash/.bash_completion
. ~/.bash/.bash_aliases
. ~/.bash/.bash_functions
 
# trap commands to display on the xterm titlebar. Must be last line.
trap 'echo -ne "\033]0;$BASH_COMMAND - $USER@${HOSTNAME}>$(pwd)\007"' DEBUG