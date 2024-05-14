all: docker-build docker docker-shell

docker-build:
	docker build . --tag="dotfiles:0.0.3"

docker:
	-docker stop dotfiles
	-docker rm dotfiles
	docker run -d --name dotfiles dotfiles:0.0.3

docker-shell:
	docker run -it dotfiles:0.0.3

