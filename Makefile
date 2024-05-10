all: docker-build docker docker-shell

run:
	flask db upgrade
	flask run --host="0.0.0.0" --debug

docker-build:
	docker build . --tag="dotfiles:0.0.1"

docker:
	-docker stop dotfiles
	-docker rm dotfiles
	docker run -d --name dotfiles dotfiles:0.0.1

docker-shell:
	docker run -it dotfiles:0.0.1 

