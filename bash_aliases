
alias ..='cd ..'


# for the lulz
alias bitch,=sudo


alias nginx.start='sudo launchctl load /Library/LaunchDaemons/homebrew.mxcl.nginx.plist'
alias nginx.stop='sudo launchctl unload /Library/LaunchDaemons/homebrew.mxcl.nginx.plist'
alias nginx.restart='nginx.stop && nginx.start'

if [ -x /usr/bin/eza ]; then
  alias ls="EZA_COLORS=\"reset:*.txt=31\" eza --icons --color --git --header"
else
  alias ls="ls --color=auto"
fi


# Lock screen

alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"


# Get local IP

alias local-ip="ipconfig getifaddr en0"   # en0 is typically for ethernet and en1 is typically for wifi. Use ifconfig -a to find out interface name


alias u="sudo softwareupdate --install --all \
            && brew update \
            && brew upgrade --all \
            && brew cleanup \
            && brew cask cleanup \
            && npm update -g \
            && vim +PluginUpdate +qall"

alias github-status="curl https://status.github.com/api/status.json"
alias va="source ./venv/bin/activate"
alias vd="deactivate"
alias vc="python3 -m venv venv"

alias tw="TERM=xterm-kitty twt"
alias off-mon="wlr-randr --output DP-3 --off"
