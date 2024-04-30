
alias ..='cd ..'


# for the lulz
alias bitch,=sudo


alias nginx.start='sudo launchctl load /Library/LaunchDaemons/homebrew.mxcl.nginx.plist'
alias nginx.stop='sudo launchctl unload /Library/LaunchDaemons/homebrew.mxcl.nginx.plist'
alias nginx.restart='nginx.stop && nginx.start'


alias ls="ls -G"


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
alias online="watch -n 3 -t ~/projects/viewer/venv/bin/python3 ~/projects/viewer/view.py"
