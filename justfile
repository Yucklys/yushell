run:
	quickshell -p .

dev:
	nix develop

build:
	nix build

update:
	nix flake update