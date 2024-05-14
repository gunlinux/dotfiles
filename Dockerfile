# Dockerfile - this is a comment. Delete me if you want.
FROM alpine 
ENV LANG=en_US.UTF-8
ENV DOCKER=1

WORKDIR /root

RUN apk update && apk add --no-cache gzip make curl git unzip wget py3-pip py3-virtualenv gcc tmux ripgrep fd bash neovim libc-dev

# Node js install
RUN apk add --no-cache nodejs npm --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/main --allow-untrusted && python3 -m pip install --no-cache-dir  neovim --break-system-packages && rm -rf /var/cache/apk/*
COPY  . /root/dotfiles

RUN bash /root/dotfiles/go.sh

ENTRYPOINT ["/bin/bash"]
