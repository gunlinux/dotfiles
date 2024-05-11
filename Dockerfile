# Dockerfile - this is a comment. Delete me if you want.
FROM debian:11
WORKDIR /root
RUN apt-get update 

RUN apt-get install make curl ca-certificates git  unzip wget python3-pip python3-venv gcc -y # npm  
RUN update-ca-certificates
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get update 
RUN apt install nodejs -y
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz && tar -C /opt -xzf nvim-linux64.tar.gz  && ln -sf /opt/nvim-linux64/bin/nvim /usr/bin/nvim
COPY  . /root/dotfiles
RUN bash /root/dotfiles/go.sh 
RUN npm install -g tree-sitter
RUN python3 -m pip install neovim
ENV LANG=en_US.UTF-8

ENTRYPOINT ["/bin/bash"]
