VERSION := 0.0.5

all: docker-build docker docker-shell

live: docker-build docker-live docker-shell-live

docker-build:
	docker build . --tag="dotfiles:$(VERSION)"

docker:
	-docker stop dotfiles
	-docker rm dotfiles
	docker run -d --name dotfiles dotfiles:$(VERSION)

docker-shell:
	docker run -it dotfiles:$(VERSION)

docker-live:
	docker stop dotfiles
	docker rm dotfiles
	docker run -d --volume .:/root/dotfiles --name dotfiles dotfiles:$(VERSION)

docker-shell-live:
	docker run --volume .:/root/dotfiles -it dotfiles:$(VERSION)
