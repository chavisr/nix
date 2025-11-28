#!/bin/sh
mkdir -p ~/.config/nix && echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf
nix run github:nix-community/home-manager --switch --flake .#chavi -b backup

