# reloads profile
alias reload='. ~/.bash_profile'
 
# edit and source aliases file
alias va='vi ~/.bash/.bash_aliases; source ~/.bash/.bash_aliases && echo "aliases sourced"'
 
# go up multiple levels
# (also see 'up' function)
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
 
# concise date
alias d='date +%Y%m%d-%H%M'
 
# various ls shortcuts
alias ls='ls -F --color=auto'
alias l='ls'
alias la='ls -a'
alias ll='ls -ltr'
alias lu='ls -ltur'
alias lal='ls -altr'
alias sl='ls'
 
# list dirs only
alias ldir='ll -d */'
 
# less with ignore-case, long-prompt and quit-if-one-screen
alias less='less -iMF'
 
# more is less
alias more='less'
alias mroe='more'
alias m='more'
 
alias h='history'
 
# execute last command
# 'r cc' runs the last command beginning with "cc"
alias r='fc -s'
 
alias igrep='grep -i'
alias rgrep='grep -r'
alias ftail='tail -f'
 
# fast scp
alias scp='scp -o StrictHostKeyChecking=no -c arcfour -o Compression=no'
 
# ps with wide output so you can see full commands
alias fullps='ps -auxwww'
 
# shows all declared functions
alias functions='declare -F'
 
# autosys aliases. All start with "job".
alias jobls='autorep -J'
alias jobll='autorep -q -J'
alias jobstart='sendevent -E FORCE_STARTJOB -J'
alias jobhold='sendevent -E JOB_ON_HOLD -J'
alias jobice='sendevent -E JOB_ON_ICE -J'
alias jobkill='sendevent -E KILLJOB -J'
alias joboffhold='sendevent -E JOB_OFF_ICE -J'
alias joboffice='sendevent -E JOB_OFF_ICE -J'
alias jobhist='jobrunhist -j'
alias jobdepends='job_depends -c -J'
alias jobsu='sendevent -E CHANGE_STATUS -s SUCCESS -J'
alias jobterm='sendevent -E CHANGE_STATUS -s TERMINATED -J'
