# If not running interactively, don't do anything
[ -z "$PS1" ] && return

reset="\[$(tput sgr0)\]"   # \e[0m
__DEFAULT_COLOR="\[\e[00m\]"
__GRAY_COLOR="\[\e[37m\]"
__PINK_COLOR="\[\e[35m\]"
__GREEN_COLOR="\[\e[32m\]"
__ORANGE_COLOR="\[\e[33m\]"
__RED_COLOR="\[\e[31m\]"
__BLUE_COLOR="\[\e[34m\]"


if [ `id -u` == '0' ]; then
  __USER_COLOR=$__RED_COLOR
  __END="${__RED_COLOR}#${reset}"
else
  __USER_COLOR=$__PINK_COLOR
  __END="${__BLUE_COLOR}\$${reset}"
fi

# Completions
if [ -f /usr/local/git/contrib/completion ]; then
  . /usr/local/git/contrib/completion/git-completion.bash
fi
if [ -f  /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
  .  /usr/share/git-core/contrib/completion/git-prompt.sh
fi

if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

if type -t __git_ps1 | grep -q '^function$' 2>/dev/null; then
  PS_GIT="\$(__git_ps1 \(%s\))$reset ${__END} "
else
  PS_GIT=""
fi
export PS1="${__USER_COLOR}\u${reset}@\
${__ORANGE_COLOR}\h$reset in \
${__GREEN_COLOR}\w$reset $PS_GIT"

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

