# If not running interactively, don't do anything
[ -z "$PS1" ] && return


__DEFAULT_COLOR="[00m"
__GRAY_COLOR="[37m"
__PINK_COLOR="[35m"
__GREEN_COLOR="[32m"
__ORANGE_COLOR="[33m"
__RED_COLOR="[31m"


if [ `id -u` == '0' ]; then
  __USER_COLOR=$__RED_COLOR
else
  __USER_COLOR=$__PINK_COLOR
fi

__VC_PROMPT=$' on \033[34m%n\033[00m:\033[00m%[unknown]b\033[32m'
__VC_PROMPT_EX="$__VC_PROMPT%m%u"
if hash vcprompt 2> /dev/null; then
  __HAVE_VCPROMPT=1
else
  __HAVE_VCPROMPT=0
fi

vcprompt() {
  path=`pwd`
  prompt="$__VC_PROMPT_EX"
  if [ $__HAVE_VCPROMPT == 1 ]; then
    vcprompt -f "$prompt"
  fi
}

virtualenv() {
  if [ x$VIRTUAL_ENV != x ]; then
    if [[ $VIRTUAL_ENV == *.virtualenvs/* ]]; then
      ENV_NAME=`basename "${VIRTUAL_ENV}"`
    else
      folder=`dirname "${VIRTUAL_ENV}"`
      ENV_NAME=`basename "$folder"`
    fi
    echo -n $' \033[37mworkon \033[31m'
    echo -n $ENV_NAME
    echo -n $'\033[00m'
    # Shell title
    echo -n $'\033]0;venv:'
    echo -n $ENV_NAME
    echo -n $'\007'
  fi

  # Also setup our readline properly constantly since
  # stuff tends to overwrite this.
  stty werase undef
  bind '"\C-w": unix-filename-rubout'
}
function __venv_ps1_icon() {
  [ -n "$VIRTUAL_ENV" ] && echo -ne "\033[38;5;155m${VIRTUAL_ENV_PROMPT}" || echo -ne "\033[38;5;197m"
    echo -en ""
    echo -en "\033[0m"
}

#export __BASEPROMPT='\e]0;\007\n\e${__USER_COLOR}\u\
export __BASEPROMPT='\e]0;\007\e${__USER_COLOR}\u\
\e${__GRAY_COLOR}@\e${__ORANGE_COLOR}\h \
\e${__GRAY_COLOR}in \e${__GREEN_COLOR}\w\
\e${__GRAY_COLOR}`vcprompt`\
`virtualenv`\
\e${__DEFAULT_COLOR}'
#export VIRTUAL_ENV_DISABLE_PROMPT
export PS1="\[\033[G\]${__BASEPROMPT} \[\$(__venv_ps1_icon)\]$ "


# Completions
if [ -f /usr/local/git/contrib/completion ]; then
  . /usr/local/git/contrib/completion/git-completion.bash
fi
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

export GIT_PS1_SHOWDIRTYSTATE=1

export TERM=xterm-256color
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

export PATH="/usr/local/bin:$PATH"
export EDITOR=vim
export GIT_EDITOR=vim

