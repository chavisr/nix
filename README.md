# Nix

```bash
# install nix
curl -L https://nixos.org/nix/install | sh
mkdir -p ~/.config/nix && echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf
source ~/.nix-profile/etc/profile.d/nix.sh

# clone dots
git clone https://github.com/chavisr/dotfiles

# enjoy :) 
nix run github:nix-community/home-manager -- switch --flake .#chavi -b backup
# or
nix run github:nix-community/home-manager -- switch --flake github:chavisr/nix#chavi -b backup --no-write-lock-file
```
