# Dockerfile - this is a comment. Delete me if you want.
FROM node:23-alpine3.21
ENV LANG=en_US.UTF-8
ENV DOCKER=1
# delve (the Go debugger mason installs) needs go >= 1.24; alpine ships go 1.23
# and defaults GOTOOLCHAIN=local, which refuses to build it. "auto" lets go
# fetch the newer toolchain on demand so :MasonInstall delve succeeds.
ENV GOTOOLCHAIN=auto

WORKDIR /root

# @community = edge/community (neovim 0.12, starship); @edge = edge/main for a
# current rust/cargo. blink.cmp's fuzzy lib needs the edition2024 Cargo feature
# (stable since Cargo 1.85); alpine 3.21's packaged cargo is 1.83 and fails the
# from-source build, leaving blink on its slow Lua matcher.
RUN printf '%s\n' \
      "@community https://dl-cdn.alpinelinux.org/alpine/edge/community" \
      "@edge https://dl-cdn.alpinelinux.org/alpine/edge/main" \
      >> /etc/apk/repositories
RUN apk update && apk add --no-cache git neovim@community starship@community py3-pip py3-virtualenv gcc tmux ripgrep fd bash libc-dev wget unzip curl go gzip ruff rust@edge cargo@edge && rm -rf /var/cache/apk/* /root/.cache
COPY  . /root/dotfiles

RUN bash /root/dotfiles/go.sh

CMD ["/bin/bash"]
