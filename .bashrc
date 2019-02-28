# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

###HISTORY###
PROMPT_COMMAND='history -a'
shopt -s histappend
HISTFILESIZE=1000000
HISTSIZE=1000000
HISTTIMEFORMAT='%F %T '

###ALIASES###

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

#bashrc
alias mybshr='vim ~/.bashrc'
alias Smybshr='. ~/.bashrc'

#shell
alias ..='cd ..'
#git
alias gst='git status'
alias gco='git commit'
alias gdf='git diff'
alias gpl='git pull'
alias gph='git push'
alias gap='git add -p'

alias glo='git log --pretty=format:"%C(yellow)%h%Creset%x09%an%x09%C(cyan)%ad%Creset%x09%s"' 
alias glot='glo --since="0am"'
alias glup='git log @{u}..HEAD --pretty=format:"%h%x09%an%x09%ad%x09%s"'


#docker-compose
alias doco='docker-compose'

#terraform
alias tf='terraform'
alias tfp='terraform plan'
alias tfa='terraform apply'


###Jump to commonly used dir###
function j () {
  case $1 in 
   'repo')
     cd ~/repos;;
   'mooc')
     cd ~/repos/mooc;;
   'dot')
     cd ~/repos/dotfiles;;
   'down')
     cd ~/Downloads;;
  esac
}

###HELPER-FUNCTIONS###
function spwanHelpMsg () {
  echo "Show aliases with 'alias'"
  echo "Show bash shortcuts with 'shrt'"
  echo "Edit ~/.bashrc with 'mybshr'"
  echo "Source ~/.bashrc with 'Smybshr'"
}

function shrt () {
  echo "Bash shortcuts:"
  echo "CTRL+A – Go to the beginning of a line."
  echo "ALT+B – Move one character before the cursor."
  echo "ALT+C – Suspends the running command/process. ..."
  echo "ALT+D – Closes the empty Terminal (I.e it closes the Terminal when there is nothing typed). ..."
  echo "ALT+F – Move forward one character."
  echo "ALT+T – Swaps the last two words."
  echo "ALT+W – Delete word under cursor (pos last letter of word)"
  echo "CTRL+K – Deletets all till end of line from cursor"
  echo "CTRL+U – Deletets all from start of line from cursor"
}

# start ssh-agent if not already loaded
if  ! pgrep ssh-agent; then
  Starting ssh-agent ...
  eval `ssh-agent -s`
 fi

#alter PATH
PATH=$PATH:/opt
PATH=$PATH:~/.asdf/bin:~/.asdf/shims

#pip modules (user mode) e.g. aws-cli
if [ -d "$HOME/.local/bin" ]; then
  PATH=$PATH:~/.local/bin
fi

### asdf version manager (e.g. for installing go)###
# see https://github.com/asdf-vm/asdf
if [ -d "$HOME/.asdf/bin" ]; then
  #PATH=$PATH:~/.asdf/bin:~/.asdf/shims
  $HOME/.asdf/asdf.sh

  if [ -d "$HOME/.asdf/installs/golang" ]; then
    go_version=1.11
    PATH=$PATH:$HOME/.asdf/installs/golang/$go_version/packages/bin
  fi
  $HOME/.asdf/completions/asdf.bash
fi
export GOOS=linux

###BASH HISTORY###

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000


###MISC Stuff

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

###BASH PROMPT####
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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\n\$ '
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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

GIT_PROMPT_ONLY_IN_REPO=1

# https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
source ~/bash-git-prompt/gitprompt.sh


###Call helper functions###
. $HOME/.asdf/asdf.sh
spwanHelpMsg
