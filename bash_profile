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
  local DEFAULT_COLOR="[0m\]"
  local PINK_COLOR="[35m\]"
  local GREEN_COLOR="[32m\]"
  local ORANGE_COLOR="[33m\]"
  local RED_COLOR="[1;31m\]"
  local BLUE_COLOR="[34m\]"
  local C_PS="\[\e[m\]"

  if [ `id -u` == '0' ]; then
      USER_COLOR="\[\e${RED_COLOR}"
      W_PS="${USER_COLOR}#${C_PS} "
  else
      USER_COLOR="\[\e${PINK_COLOR}"
      W_PS="\[\e${BLUE_COLOR}\$${C_PS} "
  fi
  local USER_PS="${USER_COLOR}\u${C_PS}"
  local HOST_PS="\[\e${ORANGE_COLOR}\h${C_PS}"
  local CWD_PS="\[\e${GREEN_COLOR}\w${C_PS}"
  local GIT_PS='$(__git_ps1 "(%s)")'
  export PS1="${USER_PS}@${HOST_PS} ${CWD_PS}${GIT_PS} ${W_PS}"

}
prompt


export TERM=xterm-256color
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

export PATH="/usr/local/bin:$PATH"

