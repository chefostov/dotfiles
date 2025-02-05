# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# No clutter in the home directory
HISTFILE="$HOME/.local/share/bash/history"

# Append history instead of overwriting
shopt -s histappend

# Infinite session history
HISTSIZE=-1

# Infinite history file
HISTFILESIZE=-1

# Don't store commands that aren't useful in history
HISTIGNORE='exit:history:l:l[1als]:lla:+(.)'

# Ignore commands starting with space, and duplicates
HISTCONTROL='ignoreboth'

# Save each command right after execution
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
# if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
#  debian_chroot=$(cat /etc/debian_chroot)
# fi

# set a fancy prompt (non-color, unless we know we "want" color)
# case "$TERM" in
# xterm-color | *-256color) color_prompt=yes ;;
# esac

# Функция за проверка на Git статус
git_branch_status() {
  # Проверяваме дали сме в Git репо
  if git rev-parse --git-dir >/dev/null 2>&1; then
    # Вземаме името на текущия бранч
    branch=$(git symbolic-ref --short HEAD 2>/dev/null)

    # Проверяваме за промени (ако има, добавяме символ )
    if [ -n "$(git status --porcelain)" ]; then
      echo "$branch  " # Променен бранч с иконка
    else
      echo "$branch " # Чист бранч, без промени
    fi
  fi
}

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

#if [ -n "$force_color_prompt" ]; then
#  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
# We have color support; assume it's compliant with Ecma-48
# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
# a case would tend to support setf rather than setaf.)
#    color_prompt=yes
#  else
#    color_prompt=
#  fi
# fi

#if [ "$color_prompt" = yes ]; then
PS1='$(git_branch_status)\[\e[1m\]\W\[\e[0m\] \[\e[38;5;161m\]󱋴\[\e[0m\]  '
#else
#  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
# unset color_prompt force_color_prompt

# Function to format the full path with each directory in its own block
format_path() {
  local IFS='/'
  local path_elements=($PWD)
  local formatted_path=""
  for element in "${path_elements[@]}"; do
    formatted_path+="\[\e[38;5;235m\]\[\e[48;5;230m\] $element \[\e[0m\]"
  done
  echo -e "$formatted_path"
}

# If the terminal is xterm, set the title
case "$TERM" in
  xterm* | rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
  *) ;;
esac


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'
  #alias grep='grep --color=auto'
  #alias fgrep='fgrep --color=auto'
  #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='exa -lah --color=always --group-directories-first --icons'
alias ls='exa -a --color=always --group-directories-first --icons'
alias most='cat $HOME/.local/share/bash/history| sort |uniq -c|sort -nr|head -n 10'
alias meminfo='free -m -l -t'   # Показва информация за използваната памет
alias duh='du -h --max-depth=1' # Показване на размера на директориите
alias dotfiles='cd ~/repos/dotfiles'
alias menos='less -R'
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -R '

# Търсене в bash историята
hist_search() {
  history | grep "$1" | less
}

# Стартиране на бележките с неовим и лейф греп
alias hs='hist_search'

function notes() {
  cd $HOME/doc/notes || return
  nvim +'lua require("telescope.builtin").live_grep()'
}

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
