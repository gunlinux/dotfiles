# Dockerfile - this is a comment. Delete me if you want.
FROM debian:11
ENV LANG=en_US.UTF-8
WORKDIR /root
RUN apt-get update && apt-get install make curl ca-certificates git  unzip wget python3-pip python3-venv gcc tmux ripgrep fd-find -y && update-ca-certificates
# Node js install
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - && apt-get update && apt install nodejs -y
RUN npm install -g tree-sitter-cli
RUN python3 -m pip install neovim
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz && tar -C /opt -xzf nvim-linux64.tar.gz  && ln -sf /opt/nvim-linux64/bin/nvim /usr/bin/nvim
COPY  . /root/dotfiles
RUN DOCKER=1 bash /root/dotfiles/go.sh

ENTRYPOINT ["/bin/bash"]
