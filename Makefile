VERSION := 0.0.9

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

# ── Neovim config test (isolated, glibc base with Neovim 0.12) ──────────────
nvim-test: nvim-build nvim-shell

nvim-build:
	docker build -f Dockerfile.nvim . --tag="dotfiles-nvim:$(VERSION)"

nvim-shell:
	docker run --rm -it dotfiles-nvim:$(VERSION)

# Live-mount the config for editing; plugins still come from the baked image.
nvim-shell-live:
	docker run --rm --volume ./nvim:/root/.config/nvim -it dotfiles-nvim:$(VERSION)
