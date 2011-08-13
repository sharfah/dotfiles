#
# bash_functions
#

#
# moves file to ~/.Trash
# (use instead of rm)
#
trash(){
   if [ $# -eq 0 ]
   then
       echo Usage: trash FILE...
       return 1
   fi
   local DATE=$(date +%Y%m%d)
   [ -d "${HOME}/.Trash/${DATE}" ] || mkdir -p ${HOME}/.Trash/${DATE}
   for FILE in "$@" 
   do
     mv "${FILE}" "${HOME}/.Trash/${DATE}"
     echo "${FILE} trashed!"   
   done
}

#
# Calculate an expression e.g. calc 1+1
#
calc(){ 
    echo "$@"|bc -l; 
}

#
# Color-less
#
cless(){
    if [ $# -eq 0 ]
    then
        echo Usage: cless FILE
        return 1
    fi
    grc cat $1 | less -R
}

#
# list log files
# (files open for writing)
#
lslf(){
    if [ $# -eq 0 ]
    then
        echo "Usage: lslf PID (lists log files open by process)"
        return 1
    fi
    lsof -p $1 | awk '$4 ~ /w$/ && $9 != "" {print $9}' | sort -u
}

#
# Calendar which starts on Monday
# Highlights current day
#
cal(){
    if [ $# -eq 0 ]
    then
        /usr/bin/cal -m | grep --color=auto -E "( |^)$(date +%e)|$"
    else
        /usr/bin/cal -m "$@"    
    fi
}

#
# Email me a short note
#
emailme(){
    if [ $# -eq 0 ]
    then
        echo Usage: emailme text
        return 1
    fi
    echo "$@" | mailx -s "$@" fahds
    echo "Sent email"
}

#
# fast find, using globstar
#
ff () { 
   ls -ltr **/$@
}

#
# remembers directories
#
cd_func ()
{
  local x2 the_new_dir adir index
  local -i cnt
  
  the_new_dir=$1
  [[ -z $1 ]] && the_new_dir=$HOME

  if [[ ${the_new_dir:0:1} == '-' ]]; then
    #
    # Extract dir N from dirs
    index=${the_new_dir:1}
    [[ -z $index ]] && index=1
    adir=$(dirs +$index)
    [[ -z $adir ]] && return 1
    the_new_dir=$adir
  fi

  #
  # '~' has to be substituted by ${HOME}
  [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"

  #
  # Now change to the new dir and add to the top of the stack
  pushd "${the_new_dir}" > /dev/null
  [[ $? -ne 0 ]] && return 1
  the_new_dir=$(pwd)

  #
  # Trim down everything beyond 11th entry
  popd -n +20 2>/dev/null 1>/dev/null

  #
  # Remove any other occurence of this dir, skipping the top of the stack
  for ((cnt=1; cnt <= 10; cnt++)); do
    x2=$(dirs +${cnt} 2>/dev/null)
    [[ $? -ne 0 ]] && return 0
    [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
    if [[ "${x2}" == "${the_new_dir}" ]]; then
      popd -n +$cnt 2>/dev/null 1>/dev/null
      cnt=cnt-1
    fi
  done

  return 0
}
alias cd=cd_func

#
# Jumps to a directory at any level below.
# using globstar
#
jd(){
    if [ -z $1 ]; then
        echo "Usage: jd [directory]";
        return 1
    else
        cd **/$@
    fi
}

#
# Go up a specified number of directories
#
up(){
    if [ -z $1 ]
    then
      cd ..
      return
    fi   
    local levels=$1
    local result="."
    while [ $levels -gt 0 ]
    do
        result=$result/..
        ((levels--))
    done
    cd $result
}

#
# Go up to the specified directory
#
upto(){
    if [ -z $1 ]; then
        echo "Usage: upto <dir>"
        return 1
    fi;
    local upto=$1;
    cd "${PWD/\/$upto\/*//$upto}"
}

#
# Make a directory and change to it
#
mkcd() {
  if [ $# -ne 1 ]; then
         echo "Usage: mkcd <dir>"
         return 1
  else
         mkdir -p $1 && cd $1
  fi
}

#
# Prints out a long line. Useful for setting a visual flag in your terminal.
#
flag(){
    echo -e  "\e[1;36m[==============="$@"===\
             ($(date +"%A %e %B %Y %H:%M"))\
             ===============]\e[m"
}

#
# Swap two files
#
swap(){
    if [ $# -ne 2 ]
    then
        echo Usage: swap file1 file2
        return 1
    fi
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

#
# Backup file(s)
#
dbackup(){
    if [ $# -lt 1 ]
    then
        echo Please supply a file to backup
        return 1
    fi
    date=`date +%Y%m%d-%H%M`
    for i in "$@"
    do
        echo Backed up $i to $i.$date
        cp $i $i.$date
    done
}


#
# Extract an archive of any type
#
extract () {
   if [ $# -lt 1 ]
   then
       echo Usage: extract file
       return 1
   fi
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1     ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.war|*.jar) unzip $1       ;;           
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
}

#
# Creates an archive
#
roll () {
  if [ "$#" -ne 0 ] ; then
    FILE="$1"
    case "$FILE" in
      *.tar.bz2|*.tbz2) shift && tar cvjf "$FILE" $* ;;
      *.tar.gz|*.tgz)   shift && tar cvzf "$FILE" $* ;;
      *.tar)            shift && tar cvf "$FILE" $* ;;
      *.zip)            shift && zip "$FILE" $* ;;
      *.rar)            shift && rar "$FILE" $* ;;
      *.7z)             shift && 7zr a "$FILE" $* ;;
      *)                echo "'$1' cannot be rolled via roll()" ;;
    esac
  else
    echo "usage: roll [file] [contents]"
  fi
}


#
# XPath
#
xpath() {
    if [ $# -ne 2 ]
    then
       echo Usage: xpath xpath file
       return 1
    fi
    xmllint --format --shell $2 <<< "cat $1" | sed '/^\/ >/d'
}

#
# Sorts the given files before diffing
#
diffsort(){
    if [ $# -lt 2 ]; then
        echo "Usage: diffsort file1 file2"
        return 1
    fi
    diff -wb <(sort $1) <(sort $2)    
}

#-------------------------------
# Directory Bookmark Functions
#-------------------------------

#
# Add a bookmark, if it doesn't exist
#
bm(){
  local val=$(pwd)
  for i in ${bookmarks[@]}
  do
     if [ "$i" == "$val" ]
     then
         return 1
     fi
  done
  num=${#bookmarks[@]}
  bookmarks[$num]=$val
}

#
# Goto specified bookmark
# or previous one by default
#
bcd(){
  index=$1
  if [ -z $index ]
  then
      index=$((${#bookmarks[@]}-1))
  fi
  local val=${bookmarks[$index]}
  if [ -z $val ]
  then
      echo "No such bookmark. Type blist to list bookmarks."
      return 1
  else
      cd "$val"
  fi
}

#
# Remove a bookmark
#
brm(){
  if [ $# -lt 1 ]
  then
      echo "Usage: brm <bookmark-index>"
      return 1
  fi
  if [ -z ${bookmarks[$1]} ]
  then
      echo "No such bookmark"
      return 1
  fi
  bookmarks=(${bookmarks[@]:0:$1} ${bookmarks[@]:$(($1 + 1))})  
}

#
# Remove all bookmarks
#
bcl(){
    bookmarks=()
}

#
# List all bookmarks
#
bll(){
    if [ ${#bookmarks[@]} -ne 0 ]
    then
        local i=0
        while [ $i -lt ${#bookmarks[@]} ]
        do
            echo $i: ${bookmarks[$i]}
            ((i++))
        done        
    fi
    return 0
}

#-------------------------------
# String manipulation functions
#-------------------------------

#
# substring word start [length]
#
substring(){
    if [ $# -lt 2 ]; then
        echo "Usage: substring word start [length]"
        return 1
    fi
    if [ -z $3 ]
    then
        echo ${1:$2}
    else
        echo ${1:$2:$3}
    fi    
}

#
# length of string
#
length(){
    if [ $# -lt 1 ]; then
        echo "Usage: length word"
        return 1
    fi    
    echo ${#1}
}

#
# replace part of string with another
#
replace(){
    if [ $# -ne 3 ]; then
        echo "Usage: replace string substring replacement"
        return 1
    fi    
    echo ${1/$2/$3}
}

#
# replace all parts of a string with another
#
replaceAll(){
    if [ $# -ne 3 ]; then
        echo "Usage: replace string substring replacement"
        return 1
    fi    
    echo ${1//$2/$3}
}

#
# find index of specified string
#
index(){
    if [ $# -ne 2 ]; then
        echo "Usage: index string substring"
        return 1
    fi    
    expr index $1 $2
}

#
# Upper-case
#
upper(){
    if [ $# -lt 1 ]; then
        echo "Usage: upper word"
        return 1
    fi    
    echo ${@^^}
}

#
# Lower-case
#
lower(){
    if [ $# -lt 1 ]; then
        echo "Usage: lower word"
        return 1
    fi    
    echo ${@,,}
}

#
# surround string with quotes, for example.
#
surround () { 
   if [ $# -ne 2 ]
   then
     echo Usage: surround string surround-with e.g. surround hello \\\"
     return 1
   fi
   echo $1 | sed "s/^/$2/;s/$/$2/" ; 
}