all: docker-build docker docker-shell

docker-build:
	docker build . --tag="dotfiles:0.0.1"

docker:
	-docker stop dotfiles
	-docker rm dotfiles
	docker run -d --name dotfiles dotfiles:0.0.1

docker-shell:
	docker run --privileged -it dotfiles:0.0.1 

