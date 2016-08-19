# If not running interactively, don't do anything


export EDITOR=vim
export GIT_EDITOR=vim



LOKI_DEFAULT_COLOR="[00m"
LOKI_GRAY_COLOR="[37m"
LOKI_PINK_COLOR="[35m"
LOKI_GREEN_COLOR="[32m"
LOKI_ORANGE_COLOR="[33m"
LOKI_RED_COLOR="[31m"
if [ `id -u` == '0' ]; then
  LOKI_USER_COLOR=$LOKI_RED_COLOR
else
  LOKI_USER_COLOR=$LOKI_PINK_COLOR
fi

LOKI_VC_PROMPT=$' on \033[34m%n\033[00m:\033[00m%[unknown]b\033[32m'
LOKI_VC_PROMPT_EX="$LOKI_VC_PROMPT%m%u"



mitsuhikos_virtualenv() {
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

export LOKI_BASEPROMPT='\e]0;\007\e${LOKI_USER_COLOR}\u \
\e${LOKI_GRAY_COLOR}at \e${LOKI_ORANGE_COLOR}\h \
\e${LOKI_GRAY_COLOR}in \e${LOKI_GREEN_COLOR}\w\
`mitsuhikos_virtualenv`\
\e${LOKI_DEFAULT_COLOR}'
export PS1="\[\033[G\]${LOKI_BASEPROMPT}
$ "

export TERM=xterm-256color
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1

if [ -f /usr/local/git/contrib/completion ]; then
  . /usr/local/git/contrib/completion/git-completion.bash
fi
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi


. ~/.bash_aliases

