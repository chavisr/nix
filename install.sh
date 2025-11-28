#!/bin/bash

set -euo | pipefail

curl -L https://nixos.org/nix/install | sh
mkdir -p ~/.config/nix && echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf
nix profile add github:nix-community/home-manager
