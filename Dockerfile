# Dockerfile - this is a comment. Delete me if you want.
FROM node:23-alpine3.21
ENV LANG=en_US.UTF-8
ENV DOCKER=1

WORKDIR /root

RUN echo "@community https://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk update && apk add --no-cache git neovim@community py3-pip py3-virtualenv gcc tmux ripgrep fd bash libc-dev wget unzip curl go gzip ruff rust cargo && rm -rf /var/cache/apk/* /root/.cache
COPY  . /root/dotfiles

RUN bash /root/dotfiles/go.sh

CMD ["/bin/bash"]
