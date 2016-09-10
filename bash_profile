# If not running interactively, don't do anything


export EDITOR=vim
export GIT_EDITOR=vim

if [ -f /usr/local/git/contrib/completion ]; then
  . /usr/local/git/contrib/completion/git-completion.bash
fi

if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
  . /usr/local/etc/bash_completion.d/git-completion.bash
fi

if [ -f /usr/local/etc/bash_completion.d/git-prompt.sh ]; then
  . /usr/local/etc/bash_completion.d/git-prompt.sh
fi

if [ -f /etc/bash_completion.d/git-prompt ]; then
  . /etc/bash_completion.d/git-prompt
fi

export GIT_PS1_SHOWDIRTYSTATE=1

function prompt {
  local BLUE="\[\033[0;34m\]"
  local DARK_BLUE="\[\033[1;34m\]"
  local RED="\[\033[0;31m\]"
  local DARK_RED="\[\033[1;31m\]"
  local NO_COLOR="\[\033[0m\]"
  local DEFAULT_COLOR="[00m"
  local GRAY_COLOR="[37m"
  local PINK_COLOR="[35m"
  local GREEN_COLOR="[32m"
  local ORANGE_COLOR="[33m"
  local RED_COLOR="[31m"

  if [ `id -u` == '0' ]; then
      USER_COLOR=$RED_COLOR
  else
      USER_COLOR=$PINK_COLOR
  fi

  local RES_PS="\e${DEFAULT_COLOR}"
  local USER_PS="\e${USER_COLOR}\u${RES_PS}"
  local HOST_PS="\e${ORANGE_COLOR}\h${RES_PS}"
  local CWD_PS="\e${GREEN_COLOR}\w${RES_PS}"
  local GIT_PS='$(__git_ps1 "(%s)")'
  export PS1="${USER_PS}@${HOST_PS} ${CWD_PS} ${GIT_PS} \n\$ "
}
prompt


export TERM=xterm-256color
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1
. ~/.bash_aliases

export PATH="/usr/local/bin:$PATH"
