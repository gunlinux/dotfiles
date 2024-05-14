all: docker-build docker docker-shell

live: docker-build docker-live docker-shell-live

docker-build:
	docker build . --tag="dotfiles:0.0.4"

docker:
	-docker stop dotfiles
	-docker rm dotfiles
	docker run -d --name dotfiles dotfiles:0.0.4

docker-shell:
	docker run -it dotfiles:0.0.4

docker-live:
	-docker stop dotfiles
	-docker rm dotfiles
	docker run -d --volume .:/root/dotfiles --name dotfiles dotfiles:0.0.4

docker-shell-live:
	docker run --volume .:/root/dotfiles -it dotfiles:0.0.4

